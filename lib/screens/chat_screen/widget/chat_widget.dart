import 'package:ai_chatbot_flutter/utils/image_assets.dart';
import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_styles.dart';

class ChatWidget extends StatelessWidget {
  final String text;
  final bool isSender;
  final Widget? child;
  const ChatWidget(
      {super.key, required this.text, required this.isSender, this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isSender)
          const Column(
            children: [
              chatbotAvatarIcon,
              SizedBox(height: 10),
            ],
          ),
        if (!isSender) const SizedBox(width: 10),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            margin: isSender
                ? const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 60,
                  )
                : const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    right: 80,
                  ),
            decoration: BoxDecoration(
              color: isSender ? Colors.white : const Color(0xff171717),
              borderRadius: isSender
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                      bottomLeft: Radius.circular(22),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                      bottomRight: Radius.circular(22),
                    ),
            ),
            child: Text(
              text,
              style: poppinsMedTextStyle.copyWith(
                color: isSender ? kBlackColor : Colors.white,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
