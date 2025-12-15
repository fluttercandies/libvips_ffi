#!/usr/bin/env python3
"""Fix dylib dependencies to use full version names instead of short names.

This is needed because Xcode doesn't copy symlinks, only real files.
"""

import os
import subprocess
import sys
from pathlib import Path


def get_dylib_deps(dylib_path: str) -> list[str]:
    """Get @rpath dependencies of a dylib."""
    result = subprocess.run(
        ["otool", "-L", dylib_path],
        capture_output=True,
        text=True,
    )
    deps = []
    for line in result.stdout.split("\n"):
        if "@rpath/" in line:
            dep = line.strip().split()[0].replace("@rpath/", "")
            deps.append(dep)
    return deps


def get_install_name(dylib_path: str) -> str:
    """Get the install name of a dylib."""
    result = subprocess.run(
        ["otool", "-D", dylib_path],
        capture_output=True,
        text=True,
    )
    lines = result.stdout.strip().split("\n")
    if len(lines) >= 2:
        return lines[-1].strip()
    return ""


def build_name_map(lib_dir: Path) -> dict[str, str]:
    """Build a mapping from short names to full names."""
    name_map = {}
    
    for dylib in lib_dir.glob("*.dylib"):
        if dylib.is_symlink():
            continue
        
        base = dylib.name
        name = base.replace(".dylib", "")
        parts = name.split(".")
        
        # Create mappings for shorter versions
        # e.g., libwebp.7.1.10.dylib -> libwebp.7.dylib, libwebp.7.1.dylib
        for i in range(2, len(parts)):
            short_name = ".".join(parts[:i]) + ".dylib"
            name_map[short_name] = base
    
    return name_map


def fix_dylib(dylib_path: Path, name_map: dict[str, str]) -> bool:
    """Fix a dylib's dependencies. Returns True if modified."""
    modified = False
    base = dylib_path.name
    
    # Fix dependencies
    deps = get_dylib_deps(str(dylib_path))
    for dep in deps:
        if dep in name_map and dep != name_map[dep]:
            full_name = name_map[dep]
            print(f"  Fixing: @rpath/{dep} -> @rpath/{full_name}")
            subprocess.run([
                "install_name_tool", "-change",
                f"@rpath/{dep}", f"@rpath/{full_name}",
                str(dylib_path)
            ], check=True)
            modified = True
    
    # Fix install name if needed
    install_name = get_install_name(str(dylib_path))
    if install_name:
        install_base = os.path.basename(install_name)
        if install_base in name_map and install_base != name_map[install_base]:
            full_name = name_map[install_base]
            print(f"  Fixing install name: @rpath/{install_base} -> @rpath/{full_name}")
            subprocess.run([
                "install_name_tool", "-id",
                f"@rpath/{full_name}",
                str(dylib_path)
            ], check=True)
            modified = True
    
    return modified


def main():
    lib_dir = Path(sys.argv[1] if len(sys.argv) > 1 else 
                   "/Users/cai/code/flutter/self/libvips_ffi/packages/libvips_ffi_macos/macos/Libraries/arm64")
    
    print(f"Fixing dylib dependencies in: {lib_dir}")
    
    name_map = build_name_map(lib_dir)
    print(f"Found {len(name_map)} short name mappings")
    
    modified_count = 0
    for dylib in sorted(lib_dir.glob("*.dylib")):
        if dylib.is_symlink():
            continue
        
        print(f"Processing: {dylib.name}")
        if fix_dylib(dylib, name_map):
            modified_count += 1
    
    print(f"\nModified {modified_count} dylibs")
    
    # Re-sign all dylibs
    print("\nRe-signing all dylibs...")
    for dylib in lib_dir.glob("*.dylib"):
        if dylib.is_symlink():
            continue
        subprocess.run(
            ["codesign", "--force", "--sign", "-", str(dylib)],
            capture_output=True,
        )
    
    print("Done!")


if __name__ == "__main__":
    main()
