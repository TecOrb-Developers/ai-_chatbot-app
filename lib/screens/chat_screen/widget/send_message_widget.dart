import 'package:flutter/material.dart';
import '../../../utils/image_assets.dart';
import '../../../utils/text_styles.dart';

class SendMessageWidget extends StatelessWidget {
  final void Function()? onTap;
  final TextEditingController textController;
  const SendMessageWidget({
    super.key,
    this.onTap,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: const Color(0xff1B1B1B)),
              ),
              child: TextField(
                controller: textController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: micIcon,
                  hintText: "Start a new chat...",
                  hintStyle: poppinsRegTextStyle.copyWith(
                    color: const Color(0xff646464),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: onTap,
            child: sendBtnIcon,
          ),
        ],
      ),
    );
  }
}
