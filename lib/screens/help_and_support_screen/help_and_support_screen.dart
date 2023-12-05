import 'package:ai_chatbot_flutter/screens/settings_screen/widgets/help_desk_expaanded_containeer.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:ai_chatbot_flutter/utils/ui_parameters.dart';
import 'package:ai_chatbot_flutter/widgets/gradient_rect_btn_widget.dart';
import 'package:ai_chatbot_flutter/widgets/help_desk_container.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/grad_horizontal_divider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({super.key});

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  bool isExpanded = false;
  List<bool> isExpandedList = List.generate(4, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              leading: GradientRectBtnWidget(
                padding: paddingAll10,
                colors: whiteGradientBoxColor,
                child: backArrowIcon,
                onTap: () => Navigator.of(context).pop(),
              ),
              title: AppLocalizations.of(context)!.helpSupport,
            ),
            const GradientHorizontalDivider(),
            const SizedBox(height: 20),
            HelpDexContainer(
              image: "assets/images/color_mobile.png",
              lowerText: "+91  8076633179",
              upperText: AppLocalizations.of(context)!.phoneNo,
              onTap: () {
                launchUrl(Uri(scheme: 'tel', path: '8284822840'));
              },
            ),
            HelpDexContainer(
              image: "assets/images/color_mail.png",
              lowerText: "abc@gmail.com",
              upperText: AppLocalizations.of(context)!.email,
              onTap: () {
                launchUrl(Uri(
                  scheme: 'mailto',
                  path: 'vidushi.2023@tecorb.co',
                ));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                AppLocalizations.of(context)!.faq,
                style: poppinsRegTextStyle.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: List.generate(
                  4,
                  (index) => HelpDexExpandedContainer(
                    title: AppLocalizations.of(context)!.decAccount,
                    text: AppLocalizations.of(context)!.help1,
                    icon: isExpandedList[index] ? Icons.minimize : Icons.add,
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        isExpandedList[index] = expanded;
                      });
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
