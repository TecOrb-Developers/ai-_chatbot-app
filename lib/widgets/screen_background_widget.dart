import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/colors.dart';

class ScreenBackgroundWidget extends StatelessWidget {
  final Widget child;

  const ScreenBackgroundWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: child,

        //  Stack(
        //   children: [
        //     const SizedBox(
        //       height: double.infinity,
        //       width: double.infinity,
        //       child: DecoratedBox(
        //         decoration: BoxDecoration(
        //           color: kBlackColor,
        //         ),
        //       ),
        //     ),
        //     Container(
        //       // height: double.infinity,
        //       // width: double.infinity,
        //       decoration: const BoxDecoration(
        //         gradient: RadialGradient(
        //           center: Alignment.topLeft,
        //           radius: 1.2,
        //           colors: [
        //             Color(0x40C7F431),
        //             Color(0x00C7F431),
        //           ],
        //         ),
        //       ),
        //       child: child,
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
