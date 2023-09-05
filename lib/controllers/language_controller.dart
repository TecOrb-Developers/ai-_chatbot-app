import 'package:ai_chatbot_flutter/services/headers_map.dart';
import 'package:ai_chatbot_flutter/utils/share_prefs_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  RxString selectedLanguage = 'English'.obs;
  var selectLocale = " en".obs;

  void setLanguage(String language, String locale) async {
    selectedLanguage.value = language;
    // selectLocale.value = locale;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale);
    await prefs.setString('selectedLang', language);
    print(selectLocale);
    print(selectedLanguage);
    Get.updateLocale(Locale(locale));
  }

  Future<void> giveLocal() async {
    print('hello');
    final prefs = await SharedPreferences.getInstance();
    selectLocale.value = (prefs.getString(locale) ?? 'en');
    // localizationValue = (prefs.getString(locale) ?? 'en');
    selectedLanguage.value = prefs.getString(selectedLang) ?? "English";
  }
}
