import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/image_assets.dart';

class ChatIconFab extends StatelessWidget {
  const ChatIconFab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white,
            Colors.white,
            Colors.white38,
            Colors.white10,
            Colors.transparent,
          ],
        ),
      ),
      child: Container(
        height: 55,
        width: 55,
        decoration: const BoxDecoration(
          color: kPearColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x30C7F431),
              offset: Offset(0, 10),
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
        ),
        child: chatIcon,
      ),
    );
  }
}
