import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:ai_chatbot_flutter/utils/ui_parameters.dart';
import 'package:ai_chatbot_flutter/widgets/custom_app_bar.dart';
import 'package:ai_chatbot_flutter/widgets/grad_horizontal_divider.dart';
import 'package:ai_chatbot_flutter/widgets/gradient_rect_btn_widget.dart';
import 'package:ai_chatbot_flutter/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppBar(
                leading: GradientRectBtnWidget(
                  padding: paddingAll10,
                  colors: whiteGradientBoxColor,
                  child: backArrowIcon,
                  onTap: () => Navigator.of(context).pop(),
                ),
                title: 'Notification'),
            const GradientHorizontalDivider(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: kchatBodyColor,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'hh',
                          style: poppinsRegTextStyle.copyWith(
                            fontSize: 16,
                            color: klightTextColor,
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          'gy',
                          style: poppinsRegTextStyle.copyWith(
                            fontSize: 12,
                            color: kgrayColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
