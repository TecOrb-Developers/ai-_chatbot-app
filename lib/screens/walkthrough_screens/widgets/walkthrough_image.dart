import 'package:flutter/material.dart';

class WalkthroughImage extends StatelessWidget {
  final Widget image;
  const WalkthroughImage({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.6,
      child: image,
    );
  }
}
