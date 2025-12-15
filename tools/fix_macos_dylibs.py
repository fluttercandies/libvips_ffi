#!/usr/bin/env python3
"""Fix macOS dylib files for distribution.

This script:
1. Fixes dylib dependencies to use full version names (for arm64)
2. Re-signs all dylib files with ad-hoc signature

Run this script after updating the pre-compiled libraries.
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


def fix_dylib_deps(dylib_path: Path, name_map: dict[str, str]) -> bool:
    """Fix a dylib's dependencies. Returns True if modified."""
    modified = False
    
    # Fix dependencies
    deps = get_dylib_deps(str(dylib_path))
    for dep in deps:
        if dep in name_map and dep != name_map[dep]:
            full_name = name_map[dep]
            print(f"    Fixing dep: @rpath/{dep} -> @rpath/{full_name}")
            subprocess.run([
                "install_name_tool", "-change",
                f"@rpath/{dep}", f"@rpath/{full_name}",
                str(dylib_path)
            ], check=True, capture_output=True)
            modified = True
    
    # Fix install name if needed
    install_name = get_install_name(str(dylib_path))
    if install_name:
        install_base = os.path.basename(install_name)
        if install_base in name_map and install_base != name_map[install_base]:
            full_name = name_map[install_base]
            print(f"    Fixing id: @rpath/{install_base} -> @rpath/{full_name}")
            subprocess.run([
                "install_name_tool", "-id",
                f"@rpath/{full_name}",
                str(dylib_path)
            ], check=True, capture_output=True)
            modified = True
    
    return modified


def sign_dylib(dylib_path: Path) -> bool:
    """Sign a dylib with ad-hoc signature. Returns True if successful."""
    result = subprocess.run(
        ["codesign", "--force", "--sign", "-", str(dylib_path)],
        capture_output=True,
    )
    return result.returncode == 0


def verify_signature(dylib_path: Path) -> bool:
    """Verify dylib signature."""
    result = subprocess.run(
        ["codesign", "-v", str(dylib_path)],
        capture_output=True,
    )
    return result.returncode == 0


def process_arch_dir(lib_dir: Path) -> tuple[int, int, int]:
    """Process all dylibs in an architecture directory.
    
    Returns: (total_files, deps_fixed, signed)
    """
    if not lib_dir.exists():
        print(f"  Directory not found: {lib_dir}")
        return 0, 0, 0
    
    # Get all real dylib files (not symlinks)
    dylibs = [f for f in lib_dir.glob("*.dylib") if not f.is_symlink()]
    total = len(dylibs)
    
    if total == 0:
        print(f"  No dylib files found")
        return 0, 0, 0
    
    print(f"  Found {total} dylib files")
    
    # Build name map for dependency fixing
    name_map = build_name_map(lib_dir)
    print(f"  Found {len(name_map)} short name mappings")
    
    deps_fixed = 0
    signed = 0
    
    for dylib in sorted(dylibs):
        print(f"  Processing: {dylib.name}")
        
        # Fix dependencies if needed
        if fix_dylib_deps(dylib, name_map):
            deps_fixed += 1
        
        # Sign the dylib
        if sign_dylib(dylib):
            signed += 1
        else:
            print(f"    WARNING: Failed to sign {dylib.name}")
    
    return total, deps_fixed, signed


def main():
    # Default to libvips_ffi_macos Libraries directory
    base_dir = Path(sys.argv[1] if len(sys.argv) > 1 else 
                    "/Users/cai/code/flutter/self/libvips_ffi/packages/libvips_ffi_macos/macos/Libraries")
    
    print(f"Fixing macOS dylibs in: {base_dir}")
    print()
    
    total_files = 0
    total_deps_fixed = 0
    total_signed = 0
    
    # Process each architecture
    for arch in ["arm64", "x86_64"]:
        arch_dir = base_dir / arch
        print(f"=== Processing {arch} ===")
        
        files, deps_fixed, signed = process_arch_dir(arch_dir)
        total_files += files
        total_deps_fixed += deps_fixed
        total_signed += signed
        
        print()
    
    print("=== Summary ===")
    print(f"Total files processed: {total_files}")
    print(f"Dependencies fixed: {total_deps_fixed}")
    print(f"Files signed: {total_signed}")
    
    # Verify all signatures
    print()
    print("=== Verifying signatures ===")
    failed = 0
    for arch in ["arm64", "x86_64"]:
        arch_dir = base_dir / arch
        if not arch_dir.exists():
            continue
        for dylib in arch_dir.glob("*.dylib"):
            if dylib.is_symlink():
                continue
            if not verify_signature(dylib):
                print(f"  FAILED: {arch}/{dylib.name}")
                failed += 1
    
    if failed == 0:
        print("  All signatures valid!")
    else:
        print(f"  {failed} files have invalid signatures")
        sys.exit(1)
    
    print()
    print("Done!")


if __name__ == "__main__":
    main()
