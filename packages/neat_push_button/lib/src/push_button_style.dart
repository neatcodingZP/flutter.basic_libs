import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// The visual properties that [PushButton] has.
@immutable
class PushButtonStyle with Diagnosticable {
  /// Create a [PushButtonThemeData].
  const PushButtonStyle({
    this.textStyle, 
    this.backgroundColor, 
    this.foregroundColor, 
    this.bottomColor, 
    this.bottomOffset, 
    this.padding, 
    this.iconColor,
    this.iconSize,
    this.shape, 
    this.animationDuration, 
    this.minimumSize, 
    this.maximumSize, 
    this.enableFeedback, 
    this.alignment, 
    this.ignoreTapDuration,
  });

  /// The style for a button's [Text] widget descendants.
  ///
  /// The color of the [textStyle] is typically not used directly, the
  /// [foregroundColor] is used instead.
  final WidgetStateProperty<TextStyle?>? textStyle;

  /// The button's background fill color.
  final WidgetStateProperty<Color?>? backgroundColor;

  /// The color for the button's [Text] widget descendants.
  ///
  /// This color is typically used instead of the color of the [textStyle]. All
  /// of the components that compute defaults from [ButtonStyle] values
  /// compute a default [foregroundColor] and use that instead of the
  /// [textStyle]'s color.
  final WidgetStateProperty<Color?>? foregroundColor;

  /// The button's shadow color.
  final WidgetStateProperty<Color?>? bottomColor;

  /// The button's bottom offset.
  /// 
  /// Equals tap translation.
  final Offset? bottomOffset;

  /// The padding between the button's boundary and its child.
  final WidgetStateProperty<EdgeInsetsGeometry?>? padding;

  /// The icon's color inside of the button.
  final WidgetStateProperty<Color?>? iconColor;

  /// The icon's size inside of the button.
  final WidgetStateProperty<double?>? iconSize;

  /// The shape of the button's underlying [Material].
  final WidgetStateProperty<OutlinedBorder?>? shape;

  /// Defines the duration of animated changes for [shape] and [bottomOffset].
  final Duration? animationDuration;

  /// The minimum size of the button itself.
  ///
  /// This value must be less than or equal to [maximumSize].
  final WidgetStateProperty<Size?>? minimumSize;

  /// The maximum size of the button itself.
  ///
  /// A [Size.infinite] or null value for this property means that
  /// the button's maximum size is not constrained.
  final WidgetStateProperty<Size?>? maximumSize;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound.
  ///
  /// default value is true.
  final bool? enableFeedback;

  /// The alignment of the button's child.
  ///
  /// Typically buttons are sized to be just big enough to contain the child and its
  /// padding. If the button's size is constrained to a fixed size, for example by
  /// enclosing it with a [SizedBox], this property defines how the child is aligned
  /// within the available space.
  ///
  /// Always defaults to [Alignment.center].
  final AlignmentGeometry? alignment;

  /// Ignore tap duration 
  /// after button is pressed down
  /// if null - handle all taps without interval
  final Duration? ignoreTapDuration;

  /// Returns a copy of this PushButtonStyle with the given fields replaced with
  /// the new values.
  PushButtonStyle copyWith({
    WidgetStateProperty<TextStyle?>? textStyle,
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<Color?>? foregroundColor,
    WidgetStateProperty<Color?>? bottomColor,
    Offset? bottomOffset,
    WidgetStateProperty<EdgeInsetsGeometry?>? padding,
    WidgetStateProperty<Color?>? iconColor,
    WidgetStateProperty<double?>? iconSize,
    WidgetStateProperty<OutlinedBorder?>? shape,
    Duration? animationDuration,
    WidgetStateProperty<Size?>? minimumSize,
    WidgetStateProperty<Size?>? maximumSize,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    Duration? ignoreTapDuration,
  }) {
    return PushButtonStyle(
      textStyle: textStyle ?? this.textStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      bottomColor: bottomColor ?? this.bottomColor,
      bottomOffset: bottomOffset ?? this.bottomOffset,
      padding: padding ?? this.padding,
      iconColor: iconColor ?? this.iconColor,
      iconSize: iconSize ?? this.iconSize,
      shape: shape ?? this.shape,
      animationDuration: animationDuration ?? this.animationDuration,
      minimumSize: minimumSize ?? this.minimumSize,
      maximumSize: maximumSize ?? this.maximumSize,
      enableFeedback: enableFeedback ?? this.enableFeedback,
      alignment: alignment ?? this.alignment,
      ignoreTapDuration: ignoreTapDuration ?? this.ignoreTapDuration,
    );
  }

  /// Returns a copy of this PushButtonStyle where the non-null fields in [style]
  /// have replaced the corresponding null fields in this PushButtonStyle.
  ///
  /// In other words, [style] is used to fill in unspecified (null) fields
  /// this PushButtonStyle.
  PushButtonStyle merge(PushButtonStyle? style) {
    if (style == null) {
      return this;
    }
    return copyWith(
      textStyle: textStyle ?? style.textStyle,
      backgroundColor: backgroundColor ?? style.backgroundColor,
      foregroundColor: foregroundColor ?? style.foregroundColor,
      bottomColor: bottomColor ?? style.bottomColor,
      bottomOffset: bottomOffset ?? style.bottomOffset,
      padding: padding ?? style.padding,
      shape: shape ?? style.shape,
      animationDuration: animationDuration ?? style.animationDuration,
      minimumSize: minimumSize ?? style.minimumSize,
      maximumSize: maximumSize ?? style.maximumSize,
      enableFeedback: enableFeedback ?? style.enableFeedback,
      alignment: alignment ?? style.alignment,
      ignoreTapDuration: ignoreTapDuration ?? style.ignoreTapDuration,
    );
  }

  @override
  bool operator ==(covariant Object other) {
    if (identical(this, other)) return true;
  
    return other is PushButtonStyle &&
      other.textStyle == textStyle &&
      other.backgroundColor == backgroundColor &&
      other.foregroundColor == foregroundColor &&
      other.bottomColor == bottomColor &&
      other.bottomOffset == bottomOffset &&
      other.padding == padding &&
      other.shape == shape &&
      other.animationDuration == animationDuration &&
      other.minimumSize == minimumSize &&
      other.maximumSize == maximumSize &&
      other.enableFeedback == enableFeedback &&
      other.alignment == alignment &&
      other.ignoreTapDuration == ignoreTapDuration;
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[ 
      textStyle,
      backgroundColor,
      foregroundColor,
      bottomColor,
      bottomOffset,
      padding,
      shape,
      animationDuration,
      minimumSize,
      maximumSize,
      enableFeedback,
      alignment,
      ignoreTapDuration,
    ];
    return Object.hashAll(values);
  }

  /// Linearly interpolate between two [PushButtonStyle]s.
  static PushButtonStyle? lerp(PushButtonStyle? a, PushButtonStyle? b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return PushButtonStyle(
      textStyle: WidgetStateProperty.lerp<TextStyle?>(
        a?.textStyle,
        b?.textStyle,
        t,
        TextStyle.lerp,
      ),
      backgroundColor: WidgetStateProperty.lerp<Color?>(
        a?.backgroundColor,
        b?.backgroundColor,
        t,
        Color.lerp,
      ),
      foregroundColor: WidgetStateProperty.lerp<Color?>(
        a?.foregroundColor,
        b?.foregroundColor,
        t,
        Color.lerp,
      ),
      bottomColor: WidgetStateProperty.lerp<Color?>(
        a?.bottomColor,
        b?.bottomColor,
        t,
        Color.lerp,
      ),
      bottomOffset: Offset.lerp(a?.bottomOffset, b?.bottomOffset, t), 
      padding: WidgetStateProperty.lerp<EdgeInsetsGeometry?>(
        a?.padding,
        b?.padding,
        t,
        EdgeInsetsGeometry.lerp,
      ), 
      iconColor: WidgetStateProperty.lerp<Color?>(
        a?.iconColor,
        b?.iconColor,
        t,
        Color.lerp,
      ),
      iconSize: WidgetStateProperty.lerp<double?>(
        a?.iconSize,
        b?.iconSize,
        t,
        lerpDouble,
      ),
      shape: WidgetStateProperty.lerp<OutlinedBorder?>(
        a?.shape,
        b?.shape,
        t,
        OutlinedBorder.lerp,
      ), 
      animationDuration: t < 0.5 ? a?.animationDuration : b?.animationDuration, 
      minimumSize: WidgetStateProperty.lerp<Size?>(a?.minimumSize, b?.minimumSize, t, Size.lerp),
      maximumSize: WidgetStateProperty.lerp<Size?>(a?.maximumSize, b?.maximumSize, t, Size.lerp),
      enableFeedback: t < 0.5 ? a?.enableFeedback : b?.enableFeedback,
      alignment: AlignmentGeometry.lerp(a?.alignment, b?.alignment, t),
      ignoreTapDuration: t < 0.5 ? a?.ignoreTapDuration : b?.ignoreTapDuration,
    );
  }
}
