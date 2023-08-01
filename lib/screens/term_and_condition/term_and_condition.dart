import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:ai_chatbot_flutter/widgets/gradient_rect_btn_widget.dart';
import 'package:flutter/material.dart';
import '../../utils/static_data.dart';
import '../../utils/ui_parameters.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/grad_horizontal_divider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermAndConditionScreen extends StatefulWidget {
  const TermAndConditionScreen({super.key});

  @override
  State<TermAndConditionScreen> createState() => _TermAndConditionScreenState();
}

class _TermAndConditionScreenState extends State<TermAndConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
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
              title: AppLocalizations.of(context)!.termcondition,
            ),
            const GradientHorizontalDivider(),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Please read these Terms and Conditions ("Terms") carefully before using the AI Chat Bot Application ("the Application"). By accessing or using the Application, you agree to be bound by these Terms.',
                      style: poppinsRegTextStyle.copyWith(
                        fontSize: 13,
                        color: kgrayColor,
                      ),
                    ),
                  ),
                  Column(
                    children: List.generate(
                        term.length,
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
                                    child: Text(
                                      term[index],
                                      style: poppinsRegTextStyle.copyWith(
                                        fontSize: 13,
                                        color: kgrayColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      " By using the Application, you acknowledge and agree to these Terms and Conditions.",
                      style: poppinsRegTextStyle.copyWith(
                        fontSize: 13,
                        color: kgrayColor,
                      ),
                    ),
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
