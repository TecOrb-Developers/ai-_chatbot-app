import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:ai_chatbot_flutter/widgets/gradient_rect_btn_widget.dart';
import 'package:ai_chatbot_flutter/widgets/screen_background_widget.dart';
import 'package:flutter/material.dart';
import '../../utils/static_data.dart';
import '../../utils/ui_parameters.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/grad_horizontal_divider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    List policyIndex = [
      AppLocalizations.of(context)!.i,
      AppLocalizations.of(context)!.j,
      AppLocalizations.of(context)!.k,
      AppLocalizations.of(context)!.l,
      AppLocalizations.of(context)!.m,
      AppLocalizations.of(context)!.n,
      AppLocalizations.of(context)!.o,
      AppLocalizations.of(context)!.p
    ];
    List policyHeading = [
      AppLocalizations.of(context)!.q,
      AppLocalizations.of(context)!.r,
      AppLocalizations.of(context)!.s,
      AppLocalizations.of(context)!.t,
      AppLocalizations.of(context)!.u,
      AppLocalizations.of(context)!.v,
      AppLocalizations.of(context)!.w,
      AppLocalizations.of(context)!.x,
    ];
    List index0 = [
      AppLocalizations.of(context)!.a1,
      AppLocalizations.of(context)!.b1,
      AppLocalizations.of(context)!.c1,
    ];
    List index1 = [
      AppLocalizations.of(context)!.d1,
      AppLocalizations.of(context)!.e1,
      AppLocalizations.of(context)!.f1,
      AppLocalizations.of(context)!.g1,
    ];

    List index3 = [
      AppLocalizations.of(context)!.h1,
      AppLocalizations.of(context)!.i1,
      AppLocalizations.of(context)!.j1,
    ];

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
                      AppLocalizations.of(context)!.pPolicy,
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
