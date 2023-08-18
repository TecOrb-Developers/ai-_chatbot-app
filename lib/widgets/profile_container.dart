import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:flutter/material.dart';

class ProfileContainer extends StatelessWidget {
  ProfileContainer(
      {super.key,
      this.icon,
      this.name,
      this.text,
      this.controller,
      this.keyBoardType,
      this.validator,
      this.initialvalue,
      this.onChanged});
  final String? text;
  final String? name;
  final Widget? icon;
  final TextEditingController? controller;
  final TextInputType? keyBoardType;
  final String? initialvalue;
  void Function(String)? onChanged;

  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text!,
            style: poppinsRegTextStyle.copyWith(
              fontSize: 16,
              color: kdarkTextColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: onChanged,
            // initialValue: initialvalue,
            keyboardType: keyBoardType,
            cursorColor: Colors.white,
            controller: controller,
            style: poppinsRegTextStyle.copyWith(
              fontSize: 16,
              color: Colors.white,
            ),
            validator: validator,
            maxLength: 20,

            decoration: InputDecoration(
                labelStyle: poppinsRegTextStyle.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: kchatBodyColor)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: kchatBodyColor)),
                prefixIcon: icon!,
                filled: true,
                fillColor: kchatBodyColor,
                hintStyle: poppinsMedTextStyle.copyWith(
                  fontSize: 17,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          )
        ],
      ),
    );
  }
}
