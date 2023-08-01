import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:flutter/material.dart';

class HelpDexExpandedContainer extends StatelessWidget {
  HelpDexExpandedContainer(
      {super.key, this.text, this.icon, this.onExpansionChanged, this.title});
  final String? title;
  final String? text;
  final IconData? icon;

  void Function(bool)? onExpansionChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: kchatBodyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        onExpansionChanged: onExpansionChanged,
        title: Text(
          title!,
          style: poppinsRegTextStyle.copyWith(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        trailing: Icon(
          icon,
          color: Colors.white,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
            child: Text(
              text!,
              style: poppinsRegTextStyle.copyWith(
                color: kgrayColor,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
