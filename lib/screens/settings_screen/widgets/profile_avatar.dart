import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final ImageProvider<Object>? backgroundImage;

  const ProfileAvatar(
      {super.key, this.backgroundImage, this.icon, this.onpress, this.child});
  final Widget? icon;
  final VoidCallback? onpress;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(1),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffC7F431),
                Color(0xff06CFF1),
              ],
            ),
          ),
          child: CircleAvatar(
            radius: 38,
            backgroundColor: kBlackColor,
            child: GestureDetector(
              onTap: onpress,
              child: CircleAvatar(
                backgroundColor: kBlackColor,
                radius: 34,
                backgroundImage: backgroundImage,
                child: icon,
              ),
            ),
          ),
        ),
        Positioned(
            top: 43,
            left: 200,
            child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: child))
      ],
    );
  }
}
