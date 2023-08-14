import 'package:ai_chatbot_flutter/controllers/language_controller.dart';
import 'package:ai_chatbot_flutter/utils/image_assets.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:ai_chatbot_flutter/utils/ui_parameters.dart';
import 'package:ai_chatbot_flutter/widgets/grad_horizontal_divider.dart';
import 'package:ai_chatbot_flutter/widgets/gradient_rect_btn_widget.dart';
import 'package:ai_chatbot_flutter/widgets/screen_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/text_white_btn_widget.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({super.key});

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  late final LanguageController languageController;
  bool isSelect = false;

  List<String> selectLanguage = ["English", "Hindi", "Danish", "French"];

  @override
  void initState() {
    super.initState();
    languageController = Get.find();
    languageController.giveLocal();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ScreenBackgroundWidget(
      child: SingleChildScrollView(
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
              title: AppLocalizations.of(context)!.selectlan,
            ),
            const GradientHorizontalDivider(),
            const SizedBox(height: 20),
            Column(
              children: List.generate(
                selectLanguage.length,
                (index) => GestureDetector(
                  onTap: () {
                    currentIndex = index;
                    languageController.selectedLanguage.value =
                        selectLanguage[currentIndex];
                  },
                  child: ListTile(
                    leading: Obx(() =>
                        languageController.selectedLanguage.value ==
                                selectLanguage[index]
                            ? checkIcon
                            : unCheckIcon),
                    title: Text(
                      selectLanguage[index],
                      style: poppinsRegTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextWhiteBtnWidget(
              onTap: () {
                languageController.setLanguage(
                  selectLanguage[currentIndex],
                  getLocaleFromLanguage(selectLanguage[currentIndex]),
                );
                Navigator.pop(context);
              },
              title: AppLocalizations.of(context)!.update,
              margin: const EdgeInsets.symmetric(vertical: 30),
            ),
          ],
        ),
      ),
    );
  }

  String getLocaleFromLanguage(String language) {
    if (language == "English") return 'en';
    if (language == "Hindi") return 'hi';
    if (language == "Danish") return 'da';
    if (language == "French") return 'fr';
    return '';
  }
}
