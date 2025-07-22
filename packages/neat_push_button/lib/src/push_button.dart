import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:neat_ui/neat_ui.dart';

import 'push_button_style.dart';
import 'push_button_theme.dart';

/// Button which is able to be pused down
/// when pressed
/// and pop up when released
class PushButton extends StatefulWidget {

  /// Widget constructor
  const PushButton({super.key, required this.onTap, this.style, required this.child,});

  /// Callback for button tap.
  /// if null - button is considered as didabled
  final VoidCallback? onTap;

  /// Style of the button.
  /// 
  /// Style properties are resolved in following order
  /// [style] ??  style from [PushButtonTheme] ?? style from [PushButtonThemeExtension]
  /// 
  /// defaults to null
  final PushButtonStyle? style;

  /// Content of the button.
  final Widget child;

  /// Defines the button's default appearance.
  ///
  /// The button [child]'s [Text] and [Icon] widgets are rendered with
  /// the [ButtonStyle]'s foreground color. 
  PushButtonStyle defaultStyleOf(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return styleFrom(
      foregroundColor: colorScheme.onPrimary,
      backgroundColor: colorScheme.primary,
      disabledForegroundColor: colorScheme.onSurface.withValues(alpha: 0.38),
      disabledBackgroundColor: Color.from(
        alpha: 1.0,
        red: (colorScheme.primary.r + colorScheme.primary.g + colorScheme.primary.b) * 0.33,
        green: (colorScheme.primary.r + colorScheme.primary.g + colorScheme.primary.b) * 0.33,
        blue: (colorScheme.primary.r + colorScheme.primary.g + colorScheme.primary.b) * 0.33,
      ),
      bottomColor: Color.from(
        alpha: 1.0,
        red: colorScheme.primary.r * 0.8,
        green: colorScheme.primary.g * 0.8,
        blue: colorScheme.primary.b * 0.8,
      ),
      disabledbottomColor: Color.from(
        alpha: 1.0,
        red: (colorScheme.primary.r + colorScheme.primary.g + colorScheme.primary.b) * 0.33 * 0.8,
        green: (colorScheme.primary.r + colorScheme.primary.g + colorScheme.primary.b) * 0.33 * 0.8,
        blue: (colorScheme.primary.r + colorScheme.primary.g + colorScheme.primary.b) * 0.33 * 0.8,
      ),
      bottomOffset: const Offset(0, 5.0),
      iconSize: theme.iconTheme.size ?? 24.0,
      textStyle: theme.textTheme.labelLarge,
      padding: _scaledPadding(context),
      minimumSize: const Size(40, 40),
      maximumSize: Size.infinite,
      shape: StadiumBorder(),
      animationDuration: Duration.zero,
      ignoreTapDuration: Durations.medium4,
      enableFeedback: true,
      alignment: Alignment.center,
    );
  }

  /// Returns the [PushButtonThemeData.style] of the closest
  /// [PushButtonTheme] ancestor.
  /// 
  /// If [PushButtonTheme] is missing or its style is null
  /// Returns the [PushButtonThemeData.style] of the
  /// [PushButtonThemeExtension].
  PushButtonStyle? themeStyleOf(BuildContext context) => PushButtonTheme.maybeOf(context)?.style 
    ?? PushButtonThemeExtension.maybeOf(context)?.style;

  /// This is a clone from [ElevatedButton]
  EdgeInsetsGeometry _scaledPadding(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double padding1x = theme.useMaterial3 ? 24.0 : 16.0;
    final double defaultFontSize = theme.textTheme.labelLarge?.fontSize ?? 14.0;
    final double effectiveTextScale = MediaQuery.textScalerOf(context).scale(defaultFontSize) / 14.0;

    return ButtonStyleButton.scaledPadding(
      EdgeInsets.symmetric(horizontal: padding1x),
      EdgeInsets.symmetric(horizontal: padding1x / 2),
      EdgeInsets.symmetric(horizontal: padding1x / 2 / 2),
      effectiveTextScale,
    );
  }

  @override
  State<PushButton> createState() => _PushButtonState();

  /// A static convenience method that constructs an push button
  /// [PushButtonStyle] given simple values.
  ///
  /// The [foregroundColor] and [disabledForegroundColor] colors are used
  /// to create a [WidgetStateProperty] [PushButtonStyle.foregroundColor].
  ///
  /// The [backgroundColor] and [disabledBackgroundColor] colors are
  /// used to create a [WidgetStateProperty] [PushButtonStyle.backgroundColor].
  ///
  /// The [iconColor], [disabledIconColor] are used to construct
  /// [PushButtonStyle.iconColor] and [iconSize] is used to construct
  /// [PushButtonStyle.iconSize].
  ///
  /// If [iconColor] is null, the button icon will use [foregroundColor]. If [foregroundColor] is also
  /// null, the button icon will use the default icon color.
  ///
  /// All of the other parameters are either used directly or used to
  /// create a [WidgetStateProperty] with a single value for all
  /// states.
  ///
  /// All parameters default to null, by default this method returns
  /// a [PushButtonStyle] that doesn't override anything.
  ///
  /// For example, to override the default text and icon colors for an
  /// [PushButton], with all of the
  /// standard opacity adjustments for the pressed, focused, and
  /// hovered states, one could write:
  ///
  /// ```dart
  /// PushButton(
  ///   style: PushButton.styleFrom(foregroundColor: Colors.green),
  ///   onPressed: () {
  ///     // ...
  ///   },
  ///   child: const Text('Jump'),
  /// ),
  /// ```
  ///
  /// And to change the fill color:
  ///
  /// ```dart
  /// PushButton(
  ///   style: PushButton.styleFrom(backgroundColor: Colors.green),
  ///   onPressed: () {
  ///     // ...
  ///   },
  ///   child: const Text('Meow'),
  /// ),
  /// ```
  ///
  static PushButtonStyle styleFrom({
    Color? foregroundColor,
    Color? backgroundColor,
    Color? disabledForegroundColor,
    Color? disabledBackgroundColor,
    Color? bottomColor,
    Color? disabledbottomColor,
    Offset? bottomOffset,
    Color? iconColor,
    double? iconSize,
    Color? disabledIconColor,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? maximumSize,
    OutlinedBorder? shape,
    Duration? animationDuration,
    Duration? ignoreTapDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
  }) {

    return PushButtonStyle(
      textStyle: WidgetStatePropertyAll<TextStyle?>(textStyle),
      backgroundColor: ButtonStyleButton.defaultColor(backgroundColor, disabledBackgroundColor), 
      foregroundColor: ButtonStyleButton.defaultColor(foregroundColor, disabledForegroundColor),
      bottomColor: ButtonStyleButton.defaultColor(bottomColor, disabledbottomColor), 
      bottomOffset: bottomOffset, 
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding), 
      iconColor: ButtonStyleButton.defaultColor(iconColor, disabledIconColor), 
      iconSize: ButtonStyleButton.allOrNull<double>(iconSize), 
      shape: ButtonStyleButton.allOrNull<OutlinedBorder>(shape), 
      animationDuration: animationDuration, 
      minimumSize: ButtonStyleButton.allOrNull<Size>(minimumSize), 
      maximumSize: ButtonStyleButton.allOrNull<Size>(maximumSize), 
      enableFeedback: enableFeedback, 
      alignment: alignment, 
      ignoreTapDuration: ignoreTapDuration,
    );
  }
}

class _PushButtonState extends State<PushButton> with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  Timer? _ignoreTapTimer;
  bool _isIgnoringTap = false;

  AnimationController? _controller;
  Animation<Offset>? _animation;

  void _onTap() {
    final onTap = widget.onTap;
    if (onTap == null) return;

    onTap();
  }

  void _animationStatusListener(AnimationStatus status) {
    if (!mounted) return;

    if (status == AnimationStatus.completed && !_isPressed) {
      _controller?.reverse();
    }
  }

  @override
  void didUpdateWidget(covariant PushButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if ((oldWidget.onTap == null) != (widget.onTap == null)) {
      if (widget.onTap == null) {
        _isPressed = false;
        _controller?.reset();
      }
     
      setState(() {
      
      });
      return;
    }

    if (oldWidget.child != widget.child && oldWidget.child.key != widget.child.key) {
      setState(() {
      
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final onTap = widget.onTap;

    final states = onTap == null
      ? { WidgetState.disabled }
      : (_isPressed ? {WidgetState.pressed}: {WidgetState.selected});

    final PushButtonStyle? widgetStyle = widget.style;
    final PushButtonStyle? themeStyle = widget.themeStyleOf(context);
    final PushButtonStyle defaultStyle = widget.defaultStyleOf(context);

    T? effectiveValue<T>(T? Function(PushButtonStyle? style) getProperty) {
      final T? widgetValue = getProperty(widgetStyle);
      final T? themeValue = getProperty(themeStyle);
      final T? defaultValue = getProperty(defaultStyle);
      return widgetValue ?? themeValue ?? defaultValue;
    }

    T? resolve<T>(WidgetStateProperty<T>? Function(PushButtonStyle? style) getProperty) {
      return effectiveValue((PushButtonStyle? style) {
        return getProperty(style)?.resolve(states);
      });
    }

    final textStyle = resolve<TextStyle?>(
      (PushButtonStyle? style) => style?.textStyle,
    ) ?? DefaultTextStyle.of(context).style;
    final backgroundColor = resolve<Color?>(
      (PushButtonStyle? style) => style?.backgroundColor,
    );
    final foreroundColor = resolve<Color?>(
      (PushButtonStyle? style) => style?.foregroundColor,
    );
    final bottomColor = resolve<Color?>(
      (PushButtonStyle? style) => style?.bottomColor,
    );

    final bottomOffset = widgetStyle?.bottomOffset ?? themeStyle?.bottomOffset ?? defaultStyle.bottomOffset;

    final padding = resolve<EdgeInsetsGeometry?>(
      (PushButtonStyle? style) => style?.padding,
    );

    final iconColor = resolve<Color?>(
      (PushButtonStyle? style) => style?.iconColor,
    ) ?? foreroundColor;

    final iconSize = resolve<double?>(
      (PushButtonStyle? style) => style?.iconSize,
    );

    final shape = resolve<OutlinedBorder?>(
      (PushButtonStyle? style) => style?.shape,
    );

    final animationDuration = widgetStyle?.animationDuration ?? themeStyle?.animationDuration ?? defaultStyle.animationDuration ?? Duration.zero;
    final ignoreTapDuration = widgetStyle?.ignoreTapDuration ?? themeStyle?.ignoreTapDuration ?? defaultStyle.ignoreTapDuration ?? Duration.zero;

    final minimumSize = resolve<Size?>(
      (PushButtonStyle? style) => style?.minimumSize,
    );

    final maximumSize = resolve<Size?>(
      (PushButtonStyle? style) => style?.maximumSize,
    );

    final enableFeedback = widgetStyle?.enableFeedback ?? themeStyle?.enableFeedback ?? defaultStyle.enableFeedback;
    final alignment = widgetStyle?.alignment ?? themeStyle?.alignment ?? defaultStyle.alignment;

    final decoration = shape == null
      ? null
      : ShapeDecoration(
         color: backgroundColor,
         shape: shape,
        );
    final bottomDecoration = shape == null
      ? BoxDecoration(color: bottomColor)
      : ShapeDecoration(
         color: bottomColor,
         shape: shape.copyWith(side: shape.side.copyWith(width: 0)),
        );

    if (_controller == null) {
      _controller = AnimationController(
        vsync: this,
        duration: animationDuration,
        reverseDuration: Duration(milliseconds: animationDuration.inMilliseconds ~/2 ),
      );
      _controller!.addStatusListener(_animationStatusListener);
    }

   
      
    _animation ??= Tween<Offset>(
        begin: Offset.zero,
        end: bottomOffset, 
      ).animate(
        CurvedAnimation(
          parent: _controller!,
          curve: Curves.linear,
        ),
      );

    final content = Stack(
      children: [
        // First present bottom
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.fromLTRB(bottomOffset?.dx ?? 0.0, (bottomOffset?.dy ?? 0.0) + 1.0, 0.0, 1.0),
            child: DecoratedBox(decoration: bottomDecoration,),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _animation!,
              builder: (context, child) => Transform.translate(
                offset: _animation!.value,
                child: Container(
                  alignment: alignment,
                  padding: padding,
                  constraints: BoxConstraints(minWidth: minimumSize?.width ?? 0.0, minHeight: minimumSize?.height ?? 0.0, 
                    maxWidth: maximumSize?.width ?? double.infinity, maxHeight: maximumSize?.height ?? double.infinity),
                  decoration: decoration,
                  child: IconTheme(
                    data: Theme.of(context).iconTheme.copyWith(
                      size: iconSize,
                      color: iconColor, 
                    ),
                    child: DefaultTextStyle(
                      style: textStyle,
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: bottomOffset?.dy,),
          ],
        ),
      ],
    );
    
    // if (onTap == null) return content;
    
    return GestureDetector(
      onTapDown: (details) {
        if (onTap == null) return;
        if (_isIgnoringTap) return;
        _isIgnoringTap = true;
        
        if (enableFeedback == true) {
          HapticFeedback.heavyImpact(); 
        }

        setState(() {
          _isPressed = true;
        });

        _controller?.forward();

        _ignoreTapTimer = Timer(ignoreTapDuration, () {
          if (!mounted) return;

          _isIgnoringTap = false;
        });
      },
      onTapUp: (details) {
        if (onTap == null) return;
        if (!_isPressed) return;
        setState(() {
          _isPressed = false;
        });

        _onTap();

        if (_controller?.status == AnimationStatus.completed) {
          _controller?.reverse();
        }
      },
      onTapCancel: () {
        if (onTap == null) return;
        if (!_isPressed) return;
        setState(() {
          _isPressed = false;
        });

        if (_controller?.status == AnimationStatus.forward || _controller?.status == AnimationStatus.completed) {
          _controller?.reverse();
        }
      },
      child: content,
    );
  }

  @override
  void dispose() {
    _ignoreTapTimer?.cancel();
    
    _controller?.addStatusListener(_animationStatusListener);
    _controller?.dispose();

    super.dispose();
  }
}