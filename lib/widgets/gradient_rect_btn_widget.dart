import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class GradientRectBtnWidget extends StatelessWidget {
  final Widget child;
  final List<Color> colors;
  final EdgeInsetsGeometry padding;
  final void Function()? onTap;
  const GradientRectBtnWidget({
    super.key,
    required this.child,
    required this.colors,
    required this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          border: GradientBoxBorder(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: child,
      ),
    );
  }
}
