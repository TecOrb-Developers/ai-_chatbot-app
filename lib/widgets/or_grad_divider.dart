import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';

class OrGradDivider extends StatelessWidget {
  const OrGradDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            margin: const EdgeInsets.only(right: 15),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white10,
                  Colors.white60,
                ],
              ),
            ),
          ),
        ),
        Text(
          "Or",
          style: poppinsRegTextStyle.copyWith(color: kGraniteGrayColor),
        ),
        Expanded(
          child: Container(
            height: 1,
            margin: const EdgeInsets.only(left: 15),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white60,
                  Colors.white10,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
