import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:ai_chatbot_flutter/widgets/gradient_rect_btn_widget.dart';
import 'package:ai_chatbot_flutter/widgets/screen_background_widget.dart';
import 'package:flutter/material.dart';
import '../../utils/static_data.dart';
import '../../utils/ui_parameters.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/grad_horizontal_divider.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppBar(
              leading: GradientRectBtnWidget(
                padding: paddingAll10,
                colors: whiteGradientBoxColor,
                child: backArrowIcon,
                onTap: () => Navigator.pop(context),
              ),
              title: 'Privacy Policy',
            ),
            const GradientHorizontalDivider(),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Your privacy is important to us. This Privacy Policy outlines how we collect, use, and protect your personal information when you use the AI Chat Bot Application ("the Application").',
                      style: poppinsRegTextStyle.copyWith(
                        fontSize: 13,
                        color: kgrayColor,
                      ),
                    ),
                  ),
                  Column(
                    children: List.generate(
                        policyIndex.length,
                        (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${(index + 1).toString()}.",
                                    style: poppinsRegTextStyle.copyWith(
                                      fontSize: 13,
                                      color: kgrayColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          " ${policyIndex[index]} ",
                                          style: poppinsRegTextStyle.copyWith(
                                            fontSize: 13,
                                            color: kgrayColor,
                                          ),
                                        ),
                                        Text(
                                          " ${policyHeading[index]}",
                                          style: poppinsRegTextStyle.copyWith(
                                            fontSize: 13,
                                            color: kgrayColor,
                                          ),
                                        ),
                                        if (index == 0)
                                          Column(
                                              children: List.generate(
                                            index0.length,
                                            (index) => Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 7,
                                                    ),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          kgrayColor,
                                                      radius: 3,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    " ${index0[index]}",
                                                    style: poppinsRegTextStyle
                                                        .copyWith(
                                                      fontSize: 13,
                                                      color: kgrayColor,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                        if (index == 1)
                                          Column(
                                              children: List.generate(
                                            index1.length,
                                            (index) => Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 7,
                                                    ),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          kgrayColor,
                                                      radius: 3,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    " ${index1[index]}",
                                                    style: poppinsRegTextStyle
                                                        .copyWith(
                                                      fontSize: 13,
                                                      color: kgrayColor,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                        if (index == 3)
                                          Column(
                                              children: List.generate(
                                            index3.length,
                                            (index) => Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 7,
                                                    ),
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          kgrayColor,
                                                      radius: 3,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    " ${index3[index]}",
                                                    style: poppinsRegTextStyle
                                                        .copyWith(
                                                      fontSize: 13,
                                                      color: kgrayColor,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
