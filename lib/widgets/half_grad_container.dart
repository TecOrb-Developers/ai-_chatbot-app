import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class HalfGradContainer extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final Widget child;
  final List<Color> borderGradientcolors;
  final List<Color> innerGradientcolors;
  final VoidCallback onpress;
  const HalfGradContainer({
    super.key,
    this.padding,
    required this.child,
    required this.onpress,
    required this.borderGradientcolors,
    required this.innerGradientcolors,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        decoration: BoxDecoration(
          border: GradientBoxBorder(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: borderGradientcolors,
            ),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: innerGradientcolors,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
