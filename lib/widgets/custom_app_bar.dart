import 'package:flutter/material.dart';
import '../utils/text_styles.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? leading;
  final String? title;
  final Widget? trailing;
  final void Function()? leadingOnTap;
  final void Function()? trailingOnTap;
  const CustomAppBar({
    super.key,
    this.leading,
    this.trailing,
    this.title,
    this.leadingOnTap,
    this.trailingOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 50,
        bottom: 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (leading != null)
            GestureDetector(
              onTap: leadingOnTap,
              child: leading,
            ),
          if (title != null) const SizedBox(width: 20),
          if (title != null)
            Text(
              title!,
              style: poppinsMedTextStyle.copyWith(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          const Spacer(),
          trailing != null
              ? GestureDetector(
                  onTap: trailingOnTap,
                  child: trailing,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
