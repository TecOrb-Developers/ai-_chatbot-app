import 'package:ai_chatbot_flutter/constants/api_const.dart';
import 'package:ai_chatbot_flutter/screens/walkthrough_screens/screens/walkthrough_screen1.dart';
import 'package:ai_chatbot_flutter/services/auth_service.dart';
import 'package:ai_chatbot_flutter/services/network_api.dart';
import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/utils/image_assets.dart';
import 'package:ai_chatbot_flutter/utils/share_prefs_keys.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:ai_chatbot_flutter/utils/util.dart';
import 'package:ai_chatbot_flutter/widgets/bottom_bar.dart';
import 'package:ai_chatbot_flutter/widgets/screen_background_widget.dart';
import 'package:ai_chatbot_flutter/widgets/text_white_btn_widget.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/grad_horizontal_divider.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/logo_text_button.dart';
import '../../widgets/or_grad_divider.dart';
import '../otp_screen/otp_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String verificationId = "";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  String phoneNo = "";
  String selectedCountryCode = "91";
  int maxLength = 10;

  late final TextEditingController phoneTextController;

  @override
  void initState() {
    phoneTextController = TextEditingController();
    super.initState();
    print('login page');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBackgroundWidget(
      child: Stack(
        children: [
          SingleChildScrollView(
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
                  //   onTap: () => Navigator.of(context).pop(),
                  // ),
                  trailing: botIcon,
                ),
                const GradientHorizontalDivider(),
                const SizedBox(height: 45),
                Text(
                  AppLocalizations.of(context)!.enterMobileNo,
                  style: poppinsSemiBoldTextStyle.copyWith(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
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
                      GestureDetector(
                        onTap: () => showCountryPickerBottomSheet(context),
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              mobileIcon,
                              const SizedBox(width: 10),
                              Text(
                                "+$selectedCountryCode",
                                style: poppinsRegTextStyle.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.white,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          textAlign: TextAlign.left,
                          maxLength: maxLength,
                          controller: phoneTextController,
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
                        ),
                      ),
                    ],
                  ),
                ),
                // TextField(
                //   controller: phoneTextController,
                //   cursorColor: Colors.white,
                //   decoration: const InputDecoration(
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(12)),
                //       borderSide: BorderSide.none,
                //     ),
                //     prefixIcon: mobileIcon,
                //     fillColor: Color(0xff171717),
                //     filled: true,
                //   ),
                //   style: poppinsRegTextStyle.copyWith(
                //     color: Colors.white,
                //   ),
                //   onChanged: (value) => phoneNo = value,
                // ),
                TextWhiteBtnWidget(
                  onTap: checkAndGetOtp,
                  title: AppLocalizations.of(context)!.sendOtp,
                  margin: const EdgeInsets.symmetric(vertical: 30),
                ),

                const OrGradDivider(),

                const SizedBox(height: 20),
                LogoTextBtnWidget(
                  icon: googleLogoIcon,
                  text: AppLocalizations.of(context)!.googleLogin,
                  onTap: () {},
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "Don't have an account?",
                //       style: poppinsRegTextStyle.copyWith(
                //         color: Colors.white,
                //         fontSize: 15,
                //       ),
                //     ),
                //     TextButton(
                //       onPressed: () => Navigator.of(context).pushReplacement(
                //         MaterialPageRoute(builder: (_) => const SignupScreen()),
                //       ),
                //       child: Text(
                //         "Sign Up",
                //         style: poppinsRegTextStyle.copyWith(
                //           color: kPearColor,
                //           fontSize: 15,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
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

  void showCountryPickerBottomSheet(BuildContext context) {
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
            // borderSide: BorderSide(color: kAccentColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                // color: kLightestTextColor,
                ),
          ),
          hintText: "Enter your country name or code",
          contentPadding: const EdgeInsets.only(left: 28),
          hintStyle: const TextStyle(
            // color: kLightestTextColor,
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

  @override
  void dispose() {
    phoneTextController.dispose();
    super.dispose();
  }

  Future<bool> checkAccount() async {
    try {
      var response = await NetworkApi.post200(
        url: checkAccountUrl,
        body: {
          "countryCode": "+$selectedCountryCode",
          "phoneNumber": phoneNo,
        },
      );
      print(response);
      if (response["code"] != 200) return false;

      return response["data"]["isUser"];
    } catch (e) {
      return false;
    }
  }

  void checkAndGetOtp() async {
    print('check otp');
    if (phoneNo.length != maxLength) {
      showSnackbar(
        context: context,
        title: "Invalid phone number",
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // if (!(await checkAccount()) && context.mounted) {
    //   setState(() {
    //     isLoading = false;
    //   });
    //   showSnackbar(
    //     context: context,
    //     title: "User doesn't exist. Please signup first",
    //   );
    //   return;
    // }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+$selectedCountryCode$phoneNo",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('verification failed -----------------------------------');
        print(e);
        setState(() {
          isLoading = false;
        });
        showSnackbar(context: context, title: "Verification Failed");
        // Navigator.push(context, MaterialPageRoute(
        //   builder: (context) {
        //     return const WalkthroughScreenOne();
        //   },
        // ));
      },
      codeSent: (String verificationId, int? resendToken) {
        LoginScreen.verificationId = verificationId;

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => OtpScreen(
              phoneNo: phoneNo,
              countryCode: selectedCountryCode,
            ),
          ),
        );
        print('code send');
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = LoginScreen.verificationId;
      },
    );
  }

  // Future<void> loginWithGoogle(BuildContext context) async {
  //   print('login with google');
  //   setState(() {
  //     isLoading = true;
  //   });
  //   if (await AuthService().signInWithGoogle()) {
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool(isLoggedIn, true);

  //     setState(() {
  //       isLoading = false;
  //     });

  //     if (context.mounted) {
  //       showSnackbar(
  //         context: context,
  //         title: "You have successfully logged in",
  //       );

  //       Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (_) => const BottomBar()),
  //         (route) => false,
  //       );
  //     }
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }
}
