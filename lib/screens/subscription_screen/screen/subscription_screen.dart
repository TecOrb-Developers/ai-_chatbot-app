import 'package:ai_chatbot_flutter/screens/choose_paymont_method/choose_payment_method.dart';
import 'package:ai_chatbot_flutter/services/headers_map.dart';
import 'package:ai_chatbot_flutter/utils/image_assets.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:ai_chatbot_flutter/widgets/grad_horizontal_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/profile_controller.dart';
import '../../../widgets/custom_app_bar.dart';
import '../widgets/subtick_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubscrptionScreen extends StatefulWidget {
  const SubscrptionScreen({super.key});

  @override
  State<SubscrptionScreen> createState() => _SubscrptionScreenState();
}

class _SubscrptionScreenState extends State<SubscrptionScreen> {
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
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        subscriptionBackgroundImage,
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBar(
                  leading: Text(
                    AppLocalizations.of(context)!.subscription,
                    style: poppinsMedTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  trailing: notificationBadgeIcon,
                ),
                const GradientHorizontalDivider(),
                const SizedBox(height: 40),
                const SubTickWithText(),
                const SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                              onTap: () {
                                var amount = "500";
                                isReady
                                    ? null
                                    : Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return ChoosePaymentMethodScreen(
                                            amount: amount,
                                            subcriptionType: "Weekly",
                                          );
                                        },
                                      ));
                              },
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
                              )),
                        ),
                        const SizedBox(width: 13),
                        Expanded(
                          child: GestureDetector(
                              onTap: () {
                                var amount = "1500";
                                // isReady
                                //     ? null
                                //     :
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ChoosePaymentMethodScreen(
                                      amount: amount,
                                      subcriptionType: 'Monthly',
                                    );
                                  },
                                ));
                              },
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
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                        onTap: () {
                          var amount = "80";
                          isReady
                              ? null
                              : Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ChoosePaymentMethodScreen(
                                      amount: amount,
                                      subcriptionType: 'OneDay',
                                    );
                                  },
                                ));
                        },
                        child: Stack(
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
                        )),
                    const SizedBox(height: 30),
                    GestureDetector(
                        onTap: () {
                          var amount = "3000";
                          isReady
                              ? null
                              : Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ChoosePaymentMethodScreen(
                                      amount: amount,
                                      subcriptionType: 'Yearly',
                                    );
                                  },
                                ));
                        },
                        child: Stack(
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
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
