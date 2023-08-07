import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:flutter/material.dart';

class HelpDexContainer extends StatelessWidget {
  const HelpDexContainer(
      {super.key, this.lowerText, this.upperText, this.image, this.onTap});
  final String? upperText;
  final String? lowerText;
  final String? image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      height: 72,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kchatBodyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  upperText!,
                  style: interRegTextStyle.copyWith(
                    color: kdarkTextColor,
                    fontSize: 16,
                  ),
                ),
                Text(
                  lowerText!,
                  style: poppinsRegTextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 68,
              width: 68,
              decoration: BoxDecoration(
                  color: kIconContainerBoxColor,
                  image: DecorationImage(image: AssetImage(image!)),
                  borderRadius: BorderRadius.circular(11)),
              // child: IconButton(onPressed: () {}, icon:Icon(icon!)),
            ),
          )
        ],
      ),
    );
  }
}
