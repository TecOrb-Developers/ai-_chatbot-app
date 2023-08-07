import 'package:flutter/material.dart';

import '../../../utils/text_styles.dart';
import 'walkthrough_image.dart';

class WalkthroughContent extends StatelessWidget {
  final String text;
  final Widget icon;
  const WalkthroughContent({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        WalkthroughImage(image: icon),
        const Spacer(),
        Text(
          text,
          textAlign: TextAlign.center,
          style: poppinsSemiBoldTextStyle.copyWith(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
