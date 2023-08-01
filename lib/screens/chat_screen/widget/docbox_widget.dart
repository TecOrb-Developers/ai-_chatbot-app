import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/image_assets.dart';
import '../../../utils/text_styles.dart';

class DocBoxWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onpress;
  const DocBoxWidget({super.key, required this.text, this.onpress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Stack(
        alignment: Alignment.center,
        children: [
          docBoxIcon,
          Text(
            text,
            style: poppinsMedTextStyle.copyWith(
              color: kBlackColor,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
