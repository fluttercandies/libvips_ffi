#!/usr/bin/env python3
"""
Generate full API bindings for libvips_ffi_api package.
Analyzes vips_bindings_generated.dart and creates variadic bindings.
"""

import re
import sys
from pathlib import Path
from collections import defaultdict
from dataclasses import dataclass
from typing import List, Optional

@dataclass
class FunctionDef:
    name: str
    return_type: str
    params: List[tuple]  # [(type, name), ...]
    is_variadic: bool
    category: str

def parse_functions(content: str) -> List[FunctionDef]:
    """Parse function definitions from generated bindings."""
    functions = []
    
    # Pattern to match function definitions
    # int vips_xxx( or ffi.Pointer<X> vips_xxx(
    func_pattern = re.compile(
        r'^\s+(int|void|ffi\.Pointer<[^>]+>|double|gpointer)\s+(vips_\w+)\s*\(\s*\n(.*?)\)',
        re.MULTILINE | re.DOTALL
    )
    
    for match in func_pattern.finditer(content):
        ret_type = match.group(1)
        func_name = match.group(2)
        params_str = match.group(3)
        
        # Parse parameters
        params = []
        for line in params_str.split('\n'):
            line = line.strip().rstrip(',')
            if not line or line == ')':
                continue
            # Extract type and name
            parts = line.rsplit(' ', 1)
            if len(parts) == 2:
                param_type = parts[0].strip()
                param_name = parts[1].strip()
                params.append((param_type, param_name))
        
        # Determine category
        category = categorize_function(func_name)
        
        # Check if variadic (most vips functions with options are variadic)
        is_variadic = is_variadic_function(func_name)
        
        functions.append(FunctionDef(
            name=func_name,
            return_type=ret_type,
            params=params,
            is_variadic=is_variadic,
            category=category
        ))
    
    return functions

def is_variadic_function(name: str) -> bool:
    """Check if a function is likely variadic."""
    # Most vips image processing functions are variadic
    # Internal/utility functions typically are not
    non_variadic_prefixes = [
        'vips_image_get_', 'vips_image_set_', 'vips_image_remove',
        'vips_image_print', 'vips_image_guess', 'vips_image_decode',
        'vips_image_encode', 'vips_image_minimise', 'vips_image_invalidate',
        'vips_image_wio', 'vips_image_pio', 'vips_image_pipeline',
        'vips_image_build', 'vips_image_reorder', 'vips_image_copy_memory',
        'vips_object_', 'vips_area_', 'vips_region_', 'vips_source_',
        'vips_target_', 'vips_thread', 'vips_semaphore', 'vips_value_',
        'vips_ref_string', 'vips_sbuf', 'vips_tracked', 'vips_interpolate',
        'vips_argument', 'vips_type', 'vips_nickname', 'vips_rect',
        'vips_window', 'vips_slist', 'vips_thing', 'vips_operation',
        'vips_call', 'vips_error', 'vips_g_', 'g_', 'vips_buf_',
        'vips_dbuf_', 'vips_blob_', 'vips_array_', 'vips_check_',
        'vips_class_', 'vips_col_', 'vips_enum_', 'vips_flags_',
        'vips__', 'vips_concurrency', 'vips_leak', 'vips_version',
        'vips_init', 'vips_shutdown', 'vips_get_', 'vips_guess_',
        'vips_buffer_', 'vips_format_', 'vips_foreign_', 'vips_hash_',
        'vips_connection', 'vips_file_', 'vips_existsf', 'vips_realpath',
        'vips_isprefix', 'vips_isdirf', 'vips_mkdirf', 'vips_rmdirf',
        'vips_rename', 'vips_isvips', 'vips_ispoweroftwo', 'vips_iscasepostfix',
        'vips_path_', 'vips_verror', 'vips_filename', 'vips_mode',
        'vips_start', 'vips_stop', 'vips_sink', 'vips_generate',
        'vips_demand', 'vips_pipe_read', 'vips_progress', 'vips_block',
        'vips_break', 'vips_amiMSB', 'vips_strdup', 'vips_strtod',
        'vips_malloc', 'vips_image_hasalpha', 'vips_image_new_memory',
    ]
    
    for prefix in non_variadic_prefixes:
        if name.startswith(prefix):
            return False
    
    # Special non-variadic functions
    non_variadic = {
        'vips_image_get_width', 'vips_image_get_height', 'vips_image_get_bands',
        'vips_image_get_format', 'vips_image_get_interpretation',
        'vips_error_buffer', 'vips_error_clear',
    }
    if name in non_variadic:
        return False
    
    return True

def categorize_function(name: str) -> str:
    """Categorize a function by its purpose."""
    # Skip internal functions
    if name.startswith('vips__') or name.startswith('vips_object'):
        return 'internal'
    
    categories = {
        'io': ['load', 'save', 'write_to', 'new_from'],
        'colour': ['2Lab', '2XYZ', '2sRGB', '2CMYK', '2LCh', '2HSV', 'colour', 'Lab', 'XYZ', 'CMC', 'scRGB', 'HSV', 'Yxy', 'icc_'],
        'arithmetic': ['add', 'subtract', 'multiply', 'divide', 'abs', 'sign', 'pow', 'exp', 'log', 'sin', 'cos', 'tan', 'math', 'round', 'floor', 'ceil', 'rint', 'avg', 'deviate', 'min', 'max', 'stats'],
        'convolution': ['blur', 'sharpen', 'conv', 'sobel', 'canny', 'prewitt', 'scharr', 'compass'],
        'resample': ['resize', 'rotate', 'shrink', 'reduce', 'thumbnail', 'affine', 'mapim', 'similarity', 'quadratic'],
        'geometry': ['crop', 'flip', 'embed', 'extract', 'gravity', 'zoom', 'wrap', 'replicate', 'subsample', 'insert', 'join', 'grid', 'arrayjoin', 'smartcrop'],
        'histogram': ['hist', 'percent', 'stdif', 'measure', 'profile', 'project'],
        'morphology': ['morph', 'rank', 'median', 'dilate', 'erode', 'labelregions', 'countlines', 'fill'],
        'create': ['black', 'text', 'xyz', 'grey', 'gaussnoise', 'perlin', 'worley', 'zone', 'sines', 'eye', 'logmat', 'gaussmat', 'mask_', 'sdf', 'fractsurf', 'identity', 'buildlut', 'invertlut', 'tonelut'],
        'frequency': ['fft', 'spectrum', 'phasecor', 'freqmult'],
        'conversion': ['cast', 'copy', 'flatten', 'premultiply', 'unpremultiply', 'gamma', 'invert', 'recomb', 'falsecolour', 'msb', 'byteswap', 'bandjoin', 'bandmean', 'extract_band', 'addalpha', 'sequential', 'cache', 'tilecache', 'linecache', 'autorot', 'rot', 'scale', 'transpose'],
        'relational': ['equal', 'notequal', 'less', 'more', 'and', 'or', 'eor', 'lshift', 'rshift', 'relational', 'boolean', 'ifthenelse', 'switch'],
        'composite': ['composite', 'merge', 'mosaic', 'match', 'globalbalance', 'remosaic'],
        'draw': ['draw_'],
    }
    
    for cat, patterns in categories.items():
        if any(p in name for p in patterns):
            return cat
    
    return 'other'

def generate_dart_type(c_type: str) -> str:
    """Convert C type to Dart FFI type."""
    type_map = {
        'int': 'int',
        'void': 'void',
        'double': 'double',
        'gpointer': 'ffi.Pointer<ffi.Void>',
    }
    
    if c_type in type_map:
        return type_map[c_type]
    
    if c_type.startswith('ffi.Pointer'):
        return c_type
    
    return c_type

def main():
    project_root = Path(__file__).parent.parent
    binding_file = project_root / "packages/libvips_ffi_core/lib/src/bindings/vips_bindings_generated.dart"
    output_dir = project_root / "packages/libvips_ffi_api/lib/src/bindings/generated"
    
    output_dir.mkdir(parents=True, exist_ok=True)
    
    content = binding_file.read_text()
    
    # Count variadic functions by checking the C header comments or function patterns
    # For now, let's create a summary
    
    # Find all vips_ function names
    func_names = re.findall(r'\b(vips_\w+)\s*\(', content)
    unique_funcs = sorted(set(func_names))
    
    # Categorize
    categories = defaultdict(list)
    variadic_funcs = []
    
    for name in unique_funcs:
        cat = categorize_function(name)
        is_var = is_variadic_function(name)
        categories[cat].append((name, is_var))
        if is_var:
            variadic_funcs.append(name)
    
    # Print summary
    print("=" * 60)
    print("Variadic Functions Summary")
    print("=" * 60)
    
    for cat in sorted(categories.keys()):
        funcs = categories[cat]
        variadic_count = sum(1 for _, is_var in funcs if is_var)
        print(f"\n{cat.upper()}: {len(funcs)} total, {variadic_count} variadic")
        for name, is_var in sorted(funcs):
            marker = " [V]" if is_var else ""
            print(f"  - {name}{marker}")
    
    print(f"\n{'=' * 60}")
    print(f"Total variadic functions needing binding: {len(variadic_funcs)}")
    print(f"{'=' * 60}")
    
    # Write variadic function list to file
    output_file = output_dir / "variadic_functions.txt"
    with open(output_file, 'w') as f:
        f.write("# Variadic functions requiring VarArgs binding\n")
        f.write("# Generated by generate_api_bindings.py\n\n")
        for cat in sorted(categories.keys()):
            if cat == 'internal':
                continue
            funcs = [(name, is_var) for name, is_var in categories[cat] if is_var]
            if funcs:
                f.write(f"\n## {cat.upper()}\n")
                for name, _ in sorted(funcs):
                    f.write(f"{name}\n")
    
    print(f"\nVariadic function list written to: {output_file}")

if __name__ == '__main__':
    main()
