import 'package:flutter/material.dart';

/// CustomScrollView with centered [children] inside.
/// 
/// Centering will apply only if content size is less than 
/// ScrollView size.
class CenteringScrollView extends StatelessWidget {
  /// Create CenterContentScrollView
  const CenteringScrollView({
    super.key, 
    this.padding = EdgeInsets.zero,
    this.spacing = 0.0,
    this.controller,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.children,
  });

  /// Padding for [children].
  ///
  /// defaults to [EdgeInsets.zero]
  final EdgeInsetsGeometry padding;

  /// Spacing between [children].
  /// 
  /// defaults to 0.0
  final double spacing;

  /// Optional external controller
  final ScrollController? controller;

  /// How the children should be placed along the cross axis.
  /// 
  /// Applies to the nested [Column]
  /// Defaults to [CrossAxisAlignment.center]
  final CrossAxisAlignment crossAxisAlignment;

  /// Widgets inside CenterContentScrollView
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    
    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: padding,
            child: Center(
              child: Column(
                spacing: spacing,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: crossAxisAlignment,
                children: children,
              )
            ),
          ),
        ),
      ]
    );
  }
}