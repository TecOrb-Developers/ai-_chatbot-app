import 'package:flutter/material.dart';

import '../utils/text_styles.dart';

class LogoTextBtnWidget extends StatelessWidget {
  final Image icon;
  final String text;
  final void Function()? onTap;
  const LogoTextBtnWidget({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: Colors.white)),
          child: Row(
            children: [
              const SizedBox(width: 15),
              icon,
              const SizedBox(width: 20),
              Text(
                text,
                style: poppinsRegTextStyle.copyWith(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
