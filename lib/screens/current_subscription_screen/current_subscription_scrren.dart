// import 'package:ai_chatbot_flutter/utils/colors.dart';
// import 'package:ai_chatbot_flutter/utils/text_styles.dart';
// import 'package:ai_chatbot_flutter/utils/ui_parameters.dart';
// import 'package:ai_chatbot_flutter/widgets/gradient_back_widget.dart';
// import 'package:ai_chatbot_flutter/widgets/gradient_rect_btn_widget.dart';
// import 'package:ai_chatbot_flutter/widgets/screen_background_widget.dart';
// import 'package:flutter/material.dart';
// import '../../../widgets/custom_app_bar.dart';
// import '../../../widgets/grad_horizontal_divider.dart';
// import '../../../widgets/half_grad_container.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class CurrentSubscriptionScreen extends StatefulWidget {
//   const CurrentSubscriptionScreen({super.key});
//   @override
//   State<CurrentSubscriptionScreen> createState() =>
//       _CurrentSubscriptionScreenState();
// }

// class _CurrentSubscriptionScreenState extends State<CurrentSubscriptionScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return ScreenBackgroundWidget(
//       child: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CustomAppBar(
//                   leading: GradientRectBtnWidget(
//                     padding: paddingAll10,
//                     colors: whiteGradientBoxColor,
//                     child: backArrowIcon,
//                     onTap: () => Navigator.of(context).pop(),
//                   ),
//                 ),
//                 const GradientHorizontalDivider(),
//                 const SizedBox(height: 20),
//                 Text(
//                   AppLocalizations.of(context)!.upgradeSubscription,
//                   style: poppinsRegTextStyle.copyWith(
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   AppLocalizations.of(context)!.currentsubs,
//                   style: poppinsLightTextStyle.copyWith(
//                     fontSize: 15,
//                     color: kgrayColor,
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 HalfGradContainer(
//                   onpress: () {},
//                   padding: const EdgeInsets.all(20),
//                   borderGradientcolors: borderWhiteGradColors,
//                   innerGradientcolors: pearMultipleGreyGradColor,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "1 DAY",
//                         style: poppinsRegTextStyle.copyWith(
//                           color: Colors.white,
//                           fontSize: 15,
//                         ),
//                       ),
//                       Text(
//                         "₹ 300.00",
//                         style: poppinsMedTextStyle.copyWith(
//                           color: Colors.white,
//                           fontSize: 20,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 Text(
//                   AppLocalizations.of(context)!.upgradeNow,
//                   style: poppinsRegTextStyle.copyWith(
//                     fontSize: 15,
//                     color: kPearColor,
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: HalfGradContainer(
//                         onpress: () {},
//                         padding: const EdgeInsets.symmetric(vertical: 22),
//                         borderGradientcolors: borderWhiteGradColors,
//                         innerGradientcolors: skyBlueGradColors,
//                         child: Column(
//                           children: [
//                             Text(
//                               AppLocalizations.of(context)!.weekly,
//                               style: poppinsRegTextStyle.copyWith(
//                                 color: Colors.white,
//                                 fontSize: 15,
//                               ),
//                             ),
//                             Text(
//                               "₹ 800.00",
//                               style: poppinsMedTextStyle.copyWith(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 13),
//                     Expanded(
//                       child: HalfGradContainer(
//                         onpress: () {},
//                         padding: const EdgeInsets.symmetric(vertical: 22),
//                         borderGradientcolors: borderWhiteGradColors,
//                         innerGradientcolors: skyBlueGradColors,
//                         child: Column(
//                           children: [
//                             Text(
//                               AppLocalizations.of(context)!.monthly,
//                               style: poppinsRegTextStyle.copyWith(
//                                 color: Colors.white,
//                                 fontSize: 15,
//                               ),
//                             ),
//                             Text(
//                               "₹ 1600.00",
//                               style: poppinsMedTextStyle.copyWith(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 15),
//                 GestureDetector(
//                   onTap: () {
//                     // Navigator.push(context, MaterialPageRoute(
//                     //   builder: (context) {
//                     //     return const AddCardScreen();
//                     //   },
//                     // ));
//                   },
//                   child: GradientBackWidget(
//                     topChild: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             AppLocalizations.of(context)!.yearly,
//                             style: poppinsRegTextStyle.copyWith(
//                               color: Colors.black,
//                               fontSize: 15,
//                             ),
//                           ),
//                           Text(
//                             "₹ 3000.00",
//                             style: poppinsMedTextStyle.copyWith(
//                               color: Colors.black,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:ai_chatbot_flutter/screens/choose_paymont_method/choose_payment_method.dart';
import 'package:ai_chatbot_flutter/screens/subscription_screen/widgets/subtick_text.dart';
import 'package:ai_chatbot_flutter/services/headers_map.dart';
import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/utils/image_assets.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:ai_chatbot_flutter/utils/ui_parameters.dart';
import 'package:ai_chatbot_flutter/widgets/grad_horizontal_divider.dart';
import 'package:ai_chatbot_flutter/widgets/gradient_rect_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/profile_controller.dart';
import '../../../widgets/custom_app_bar.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CurrentSubscriptionScreen extends StatefulWidget {
  const CurrentSubscriptionScreen({super.key});

  @override
  State<CurrentSubscriptionScreen> createState() =>
      _CurrentSubscriptionScreenState();
}

class _CurrentSubscriptionScreenState extends State<CurrentSubscriptionScreen> {
  bool isSubcribtion = false;
  bool isReady = true;
  late final ProfileController profileController;

  void initState() {
    print('subscription');
    super.initState();
    profileController = Get.find();
    print("1${profileController.subscribeType}");
    print("2${profileController.subscription}");
    if ((profileController.subscribeType == 'Expire' ||
            profileController.subscribeType == 'null' ||
            profileController.subscribeType == '') &&
        profileController.subscription == false) {
      setState(() {
        isReady = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: Stack(
        children: [
          subscriptionBackgroundImage,
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  ),
                  const GradientHorizontalDivider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          AppLocalizations.of(context)!.upgradeSubscription,
                          style: poppinsRegTextStyle.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          AppLocalizations.of(context)!.currentsubs,
                          style: poppinsLightTextStyle.copyWith(
                            fontSize: 15,
                            color: kgrayColor,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  if (subcription_type == 'Weekly')
                                    selectedsquareIcon,
                                  squareIcon,
                                  Positioned(
                                    top: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .weekly,
                                            style: poppinsRegTextStyle.copyWith(
                                              color:
                                                  subcription_type == 'Weekly'
                                                      ? Colors.black
                                                      : Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            "₹ 500.00",
                                            style: poppinsMedTextStyle.copyWith(
                                              color:
                                                  subcription_type == 'Weekly'
                                                      ? Colors.black
                                                      : Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 13),
                            Expanded(
                              child: Stack(
                                children: [
                                  if (subcription_type == 'Monthly')
                                    selectedsquareIcon,
                                  squareIcon,
                                  Positioned(
                                    top: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .monthly,
                                            style: poppinsRegTextStyle.copyWith(
                                              color:
                                                  subcription_type == 'Monthly'
                                                      ? Colors.black
                                                      : Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            "₹ 1500.00",
                                            style: poppinsMedTextStyle.copyWith(
                                              color:
                                                  subcription_type == 'Monthly'
                                                      ? Colors.black
                                                      : Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Stack(
                          children: [
                            if (subcription_type == 'OneDay') selectedflatIcon,
                            flatIcon,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.day,
                                    style: poppinsRegTextStyle.copyWith(
                                      color: subcription_type == 'OneDay'
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "₹ 80.00",
                                        style: poppinsMedTextStyle.copyWith(
                                          color: subcription_type == 'OneDay'
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 45,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Stack(
                          children: [
                            if (subcription_type == 'Yearly') selectedflatIcon,
                            flatIcon,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.yearly,
                                    style: poppinsRegTextStyle.copyWith(
                                      color: subcription_type == 'Yearly'
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "₹ 3000.00",
                                        style: poppinsMedTextStyle.copyWith(
                                          color: subcription_type == 'Yearly'
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 45,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
