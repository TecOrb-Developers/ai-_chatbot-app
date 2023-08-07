import 'package:flutter/material.dart';

class ShimmerListTile extends StatelessWidget {
  const ShimmerListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 38,
          backgroundColor: Colors.white,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 25,
              width: 150,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 20,
              width: 115,
              color: Colors.grey,
            )
          ],
        ),
        const Spacer(),
        Container(
          height: 20,
          width: 20,
          color: Colors.grey,
        )
      ],
    );
  }
}
