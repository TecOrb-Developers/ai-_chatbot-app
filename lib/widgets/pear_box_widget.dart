import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:flutter/material.dart';

class PearColorBoxWidget extends StatelessWidget {
  final String text;
  const PearColorBoxWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 8,
      ),
      decoration: const BoxDecoration(
        color: kPearColor,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Text(
        text,
        style: libreFrankMedTextStyle.copyWith(color: kBlackColor),
      ),
    );
  }
}
