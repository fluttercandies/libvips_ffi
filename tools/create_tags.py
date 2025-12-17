#!/usr/bin/env python3
"""
Create git tags for all packages under packages/ directory.
Tag format: <package-name>-<version>
Skips if tag already exists.
"""

import os
import subprocess
import yaml
from pathlib import Path


def get_existing_tags() -> set[str]:
    """Get all existing git tags."""
    result = subprocess.run(
        ["git", "tag", "-l"],
        capture_output=True,
        text=True,
        cwd=Path(__file__).parent.parent,
    )
    return set(result.stdout.strip().split("\n")) if result.stdout.strip() else set()


def get_package_info(pubspec_path: Path) -> tuple[str, str] | None:
    """Read package name and version from pubspec.yaml."""
    try:
        with open(pubspec_path, "r") as f:
            data = yaml.safe_load(f)
            name = data.get("name")
            version = data.get("version")
            if name and version:
                return name, version
    except Exception as e:
        print(f"  Error reading {pubspec_path}: {e}")
    return None


def create_tag(tag_name: str, dry_run: bool = False) -> bool:
    """Create a git tag."""
    if dry_run:
        print(f"  [DRY-RUN] Would create tag: {tag_name}")
        return True
    
    result = subprocess.run(
        ["git", "tag", tag_name],
        capture_output=True,
        text=True,
        cwd=Path(__file__).parent.parent,
    )
    if result.returncode == 0:
        print(f"  ✓ Created tag: {tag_name}")
        return True
    else:
        print(f"  ✗ Failed to create tag {tag_name}: {result.stderr}")
        return False


def main(dry_run: bool = False):
    root_dir = Path(__file__).parent.parent
    packages_dir = root_dir / "packages"
    
    if not packages_dir.exists():
        print(f"Error: packages directory not found at {packages_dir}")
        return
    
    existing_tags = get_existing_tags()
    print(f"Found {len(existing_tags)} existing tags\n")
    
    created_count = 0
    skipped_count = 0
    
    for package_dir in sorted(packages_dir.iterdir()):
        if not package_dir.is_dir():
            continue
        
        pubspec_path = package_dir / "pubspec.yaml"
        if not pubspec_path.exists():
            continue
        
        info = get_package_info(pubspec_path)
        if not info:
            continue
        
        name, version = info
        tag_name = f"{name}-{version}"
        
        print(f"Package: {name} @ {version}")
        
        if tag_name in existing_tags:
            print(f"  → Tag already exists: {tag_name}")
            skipped_count += 1
        else:
            if create_tag(tag_name, dry_run):
                created_count += 1
    
    print(f"\nSummary:")
    print(f"  Created: {created_count}")
    print(f"  Skipped (already exists): {skipped_count}")


if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(
        description="Create git tags for all packages"
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Show what would be done without creating tags",
    )
    args = parser.parse_args()
    
    main(dry_run=args.dry_run)
