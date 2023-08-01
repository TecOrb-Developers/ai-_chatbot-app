import 'package:flutter/material.dart';
import '../../../utils/image_assets.dart';

class DotIndicator extends StatelessWidget {
  final bool isAcitve;
  const DotIndicator({
    super.key,
    this.isAcitve = false,
  });

  @override
  Widget build(BuildContext context) {
    return isAcitve
        ? AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: whiteDotIcon,
          )
        : AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 10,
            width: 10,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white30,
            ),
          );
  }
}
