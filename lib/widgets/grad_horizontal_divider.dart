import 'package:flutter/material.dart';

class GradientHorizontalDivider extends StatelessWidget {
  const GradientHorizontalDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.transparent,
        Colors.white12,
        Colors.white12,
        Colors.white12,
        Colors.white12,
        Colors.transparent,
      ])),
    );
  }
}
