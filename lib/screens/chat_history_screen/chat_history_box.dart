import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';

class ChatHistoryBox extends StatelessWidget {
  const ChatHistoryBox({
    this.text,
    this.time,
    this.onpress,
    super.key,
  });
  final String? text;
  final String? time;
  final VoidCallback? onpress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 20,
        ),
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: kchatBodyColor, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text!,
              style: poppinsRegTextStyle.copyWith(
                fontSize: 16,
                color: klightTextColor,
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              time!,
              style: poppinsRegTextStyle.copyWith(
                fontSize: 12,
                color: kgrayColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
