---
sidebar_position: 13
---

# Complex

Complex number operations for signal processing and FFT.

## Function Mapping

| libvips C | Dart Binding | Pipeline Method | PipelineSpec |
|-----------|--------------|-----------------|--------------|
| `vips_complex()` | `complexBindings.complex()` | - | - |
| `vips_complex2()` | `complexBindings.complex2()` | - | - |
| `vips_complexget()` | `complexBindings.complexget()` | - | - |
| `vips_complexform()` | `complexBindings.complexform()` | - | - |
| `vips_polar()` | `complexBindings.polar()` | `pipeline.polar()` | `spec.polar()` |
| `vips_rect()` | `complexBindings.rect()` | `pipeline.rect()` | `spec.rect()` |
| `vips_conj()` | `complexBindings.conj()` | `pipeline.conj()` | `spec.conj()` |
| `vips_real()` | `complexBindings.real()` | `pipeline.real()` | `spec.real()` |
| `vips_imag()` | `complexBindings.imag()` | `pipeline.imag()` | `spec.imag()` |
| `vips_cross_phase()` | `complexBindings.crossPhase()` | - | - |

## complex

Apply unary complex operation.

```dart
complexBindings.complex(input, output, VipsOperationComplex.polar);
```

**Operations (VipsOperationComplex):**

- `polar` - Convert to polar coordinates
- `rect` - Convert to rectangular coordinates
- `conj` - Complex conjugate

## complexget

Extract component from complex image.

```dart
// Get real part
complexBindings.complexget(input, output, VipsOperationComplexget.real);

// Get imaginary part
complexBindings.complexget(input, output, VipsOperationComplexget.imag);
```

## complexform

Form complex image from two real images.

```dart
// Create complex from real and imaginary parts
complexBindings.complexform(realPart, imagPart, output);
```

## polar / rect

Convert between coordinate systems.

```dart
// Cartesian to polar (magnitude and phase)
complexBindings.polar(input, output);

// Polar to Cartesian (real and imaginary)
complexBindings.rect(input, output);
```

## conj

Complex conjugate (negate imaginary part).

```dart
complexBindings.conj(input, output);
```

## real / imag

Convenience functions to extract components.

```dart
// Extract real part
complexBindings.real(complexImage, realPart);

// Extract imaginary part
complexBindings.imag(complexImage, imagPart);
```

## cross_phase

Cross-phase correlation between two images.

```dart
complexBindings.crossPhase(image1, image2, output);
```

Used for image alignment and registration.

## Use Cases

### FFT Processing

```dart
// Forward FFT produces complex output
frequencyBindings.fwfft(input, fftComplex);

// Get magnitude for visualization
complexBindings.polar(fftComplex, polar);
complexBindings.real(polar, magnitude);  // Magnitude in real part
```

### Phase Analysis

```dart
// Extract phase from complex FFT
complexBindings.polar(fftComplex, polar);
complexBindings.imag(polar, phase);  // Phase in imaginary part
```
