import 'package:ai_chatbot_flutter/screens/choose_paymont_method/choose_payment_method.dart';
import 'package:ai_chatbot_flutter/utils/image_assets.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:ai_chatbot_flutter/widgets/grad_horizontal_divider.dart';
import 'package:flutter/material.dart';
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
  String subscriptionType = 'weekly';
  void initState() {
    print('subscription');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        subscriptionBackgroundImage,
        SingleChildScrollView(
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
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          var amount = "500";
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ChoosePaymentMethodScreen(
                                amount: amount,
                              );
                            },
                          ));
                        },
                        child: Stack(
                          children: [
                            if (subscriptionType == 'weekly')
                              selectedsquareIcon,
                            squareIcon,
                            Positioned(
                              top: 20,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.weekly,
                                      style: poppinsRegTextStyle.copyWith(
                                        color: subscriptionType == 'weekly'
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "₹ 500.00",
                                      style: poppinsMedTextStyle.copyWith(
                                        color: subscriptionType == 'weekly'
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
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ChoosePaymentMethodScreen(
                                amount: amount,
                              );
                            },
                          ));
                        },
                        child: Stack(
                          children: [
                            if (subscriptionType == 'monthly')
                              selectedsquareIcon,
                            squareIcon,
                            Positioned(
                              top: 20,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.monthly,
                                      style: poppinsRegTextStyle.copyWith(
                                        color: subscriptionType == 'monthly'
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "₹ 1500.00",
                                      style: poppinsMedTextStyle.copyWith(
                                        color: subscriptionType == 'monthly'
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
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ChoosePaymentMethodScreen(
                          amount: amount,
                        );
                      },
                    ));
                  },
                  child: Stack(
                    children: [
                      if (subscriptionType == 'oneday') selectedflatIcon,
                      flatIcon,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.day,
                              style: poppinsRegTextStyle.copyWith(
                                color: subscriptionType == 'oneday'
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
                                    color: subscriptionType == 'oneday'
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
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ChoosePaymentMethodScreen(
                          amount: amount,
                        );
                      },
                    ));
                  },
                  child: Stack(
                    children: [
                      if (subscriptionType == 'yearly') selectedflatIcon,
                      flatIcon,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.yearly,
                              style: poppinsRegTextStyle.copyWith(
                                color: subscriptionType == 'yearly'
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
                                    color: subscriptionType == 'yearly'
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
          ),
        ),
      ],
    );
  }
}
