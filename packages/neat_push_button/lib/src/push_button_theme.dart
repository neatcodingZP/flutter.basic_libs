import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'push_button_style.dart';



/// A [PushButtonStyle] that overrides the default appearance of
/// [PushButton]s when it's used with [PushButtonTheme] or with the
/// overall [Theme]'s [PushButtonThemeExtension].
@immutable
class PushButtonThemeData with Diagnosticable {
  /// Create a [PushButtonThemeData].
  const PushButtonThemeData({required this.style});
  
  /// Overrides for [PushButton]'s default style.
  ///
  /// Non-null properties or non-null resolved [WidgetStateProperty]
  /// values override the [PushButtonStyle] returned by
  /// [PushButton.defaultStyleOf].
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final PushButtonStyle? style;

  

  /// Linearly interpolate between two elevated button themes.
  static PushButtonThemeData? lerp(
    PushButtonThemeData? a,
    PushButtonThemeData? b,
    double t,
  ) {
    if (identical(a, b)) {
      return a;
    }
    return PushButtonThemeData(
      style: PushButtonStyle.lerp(a?.style, b?.style, t),
    );
  }

  /// The closest instance of this class that encloses the given context.
  ///
  /// If there is no enclosing [PushButtonTheme] widget, then
  /// [PushButtonThemeExtension] of [Theme] is used.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// PushButtonThemeData? themeData = PushButtonThemeData.maybeOf(context);
  /// ```
  static PushButtonThemeData? maybeOf(BuildContext context) => PushButtonTheme.maybeOf(context) 
    ?? PushButtonThemeExtension.maybeOf(context);

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is PushButtonThemeData && other.style == style;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<PushButtonStyle>('style', style, defaultValue: null));
  }
}

/// A ThemeExtension for [PushButtonThemeData].
class PushButtonThemeExtension extends ThemeExtension<PushButtonThemeExtension> {
  /// Create an [PushButtonThemeExtension].
  const PushButtonThemeExtension({
    required this.data, 
  });

  /// Get [PushButtonThemeData] from [context].
  static PushButtonThemeData? maybeOf(BuildContext context) => Theme.of(context).extension<PushButtonThemeExtension>()?.data;

  /// The configuration of this theme.
  final PushButtonThemeData data;

  @override
  PushButtonThemeExtension copyWith({
    PushButtonThemeData? data,
  }) {
    return PushButtonThemeExtension(
      data: data ?? this.data,
    );
  }

  @override
  PushButtonThemeExtension lerp(covariant ThemeExtension<PushButtonThemeExtension>? other, double t) {
    if (other is! PushButtonThemeExtension) return this;

    return PushButtonThemeExtension(
      data: PushButtonThemeData.lerp(data, other.data, t) ?? data,
    );
  }
}

/// Overrides the [ButtonStyle] of its [PushButton] descendants.
class PushButtonTheme extends InheritedTheme {
  /// Create a [PushButtonTheme].
  const PushButtonTheme({super.key, required this.data, required super.child});

  /// The configuration of this theme.
  final PushButtonThemeData data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return PushButtonTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(PushButtonTheme oldWidget) => data != oldWidget.data;

  /// The closest instance of this class that encloses the given context.
  ///
  /// If there is no enclosing [PushButtonTheme] widget, 
  /// return null.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// PushButtonThemeData? themeData = PushButtonTheme.maybeOf(context);
  /// ```
  static PushButtonThemeData? maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<PushButtonTheme>()?.data;
}

