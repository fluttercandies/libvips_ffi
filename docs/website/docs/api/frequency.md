---
sidebar_position: 11
---

# Frequency

FFT (Fast Fourier Transform) and frequency domain operations.

## Function Mapping

| libvips C | Dart Binding | Description |
|-----------|--------------|-------------|
| `vips_fwfft()` | `frequencyBindings.fwfft()` | Forward FFT |
| `vips_invfft()` | `frequencyBindings.invfft()` | Inverse FFT |
| `vips_freqmult()` | `frequencyBindings.freqmult()` | Frequency domain multiplication |
| `vips_spectrum()` | `frequencyBindings.spectrum()` | Compute power spectrum |
| `vips_phasecor()` | `frequencyBindings.phasecor()` | Phase correlation |

## fwfft

Forward Fast Fourier Transform.

```dart
frequencyBindings.fwfft(input, output);
```

Converts an image from spatial domain to frequency domain.

## invfft

Inverse Fast Fourier Transform.

```dart
frequencyBindings.invfft(input, output);
```

Converts an image from frequency domain back to spatial domain.

## freqmult

Multiply an image by a frequency domain filter.

```dart
frequencyBindings.freqmult(input, mask, output);
```

**Example - Low-pass filter:**

```dart
// Create a low-pass filter mask
final mask = createBindings.maskIdeal(width, height, frequencyCutoff: 0.5);
frequencyBindings.fwfft(input, fft);
frequencyBindings.freqmult(fft, mask, filtered);
frequencyBindings.invfft(filtered, output);
```

## spectrum

Compute power spectrum.

```dart
frequencyBindings.spectrum(input, output);
```

Returns the power spectrum of an image, useful for frequency analysis.

## phasecor

Phase correlation between two images.

```dart
frequencyBindings.phasecor(image1, image2, output);
```

Used for image registration and motion estimation.

## Filter Masks

Create frequency domain filter masks:

```dart
// Ideal filter (sharp cutoff)
createBindings.maskIdeal(width, height, frequencyCutoff: 0.5, reject: false);

// Gaussian filter (smooth cutoff)
createBindings.maskGaussian(width, height, frequencyCutoff: 0.5, amplitude: 1.0);

// Butterworth filter (controllable transition)
createBindings.maskButterworth(width, height, order: 2, frequencyCutoff: 0.5);
```
