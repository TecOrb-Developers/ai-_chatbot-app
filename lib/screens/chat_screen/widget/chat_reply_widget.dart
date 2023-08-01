import 'package:ai_chatbot_flutter/utils/image_assets.dart';
import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_styles.dart';

class ChatReplyWidget extends StatelessWidget {
  final String text;
  const ChatReplyWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // if (!isSender)
        const Column(
          children: [
            chatbotAvatarIcon,
            SizedBox(height: 10),
          ],
        ),
        // if (!isSender)
        const SizedBox(width: 10),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            margin: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 80,
            ),
            decoration: const BoxDecoration(
              color: Color(0xff171717),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
            ),
            child: Text(
              text,
              style: poppinsMedTextStyle.copyWith(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
