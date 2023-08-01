import 'package:ai_chatbot_flutter/constants/api_const.dart';
import 'package:ai_chatbot_flutter/screens/choose_paymont_method/choose_payment_method.dart';
import 'package:ai_chatbot_flutter/services/headers_map.dart';
import 'package:ai_chatbot_flutter/services/network_api.dart';
import 'package:ai_chatbot_flutter/utils/image_assets.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:ai_chatbot_flutter/utils/ui_parameters.dart';
import 'package:ai_chatbot_flutter/widgets/grad_horizontal_divider.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/gradient_back_widget.dart';
import '../../../widgets/half_grad_container.dart';
import '../widgets/subtick_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubscrptionScreen extends StatefulWidget {
  const SubscrptionScreen({super.key});

  @override
  State<SubscrptionScreen> createState() => _SubscrptionScreenState();
}

class _SubscrptionScreenState extends State<SubscrptionScreen> {
  bool isSubcribtion = false;
  void initState() {
    print('subscription');
    super.initState();
    getSubscription();
  }

  Future<void> getSubscription() async {
    try {
      print('get subscription');
      final queryParams = {
        'subscriptionType': "Weekly",
      };
      final headers = {
        "Authorization": authorizationValue,
      };
      var response = await NetworkApi.getResponseWithParams(
          url: getSubscriptionUrl, headers: headers, queryParams: queryParams);
      print('get subscription-$response');
    } catch (e) {
      print("error is get subscription-$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        subscriptionBackgroundImage,
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
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
                        child: isSubcribtion ? selectedWeeklyIcon : weeklyIcon),
                  ),
                  const SizedBox(width: 13),
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
                        child:
                            isSubcribtion ? selectedmonthlyIcon : monthlyIcon),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              HalfGradContainer(
                onpress: () {
                  var amount = "80";
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ChoosePaymentMethodScreen(
                        amount: amount,
                      );
                    },
                  ));
                },
                padding: const EdgeInsets.all(20),
                borderGradientcolors: borderWhiteGradColors,
                innerGradientcolors: pearMultipleGradColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "1 DAY",
                      style: poppinsRegTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "₹ 80.00",
                      style: poppinsMedTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              GradientBackWidget(
                topChild: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.yearly,
                        style: poppinsRegTextStyle.copyWith(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "₹ 3000.00",
                        style: poppinsMedTextStyle.copyWith(
                          color: Colors.black,
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
    );
  }
}
