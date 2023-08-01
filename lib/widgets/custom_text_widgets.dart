import 'package:flutter/material.dart';
import '../utils/text_styles.dart';

class CustomTextPoppinsMed extends StatelessWidget {
  /// PoppinsMed, 18, White
  final String text;
  const CustomTextPoppinsMed({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: poppinsMedTextStyle.copyWith(
        fontSize: 18,
        color: Colors.white,
      ),
    );
  }
}
