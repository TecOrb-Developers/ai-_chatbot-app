import 'package:flutter/material.dart';

import '../utils/image_assets.dart';

class GradientBackWidget extends StatelessWidget {
  final Widget topChild;
  const GradientBackWidget({
    super.key,
    required this.topChild,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        gradientImageIcon,
        const Image(
          image: AssetImage("assets/images/3.0x/yeartextbox.png"),
        ),
        topChild,
      ],
    );
  }
}
