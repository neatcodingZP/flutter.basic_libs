import 'package:flutter/rendering.dart';

/// Utility extension
extension NeatColorExtension on Color {
  /// Converts a [Color] to a grayscale equivalent based on its luminance.
  ///
  /// The luminance calculation uses the BT.709 standard for perceptual accuracy.
  Color greyscale() {
    // Calculate luminance using the BT.709 standard formula
    // This formula accounts for how humans perceive the brightness of different colors.
    final double luminance = computeLuminance();

    // Create a new Color with the same alpha (transparency)
    // but with all RGB components set to the calculated luminance.
    return withValues(red: luminance, green: luminance, blue: luminance);
  }

  /// Converts a [Color] to a grayscale equivalent based on average 
  /// color component value.
  Color greyscaleAverage() {
    final average = (r + g + b) / 3.0; 
    return withValues(red: average, green: average, blue: average);
  }

  /// Converts a [Color] to a grayscale equivalent
  /// setting its saturation to 0.0.
  Color greyscaleSaturation() {
    final hslColor = HSLColor.fromColor(this);
    return hslColor.withSaturation(0.0).toColor();
  }

  /// Darkens a [Color] by a given [factor].
  /// [factor] should be a value between 0.0 (no change) and 1.0 (black).
  Color darken([double factor = 0.1]) {
    assert(factor >= 0 && factor <= 1, 'Factor must be between 0 and 1');

    final r = this.r * (1 - factor);
    final g = this.g * (1 - factor);
    final b = this.b * (1 - factor);

    return withValues(red: r, green: g, blue: b);
  }

  /// Darkens a [Color] by a given [factor] using the HSL color model.
  /// [factor] should be a value between 0.0 (no change) and 1.0 (black).
  Color darkenHsl([double factor = 0.1]) {
    assert(factor >= 0 && factor <= 1, 'Factor must be between 0 and 1');

    HSLColor hsl = HSLColor.fromColor(this);
    // Reduce lightness by the factor, clamp to 0.0-1.0
    final lightness = (hsl.lightness - factor).clamp(0.0, 1.0);

    return hsl.withLightness(lightness).toColor();
  }

  /// Lightens a [Color] by a given [factor].
  /// [factor] should be a value between 0.0 (no change) and 1.0 (white).
  Color lighten([double factor = 0.1]) {
    assert(factor >= 0 && factor <= 1, 'Factor must be between 0 and 1');

    // Calculate the amount of white to mix in
    final r = (this.r + factor).clamp(0.0, 1.0);
    final g = (this.g + factor).clamp(0.0, 1.0);
    final b = (this.b + factor).clamp(0.0, 1.0);

    return withValues(red: r, green: g, blue: b);
  }

  /// Lightens a [Color] by a given [factor] using the HSL color model.
  /// [factor] should be a value between 0.0 (no change) and 1.0 (white).
  Color lightenHsl([double factor = 0.1]) {
    assert(factor >= 0 && factor <= 1, 'Factor must be between 0 and 1');

    HSLColor hsl = HSLColor.fromColor(this);
    // Increase lightness by the factor, clamp to 0.0-1.0
    double lightness = (hsl.lightness + factor).clamp(0.0, 1.0);

    return hsl.withLightness(lightness).toColor();
  }
}