import 'package:flutter/material.dart';
import '../../../utils/image_assets.dart';
import '../../../utils/text_styles.dart';

class SettingsTileWidget extends StatelessWidget {
  final Widget icon;
  final String text;
  final void Function()? onTap;
  const SettingsTileWidget({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 15),
            Column(
              children: [
                Text(
                  text,
                  style: poppinsRegTextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            const Spacer(),
            rightArrowIcon,
          ],
        ),
      ),
    );
  }
}
