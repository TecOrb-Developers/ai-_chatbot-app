import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/utils/image_assets.dart';
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
            // const SizedBox(height: 10),
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
                        horizontal: 10, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        notificationBotIcon,
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Current Subscription',
                                style: poppinsMedTextStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                'Lorem Ipsum is that it has a more-or-less normal distribution of letters,',
                                style: poppinsRegTextStyle.copyWith(
                                  fontSize: 10,
                                  color: Colors.white.withOpacity(0.63),
                                ),
                              ),
                              Text(
                                '8:30 AM',
                                style: poppinsRegTextStyle.copyWith(
                                  fontSize: 8,
                                  color: klightwhiteColor,
                                ),
                              ),
                            ],
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
