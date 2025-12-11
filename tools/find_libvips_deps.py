#!/usr/bin/env python3
"""
Find libvips library and all its dependencies.

查找 libvips 库及其所有依赖库的本地路径，方便复制出来作为预编译。

Supports:
- macOS: Homebrew, MacPorts (arm64/x86_64)
- Linux: apt, dnf, pacman (x86_64/aarch64)
- Windows: vcpkg, Chocolatey, official releases (x64)

Usage:
    # Show all dependencies
    python tools/find_libvips_deps.py
    
    # Export to JSON
    python tools/find_libvips_deps.py --output output/libvips_deps.json
    
    # Copy libraries to directory
    python tools/find_libvips_deps.py --copy-to output/libs/
    
    # Copy and fix library paths (macOS)
    python tools/find_libvips_deps.py --copy-to output/libs/ --fix-paths
    
    # Generate shell script for copying
    python tools/find_libvips_deps.py --generate-script output/copy_libs.sh
"""

import argparse
import json
import os
import platform
import re
import shutil
import stat
import subprocess
from pathlib import Path
from typing import Dict, List, Optional, Set, Tuple


def get_platform() -> str:
    """Get current platform."""
    system = platform.system().lower()
    if system == 'darwin':
        return 'macos'
    elif system == 'linux':
        return 'linux'
    elif system == 'windows':
        return 'windows'
    return system


def run_command(cmd: List[str], check: bool = False) -> Tuple[int, str, str]:
    """Run a command and return (returncode, stdout, stderr)."""
    try:
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            check=check
        )
        return result.returncode, result.stdout, result.stderr
    except FileNotFoundError:
        return -1, '', f'Command not found: {cmd[0]}'
    except subprocess.CalledProcessError as e:
        return e.returncode, e.stdout, e.stderr


class LibraryFinder:
    """Base class for finding libraries."""
    
    def __init__(self):
        self.platform = get_platform()
        self.libraries: Dict[str, str] = {}  # name -> path
        self.dependencies: Dict[str, List[str]] = {}  # lib -> [deps]
    
    def find_libvips(self) -> Optional[str]:
        """Find libvips library path."""
        raise NotImplementedError
    
    def find_dependencies(self, lib_path: str) -> List[str]:
        """Find dependencies of a library."""
        raise NotImplementedError
    
    def collect_all_deps(self, lib_path: str, visited: Set[str] = None) -> Dict[str, str]:
        """Recursively collect all dependencies."""
        if visited is None:
            visited = set()
        
        if lib_path in visited:
            return {}
        visited.add(lib_path)
        
        result = {}
        lib_name = Path(lib_path).name
        result[lib_name] = lib_path
        
        deps = self.find_dependencies(lib_path)
        self.dependencies[lib_name] = [Path(d).name for d in deps]
        
        for dep in deps:
            if dep and Path(dep).exists():
                result.update(self.collect_all_deps(dep, visited))
        
        return result
    
    def run(self) -> Dict[str, any]:
        """Run the finder and return results."""
        libvips_path = self.find_libvips()
        if not libvips_path:
            return {'error': 'libvips not found', 'platform': self.platform}
        
        self.libraries = self.collect_all_deps(libvips_path)
        
        return {
            'platform': self.platform,
            'libvips_path': libvips_path,
            'libraries': self.libraries,
            'dependencies': self.dependencies,
            'total_count': len(self.libraries),
            'total_size': sum(Path(p).stat().st_size for p in self.libraries.values() if Path(p).exists())
        }


class MacOSFinder(LibraryFinder):
    """Find libraries on macOS."""
    
    def __init__(self):
        super().__init__()
        self.homebrew_prefix = self._get_homebrew_prefix()
    
    def _get_homebrew_prefix(self) -> str:
        """Get Homebrew prefix."""
        code, stdout, _ = run_command(['brew', '--prefix'])
        if code == 0:
            return stdout.strip()
        # Default paths
        if platform.machine() == 'arm64':
            return '/opt/homebrew'
        return '/usr/local'
    
    def find_libvips(self) -> Optional[str]:
        """Find libvips on macOS."""
        # Try Homebrew
        code, stdout, _ = run_command(['brew', '--prefix', 'vips'])
        if code == 0:
            vips_prefix = stdout.strip()
            lib_path = Path(vips_prefix) / 'lib' / 'libvips.dylib'
            if lib_path.exists():
                return str(lib_path.resolve())
        
        # Try common paths
        common_paths = [
            f'{self.homebrew_prefix}/lib/libvips.dylib',
            '/usr/local/lib/libvips.dylib',
            '/opt/homebrew/lib/libvips.dylib',
        ]
        for path in common_paths:
            if Path(path).exists():
                return str(Path(path).resolve())
        
        return None
    
    def find_dependencies(self, lib_path: str) -> List[str]:
        """Find dependencies using otool."""
        code, stdout, _ = run_command(['otool', '-L', lib_path])
        if code != 0:
            return []
        
        deps = []
        lines = stdout.strip().split('\n')[1:]  # Skip first line (library itself)
        
        for line in lines:
            line = line.strip()
            if not line:
                continue
            # Extract path (before " (compatibility version")
            match = re.match(r'^\s*(.+?)\s+\(', line)
            if match:
                dep_path = match.group(1)
                # Skip system libraries
                if dep_path.startswith('/usr/lib/') or dep_path.startswith('/System/'):
                    continue
                # Resolve @rpath, @loader_path, @executable_path
                if dep_path.startswith('@'):
                    resolved = self._resolve_at_path(dep_path, lib_path)
                    if resolved:
                        deps.append(resolved)
                elif Path(dep_path).exists():
                    deps.append(str(Path(dep_path).resolve()))
        
        return deps
    
    def _resolve_at_path(self, dep_path: str, lib_path: str) -> Optional[str]:
        """Resolve @rpath, @loader_path, @executable_path."""
        lib_dir = Path(lib_path).parent
        
        if dep_path.startswith('@loader_path/'):
            resolved = lib_dir / dep_path.replace('@loader_path/', '')
            if resolved.exists():
                return str(resolved.resolve())
        
        if dep_path.startswith('@rpath/'):
            # Try common rpath locations
            name = dep_path.replace('@rpath/', '')
            search_paths = [
                lib_dir / name,
                lib_dir.parent / 'lib' / name,
                Path(self.homebrew_prefix) / 'lib' / name,
            ]
            for path in search_paths:
                if path.exists():
                    return str(path.resolve())
        
        return None


class LinuxFinder(LibraryFinder):
    """Find libraries on Linux."""
    
    def find_libvips(self) -> Optional[str]:
        """Find libvips on Linux."""
        # Try ldconfig
        code, stdout, _ = run_command(['ldconfig', '-p'])
        if code == 0:
            for line in stdout.split('\n'):
                if 'libvips.so' in line:
                    match = re.search(r'=>\s*(.+)$', line)
                    if match:
                        return match.group(1).strip()
        
        # Try pkg-config
        code, stdout, _ = run_command(['pkg-config', '--variable=libdir', 'vips'])
        if code == 0:
            lib_dir = stdout.strip()
            lib_path = Path(lib_dir) / 'libvips.so'
            if lib_path.exists():
                return str(lib_path.resolve())
        
        # Try common paths
        common_paths = [
            '/usr/lib/x86_64-linux-gnu/libvips.so',
            '/usr/lib64/libvips.so',
            '/usr/lib/libvips.so',
            '/usr/local/lib/libvips.so',
        ]
        for path in common_paths:
            p = Path(path)
            if p.exists():
                return str(p.resolve())
            # Try with version suffix
            for versioned in p.parent.glob(f'{p.name}.*'):
                if versioned.exists():
                    return str(versioned.resolve())
        
        return None
    
    def find_dependencies(self, lib_path: str) -> List[str]:
        """Find dependencies using ldd."""
        code, stdout, _ = run_command(['ldd', lib_path])
        if code != 0:
            return []
        
        deps = []
        for line in stdout.split('\n'):
            line = line.strip()
            if not line or 'not found' in line:
                continue
            # Format: libname.so => /path/to/lib.so (0x...)
            match = re.search(r'=>\s*(/\S+)', line)
            if match:
                dep_path = match.group(1)
                # Skip system libraries
                if dep_path.startswith('/lib/') or dep_path.startswith('/lib64/'):
                    # Keep some important ones
                    if not any(x in dep_path for x in ['libc.so', 'libm.so', 'libpthread', 'libdl', 'ld-linux']):
                        deps.append(dep_path)
                elif Path(dep_path).exists():
                    deps.append(dep_path)
        
        return deps


class WindowsFinder(LibraryFinder):
    """Find libraries on Windows."""
    
    def find_libvips(self) -> Optional[str]:
        """Find libvips on Windows."""
        # Try vcpkg
        vcpkg_root = os.environ.get('VCPKG_ROOT', '')
        if vcpkg_root:
            vcpkg_paths = [
                Path(vcpkg_root) / 'installed' / 'x64-windows' / 'bin' / 'vips.dll',
                Path(vcpkg_root) / 'installed' / 'x64-windows' / 'bin' / 'libvips-42.dll',
            ]
            for path in vcpkg_paths:
                if path.exists():
                    return str(path)
        
        # Try Chocolatey
        choco_paths = [
            Path('C:/tools/vips/bin/libvips-42.dll'),
            Path('C:/ProgramData/chocolatey/lib/vips/tools/vips-dev-w64-all/bin/libvips-42.dll'),
        ]
        for path in choco_paths:
            if path.exists():
                return str(path)
        
        # Try PATH
        code, stdout, _ = run_command(['where', 'libvips-42.dll'])
        if code == 0 and stdout.strip():
            return stdout.strip().split('\n')[0]
        
        return None
    
    def find_dependencies(self, lib_path: str) -> List[str]:
        """Find dependencies using dumpbin or Dependencies."""
        # Try dumpbin (Visual Studio)
        code, stdout, _ = run_command(['dumpbin', '/dependents', lib_path])
        if code == 0:
            deps = []
            lib_dir = Path(lib_path).parent
            in_deps = False
            for line in stdout.split('\n'):
                line = line.strip()
                if 'Image has the following dependencies' in line:
                    in_deps = True
                    continue
                if in_deps and line.endswith('.dll'):
                    dep_path = lib_dir / line
                    if dep_path.exists():
                        deps.append(str(dep_path))
            return deps
        
        # Fallback: scan same directory for DLLs
        lib_dir = Path(lib_path).parent
        return [str(p) for p in lib_dir.glob('*.dll') if p.name != Path(lib_path).name]


def get_finder() -> LibraryFinder:
    """Get the appropriate finder for the current platform."""
    plat = get_platform()
    if plat == 'macos':
        return MacOSFinder()
    elif plat == 'linux':
        return LinuxFinder()
    elif plat == 'windows':
        return WindowsFinder()
    else:
        raise RuntimeError(f'Unsupported platform: {plat}')


def format_size(size_bytes: int) -> str:
    """Format bytes to human readable string."""
    if size_bytes >= 1024 * 1024:
        return f'{size_bytes / (1024 * 1024):.2f} MB'
    elif size_bytes >= 1024:
        return f'{size_bytes / 1024:.2f} KB'
    return f'{size_bytes} B'


def print_results(results: Dict):
    """Print results to console."""
    print('=' * 70)
    print(f' libvips Dependencies Finder')
    print(f' Platform: {results["platform"]}')
    print('=' * 70)
    
    if 'error' in results:
        print(f'\nError: {results["error"]}')
        return
    
    print(f'\nlibvips path: {results["libvips_path"]}')
    print(f'Total libraries: {results["total_count"]}')
    print(f'Total size: {format_size(results["total_size"])}')
    
    print('\n' + '-' * 70)
    print(' Libraries')
    print('-' * 70)
    
    for name, path in sorted(results['libraries'].items()):
        size = Path(path).stat().st_size if Path(path).exists() else 0
        print(f'  {name:<40} {format_size(size):>10}')
        print(f'    {path}')
    
    print('\n' + '-' * 70)
    print(' Dependency Tree')
    print('-' * 70)
    
    for lib, deps in sorted(results['dependencies'].items()):
        if deps:
            print(f'  {lib}:')
            for dep in deps[:5]:  # Limit to first 5
                print(f'    -> {dep}')
            if len(deps) > 5:
                print(f'    ... and {len(deps) - 5} more')


def copy_libraries(results: Dict, dest_dir: str, fix_paths: bool = False):
    """Copy all libraries to destination directory."""
    dest = Path(dest_dir)
    dest.mkdir(parents=True, exist_ok=True)
    
    plat = results.get('platform', get_platform())
    arch = platform.machine()
    
    print(f'\nCopying libraries to {dest}...')
    print(f'Platform: {plat}, Architecture: {arch}')
    
    copied_files = []
    for name, path in results['libraries'].items():
        src = Path(path)
        if src.exists():
            dst = dest / name
            shutil.copy2(src, dst)
            copied_files.append(dst)
            print(f'  Copied: {name}')
    
    # Fix library paths on macOS
    if fix_paths and plat == 'macos':
        print('\nFixing library paths (install_name_tool)...')
        fix_macos_library_paths(dest, copied_files)
    
    # Generate metadata file
    metadata = {
        'platform': plat,
        'architecture': arch,
        'libvips_version': get_libvips_version(results.get('libvips_path', '')),
        'total_count': len(copied_files),
        'total_size': sum(f.stat().st_size for f in copied_files if f.exists()),
        'libraries': [f.name for f in copied_files]
    }
    
    metadata_file = dest / 'metadata.json'
    with open(metadata_file, 'w') as f:
        json.dump(metadata, f, indent=2)
    print(f'\nMetadata saved to: {metadata_file}')
    
    print(f'\nDone! {len(copied_files)} libraries copied.')


def get_libvips_version(libvips_path: str) -> str:
    """Get libvips version from library path or vips command."""
    # Try to extract from path
    match = re.search(r'vips[/-](\d+\.\d+\.\d+)', libvips_path)
    if match:
        return match.group(1)
    
    # Try vips command
    code, stdout, _ = run_command(['vips', '--version'])
    if code == 0:
        match = re.search(r'vips-(\d+\.\d+\.\d+)', stdout)
        if match:
            return match.group(1)
    
    return 'unknown'


def fix_macos_library_paths(dest: Path, libraries: List[Path]):
    """Fix library paths on macOS using install_name_tool."""
    for lib in libraries:
        if not lib.suffix == '.dylib':
            continue
        
        # Change the library's own ID
        new_id = f'@rpath/{lib.name}'
        run_command(['install_name_tool', '-id', new_id, str(lib)])
        
        # Get current dependencies
        code, stdout, _ = run_command(['otool', '-L', str(lib)])
        if code != 0:
            continue
        
        lines = stdout.strip().split('\n')[1:]
        for line in lines:
            match = re.match(r'^\s*(.+?)\s+\(', line)
            if not match:
                continue
            
            old_path = match.group(1)
            dep_name = Path(old_path).name
            
            # Check if this dependency is in our copied libraries
            dep_in_dest = dest / dep_name
            if dep_in_dest.exists() and not old_path.startswith('@'):
                new_path = f'@rpath/{dep_name}'
                run_command(['install_name_tool', '-change', old_path, new_path, str(lib)])
        
        print(f'  Fixed: {lib.name}')


def generate_copy_script(results: Dict, script_path: str):
    """Generate a shell script for copying libraries."""
    plat = results.get('platform', get_platform())
    script = Path(script_path)
    script.parent.mkdir(parents=True, exist_ok=True)
    
    lines = ['#!/bin/bash', '', '# Auto-generated script to copy libvips dependencies', '']
    lines.append(f'# Platform: {plat}')
    lines.append(f'# Architecture: {platform.machine()}')
    lines.append(f'# Total libraries: {results.get("total_count", 0)}')
    lines.append('')
    
    lines.append('DEST_DIR="${1:-.}"')
    lines.append('mkdir -p "$DEST_DIR"')
    lines.append('')
    
    for name, path in sorted(results.get('libraries', {}).items()):
        lines.append(f'cp -v "{path}" "$DEST_DIR/{name}"')
    
    lines.append('')
    lines.append('echo "Done! Libraries copied to $DEST_DIR"')
    
    with open(script, 'w') as f:
        f.write('\n'.join(lines))
    
    # Make executable
    script.chmod(script.stat().st_mode | stat.S_IXUSR | stat.S_IXGRP | stat.S_IXOTH)
    
    print(f'\nScript generated: {script}')
    print(f'Usage: {script} <destination_directory>')


def main():
    parser = argparse.ArgumentParser(
        description='Find libvips library and all its dependencies.',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Show all dependencies
  python find_libvips_deps.py
  
  # Export to JSON
  python find_libvips_deps.py -o output/deps.json
  
  # Copy libraries to directory
  python find_libvips_deps.py -c output/libs/
  
  # Copy and fix library paths (macOS)
  python find_libvips_deps.py -c output/libs/ --fix-paths
  
  # Generate shell script
  python find_libvips_deps.py --generate-script output/copy_libs.sh
"""
    )
    parser.add_argument(
        '--output', '-o',
        help='Output JSON file path'
    )
    parser.add_argument(
        '--copy-to', '-c',
        help='Copy all libraries to this directory'
    )
    parser.add_argument(
        '--fix-paths',
        action='store_true',
        help='Fix library paths after copying (macOS only, uses install_name_tool)'
    )
    parser.add_argument(
        '--generate-script',
        help='Generate a shell script for copying libraries'
    )
    parser.add_argument(
        '--quiet', '-q',
        action='store_true',
        help='Suppress console output'
    )
    
    args = parser.parse_args()
    
    finder = get_finder()
    results = finder.run()
    
    if not args.quiet:
        print_results(results)
    
    if args.output:
        output_path = Path(args.output)
        output_path.parent.mkdir(parents=True, exist_ok=True)
        with open(output_path, 'w') as f:
            json.dump(results, f, indent=2)
        print(f'\nResults saved to: {output_path}')
    
    if args.generate_script and 'libraries' in results:
        generate_copy_script(results, args.generate_script)
    
    if args.copy_to and 'libraries' in results:
        copy_libraries(results, args.copy_to, fix_paths=args.fix_paths)


if __name__ == '__main__':
    main()
