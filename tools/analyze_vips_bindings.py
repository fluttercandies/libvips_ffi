#!/usr/bin/env python3
"""Analyze vips_bindings_generated.dart to extract all vips_ functions."""

import re
import sys
from pathlib import Path
from collections import defaultdict

def main():
    binding_file = Path(__file__).parent.parent / "packages/libvips_ffi_core/lib/src/bindings/vips_bindings_generated.dart"
    
    content = binding_file.read_text()
    
    # Find all function definitions
    # Pattern: int/void/Pointer<X> vips_xxx(
    func_pattern = re.compile(r'^\s+(int|void|ffi\.Pointer<[^>]+>|double|gpointer)\s+(vips_\w+)\s*\(', re.MULTILINE)
    
    functions = []
    for match in func_pattern.finditer(content):
        ret_type = match.group(1)
        func_name = match.group(2)
        functions.append((func_name, ret_type))
    
    # Categorize functions
    categories = defaultdict(list)
    
    # I/O functions
    io_patterns = ['load', 'save', 'write_to', 'new_from']
    # Color functions
    color_patterns = ['2Lab', '2XYZ', '2sRGB', '2CMYK', '2LCh', '2HSV', 'colour', 'Lab', 'XYZ', 'CMC', 'scRGB', 'HSV', 'Yxy']
    # Arithmetic
    arith_patterns = ['add', 'subtract', 'multiply', 'divide', 'abs', 'sign', 'pow', 'exp', 'log', 'sin', 'cos', 'tan', 'math', 'round', 'floor', 'ceil', 'rint', 'linear']
    # Convolution
    conv_patterns = ['blur', 'sharpen', 'conv', 'sobel', 'canny', 'prewitt', 'scharr', 'compass']
    # Transform/Resample
    transform_patterns = ['resize', 'rotate', 'shrink', 'reduce', 'thumbnail', 'affine', 'mapim', 'similarity', 'quadratic']
    # Geometry
    geom_patterns = ['crop', 'flip', 'embed', 'extract', 'gravity', 'zoom', 'wrap', 'replicate', 'subsample', 'insert', 'join']
    # Histogram
    hist_patterns = ['hist', 'percent', 'stdif', 'measure', 'stats', 'avg', 'deviate', 'min', 'max', 'profile', 'project']
    # Morphology
    morph_patterns = ['morph', 'rank', 'median', 'dilate', 'erode', 'labelregions', 'countlines', 'fill']
    # Create
    create_patterns = ['black', 'text', 'xyz', 'grey', 'gaussnoise', 'perlin', 'worley', 'zone', 'sines', 'eye', 'logmat', 'gaussmat', 'mask_', 'sdf', 'fractsurf']
    # Frequency
    freq_patterns = ['fft', 'spectrum', 'phasecor', 'freqmult']
    # Conversion
    convert_patterns = ['cast', 'copy', 'flatten', 'premultiply', 'unpremultiply', 'gamma', 'invert', 'recomb', 'falsecolour', 'msb', 'byteswap', 'bandjoin', 'bandmean', 'bandrank', 'extract_band', 'addalpha', 'sequential', 'cache', 'tilecache', 'linecache', 'autorot', 'rot', 'scale']
    # Relational/Boolean
    rel_patterns = ['equal', 'notequal', 'less', 'more', 'and', 'or', 'eor', 'lshift', 'rshift', 'relational', 'boolean', 'ifthenelse', 'switch']
    # Composite
    comp_patterns = ['composite', 'merge', 'mosaic', 'match', 'globalbalance']
    # Draw
    draw_patterns = ['draw_']
    
    for func_name, ret_type in functions:
        # Skip internal functions
        if func_name.startswith('vips__') or func_name.startswith('vips_object') or func_name.startswith('vips_area'):
            categories['internal'].append(func_name)
            continue
        if func_name.startswith('vips_region') or func_name.startswith('vips_source') or func_name.startswith('vips_target'):
            categories['internal'].append(func_name)
            continue
        if func_name.startswith('vips_thread') or func_name.startswith('vips_semaphore'):
            categories['internal'].append(func_name)
            continue
        if func_name.startswith('vips_value') or func_name.startswith('vips_ref_string'):
            categories['internal'].append(func_name)
            continue
        if func_name.startswith('vips_sbuf') or func_name.startswith('vips_tracked'):
            categories['internal'].append(func_name)
            continue
        if func_name.startswith('vips_interpolate') or func_name.startswith('vips_argument'):
            categories['internal'].append(func_name)
            continue
        if func_name.startswith('vips_type') or func_name.startswith('vips_nickname'):
            categories['internal'].append(func_name)
            continue
        if func_name.startswith('vips_rect') or func_name.startswith('vips_window'):
            categories['internal'].append(func_name)
            continue
        if func_name.startswith('vips_slist') or func_name.startswith('vips_thing'):
            categories['internal'].append(func_name)
            continue
        if func_name.startswith('vips_operation') or func_name.startswith('vips_call'):
            categories['internal'].append(func_name)
            continue
        if func_name in ['vips_init', 'vips_shutdown', 'vips_error_buffer', 'vips_error_clear', 'vips_version', 'vips_version_string', 'vips_leak_set']:
            categories['core'].append(func_name)
            continue
        if any(p in func_name for p in ['malloc', 'free', 'strdup', 'strtod', 'realpath', 'isprefix', 'isdirf', 'mkdirf', 'rmdirf', 'rename', 'isvips', 'ispoweroftwo', 'iscasepostfix', 'path_', 'verror', 'filename', 'mode']):
            categories['internal'].append(func_name)
            continue
        if func_name.startswith('vips_image_') and any(p in func_name for p in ['get_', 'set_', 'remove', 'print', 'guess', 'decode', 'encode', 'minimise', 'invalidate', 'is', 'wio', 'pio', 'pipeline', 'build', 'reorder', 'copy_memory']):
            categories['internal'].append(func_name)
            continue
        if 'matrix' in func_name.lower() and func_name not in ['vips_matrixload', 'vips_matrixsave']:
            categories['internal'].append(func_name)
            continue
        if func_name.startswith('vips_g_') or func_name.startswith('g_'):
            categories['internal'].append(func_name)
            continue
        if func_name.startswith('vips_start') or func_name.startswith('vips_stop') or func_name.startswith('vips_sink'):
            categories['internal'].append(func_name)
            continue
        if 'generate' in func_name or 'demand' in func_name:
            categories['internal'].append(func_name)
            continue
        
        categorized = False
        
        # Check I/O first
        if any(p in func_name for p in io_patterns):
            categories['io'].append(func_name)
            categorized = True
        # Check color
        elif any(p in func_name for p in color_patterns):
            categories['colour'].append(func_name)
            categorized = True
        # Check arithmetic
        elif any(p in func_name for p in arith_patterns):
            categories['arithmetic'].append(func_name)
            categorized = True
        # Check convolution
        elif any(p in func_name for p in conv_patterns):
            categories['convolution'].append(func_name)
            categorized = True
        # Check transform
        elif any(p in func_name for p in transform_patterns):
            categories['resample'].append(func_name)
            categorized = True
        # Check geometry
        elif any(p in func_name for p in geom_patterns):
            categories['geometry'].append(func_name)
            categorized = True
        # Check histogram
        elif any(p in func_name for p in hist_patterns):
            categories['histogram'].append(func_name)
            categorized = True
        # Check morphology
        elif any(p in func_name for p in morph_patterns):
            categories['morphology'].append(func_name)
            categorized = True
        # Check create
        elif any(p in func_name for p in create_patterns):
            categories['create'].append(func_name)
            categorized = True
        # Check frequency
        elif any(p in func_name for p in freq_patterns):
            categories['frequency'].append(func_name)
            categorized = True
        # Check conversion
        elif any(p in func_name for p in convert_patterns):
            categories['conversion'].append(func_name)
            categorized = True
        # Check relational
        elif any(p in func_name for p in rel_patterns):
            categories['relational'].append(func_name)
            categorized = True
        # Check composite
        elif any(p in func_name for p in comp_patterns):
            categories['composite'].append(func_name)
            categorized = True
        # Check draw
        elif any(p in func_name for p in draw_patterns):
            categories['draw'].append(func_name)
            categorized = True
        
        if not categorized:
            categories['other'].append(func_name)
    
    # Print summary
    print("=" * 60)
    print("VIPS Functions Summary")
    print("=" * 60)
    
    total = 0
    for cat in sorted(categories.keys()):
        funcs = categories[cat]
        print(f"\n{cat.upper()} ({len(funcs)} functions):")
        total += len(funcs)
        for f in sorted(funcs):
            print(f"  - {f}")
    
    print(f"\n{'=' * 60}")
    print(f"TOTAL: {total} functions")
    print(f"{'=' * 60}")
    
    # Print non-internal categories count
    print("\nImage Processing Functions (excluding internal):")
    for cat in sorted(categories.keys()):
        if cat != 'internal':
            print(f"  {cat}: {len(categories[cat])}")

if __name__ == '__main__':
    main()
