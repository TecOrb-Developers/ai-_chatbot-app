import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import '../../../utils/image_assets.dart';
import '../../../utils/text_styles.dart';

class SendMessageWidget extends StatelessWidget {
  final void Function()? onTap;
  final Function(TapDownDetails)? onTapdown;
  final void Function(TapUpDetails)? onTapup;
  GestureTapCancelCallback? onTapCancel;
  final TextEditingController textController;
  bool? isListning;
  SendMessageWidget({
    super.key,
    this.onTap,
    this.onTapdown,
    this.onTapup,
    this.onTapCancel,
    required this.textController,
    this.isListning,
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
                  suffixIcon: GestureDetector(
                    onTapDown: onTapdown,
                    onTapUp: onTapup,
                    onTapCancel: onTapCancel,
                    child: AvatarGlow(
                        animate: isListning!,
                        glowColor: kPearColor,
                        repeat: true,
                        repeatPauseDuration: Duration(milliseconds: 300),
                        showTwoGlows: true,
                        duration: Duration(milliseconds: 2000),
                        endRadius: 35,
                        child: micIcon),
                  ),
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




// import 'package:flutter/material.dart';
// import '../../../utils/image_assets.dart';
// import '../../../utils/text_styles.dart';

// class SendMessageWidget extends StatelessWidget {
//   final void Function()? onTap;
//   final Function(TapDownDetails)? onTapdown;
//   final void Function(TapUpDetails)? onTapup;
//   final TextEditingController textController;
//   const SendMessageWidget({
//     super.key,
//     this.onTap,
//     this.onTapdown,
//     this.onTapup,
//     required this.textController,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         children: [
//           Expanded(
//             child: DecoratedBox(
//               decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.all(Radius.circular(12)),
//                 border: Border.all(color: const Color(0xff1B1B1B)),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: textController,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         border: const OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(12)),
//                           borderSide: BorderSide.none,
//                         ),
//                         hintText: "Start a new chat...",
//                         hintStyle: poppinsRegTextStyle.copyWith(
//                           color: const Color(0xff646464),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 10),
//                     child: GestureDetector(
//                       onTapDown: onTapdown,
//                       onTapUp: onTapup,
//                       child: micIcon,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(width: 16),
//           GestureDetector(
//             onTap: onTap,
//             child: sendBtnIcon,
//           ),
//         ],
//       ),
//     );
//   }
// }
