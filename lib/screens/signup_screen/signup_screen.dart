import 'package:ai_chatbot_flutter/constants/api_const.dart';
import 'package:ai_chatbot_flutter/services/network_api.dart';
import 'package:ai_chatbot_flutter/utils/image_assets.dart';
import 'package:ai_chatbot_flutter/widgets/bottom_bar.dart';
import 'package:ai_chatbot_flutter/widgets/grad_horizontal_divider.dart';
import 'package:ai_chatbot_flutter/widgets/loading_indicator.dart';
import 'package:ai_chatbot_flutter/widgets/screen_background_widget.dart';
import 'package:ai_chatbot_flutter/widgets/text_white_btn_widget.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/shared_prefs_keys.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../utils/util.dart';
import '../../widgets/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupScreen extends StatefulWidget {
  final String phoneNo;
  final String selectedCountryCode;
  const SignupScreen({
    super.key,
    required this.phoneNo,
    required this.selectedCountryCode,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String email = "";
  String name = "";
  String phoneNo = "";
  String selectedCountryCode = "91";
  int maxLength = 10;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    phoneNo = widget.phoneNo;
    selectedCountryCode = widget.selectedCountryCode;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBackgroundWidget(
      child: Stack(
        children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(
                    // leading: GradientRectBtnWidget(
                    //   padding: paddingAll10,
                    //   colors: whiteGradientBoxColor,
                    //   child: backArrowIcon,
                    //   // onTap: () => Navigator.of(context).pop(),
                    // ),
                    trailing: botIcon,
                  ),
                  const GradientHorizontalDivider(),
                  const SizedBox(height: 40),
                  Text(
                    AppLocalizations.of(context)!.createAccount,
                    style: poppinsSemiBoldTextStyle.copyWith(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    AppLocalizations.of(context)!.fullName,
                    style: interRegTextStyle.copyWith(
                      color: kGraniteGrayColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: userIcon,
                      fillColor: Color(0xff171717),
                      filled: true,
                    ),
                    keyboardType: TextInputType.name,
                    maxLength: 20,
                    style: poppinsRegTextStyle.copyWith(
                      color: Colors.white,
                    ),
                    onChanged: (value) => name = value,
                    validator: (value) {
                      if (value == '') {
                        return AppLocalizations.of(context)!.enterTheName;
                      }
                      if (!nameRegExp.hasMatch(value!)) {
                        return 'Only alphabets are allowed';
                      }
                      if (value.length < 3) {
                        return 'Enter at least 3 character';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 22),
                  Text(
                    AppLocalizations.of(context)!.email,
                    style: interRegTextStyle.copyWith(
                      color: kGraniteGrayColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: emailIcon,
                      fillColor: Color(0xff171717),
                      filled: true,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    style: poppinsRegTextStyle.copyWith(
                      color: Colors.white,
                    ),
                    onChanged: (value) => email = value,
                    validator: (value) {
                      if (value == '') {
                        return AppLocalizations.of(context)!.enterTheEmail;
                      }
                      if (!emailRegExp.hasMatch(value!)) {
                        return 'Enter correct email';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 22),
                  Text(
                    AppLocalizations.of(context)!.mobileNo,
                    style: interRegTextStyle.copyWith(
                      color: kGraniteGrayColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 18,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xff171717),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Row(
                      children: [
                        mobileIcon,
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            initialValue: "+$selectedCountryCode $phoneNo",
                            enabled: false,
                            textAlign: TextAlign.left,
                            maxLength: maxLength,
                            // controller: phoneTextController,
                            cursorColor: Colors.white,
                            maxLines: 1,

                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                            ),
                            style: poppinsRegTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            keyboardType: TextInputType.number,

                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                RegExp(r"[0-9]"),
                              ),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (value) {
                              phoneNo = value;
                            },
                            // validator: (value) {
                            //   if (value == '') {
                            //     return 'enter the number';
                            //   } else if (!nameRegExp.hasMatch(value!)) {
                            //     return 'enter the valid number';
                            //   }

                            //   return null;
                            // },
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextWhiteBtnWidget(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    title: AppLocalizations.of(context)!.signUp,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        signup();
                      } else {
                        showSnackbar(
                          context: context,
                          title: 'not validate',
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isLoading,
            child: const Scaffold(
              backgroundColor: Colors.black38,
              body: Center(
                child: LoadingIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void signup() async {
    // if (name.isEmpty) {
    //   showSnackbar(
    //     context: context,
    //     title: AppLocalizations.of(context)!.fillName,
    //   );
    //   return;
    // }
    // if (email.isEmpty) {
    //   showSnackbar(
    //     context: context,
    //     title: AppLocalizations.of(context)!.fillEmail,
    //   );
    //   return;
    // }
    // if (!isValidEmail(email)) {
    //   showSnackbar(
    //     context: context,
    //     title: AppLocalizations.of(context)!.invalidEmail,
    //   );
    //   return;
    // }

    try {
      setState(() {
        isLoading = true;
      });

      var response = await NetworkApi.post(
        url: signupUrl,
        body: {
          "name": name,
          "email": email,
          "countryCode": "+$selectedCountryCode",
          "phoneNumber": phoneNo,
        },
      );

      print(response.toString());

      if (response["code"] != 201 && context.mounted) {
        showSnackbar(
          context: context,
          title: response["message"],
        );
        setState(() {
          isLoading = false;
        });
        return;
      }

      if (response["code"] == 201) loginApiHit();

      if (context.mounted && response != null) {
        showSnackbar(
          context: context,
          title: AppLocalizations.of(context)!.successfullyLogin,
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const BottomBar()),
          (route) => false,
        );
      }
    } catch (e) {
      showSnackbar(
        context: context,
        title: AppLocalizations.of(context)!.someErrorOccur,
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  void loginApiHit() async {
    try {
      var response = await NetworkApi.post200(
        url: loginUrl,
        body: {
          "countryCode": "+$selectedCountryCode",
          "phoneNumber": phoneNo,
        },
      );
      if (response["code"] != 200) {
        showSnackbar(
          context: context,
          title: response["message"],
        );
        return;
      }

      saveToPrefs(response["data"]);
      print("saved to prefs");
    } catch (e) {
      // TODO
    }
  }

  void saveToPrefs(Map data) async {
    final prefs = await SharedPreferences.getInstance();

    await Future.wait([
      prefs.setString(userTokenKey, data["token"]),
      prefs.setString(nameKey, data["name"]),
      prefs.setString(id, data["_id"]),
    ]);
  }

  void countryPickerBottomSheet(BuildContext context) {
    return showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
        borderRadius: BorderRadius.circular(20),
        inputDecoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                // color: kLightestTextColor,
                ),
          ),
          hintText: AppLocalizations.of(context)!.enterCountryName,
          contentPadding: const EdgeInsets.only(left: 28),
          hintStyle: const TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      onSelect: (Country country) {
        setState(() {
          maxLength = country.example.length;
          selectedCountryCode = country.phoneCode;
        });
      },
    );
  }
}
