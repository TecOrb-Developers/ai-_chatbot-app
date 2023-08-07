import 'package:ai_chatbot_flutter/widgets/custom_text_widgets.dart';
import 'package:flutter/material.dart';
import '../../../utils/image_assets.dart';

class SubTickWithText extends StatelessWidget {
  const SubTickWithText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          subscriptionTickImage,
          const SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < _subList.length; i++)
                  CustomTextPoppinsMed(text: _subList[i]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<String> _subList = [
  "VIP exclusive channel",
  "Unlimited Message",
  "Voice Chat Available",
  "Become Pro",
];
