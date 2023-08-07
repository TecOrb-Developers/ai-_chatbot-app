import 'package:flutter/material.dart';

import '../utils/text_styles.dart';

class ButtonText extends StatelessWidget {
  final String btnText;
  const ButtonText({
    super.key,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      btnText,
      style: poppinsMedTextStyle.copyWith(
        color: const Color(0xFF010101),
        fontSize: 16,
      ),
    );
  }
}
