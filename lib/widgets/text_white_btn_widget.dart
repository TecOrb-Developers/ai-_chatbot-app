import 'package:flutter/material.dart';
import 'btn_text_widet.dart';

class TextWhiteBtnWidget extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? margin;
  final void Function()? onTap;
  const TextWhiteBtnWidget({
    super.key,
    required this.title,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.white, width: 1.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Center(
            child: ButtonText(btnText: title),
          ),
        ),
      ),
    );
  }
}
