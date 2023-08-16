import 'dart:async';

import 'package:ai_chatbot_flutter/screens/login_screen/login_screen.dart';
import 'package:ai_chatbot_flutter/screens/signup_screen/signup_screen.dart';
import 'package:ai_chatbot_flutter/services/headers_map.dart';
import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:ai_chatbot_flutter/utils/util.dart';
import 'package:ai_chatbot_flutter/widgets/bottom_bar.dart';
import 'package:ai_chatbot_flutter/widgets/grad_horizontal_divider.dart';
import 'package:ai_chatbot_flutter/widgets/screen_background_widget.dart';
import 'package:ai_chatbot_flutter/widgets/text_white_btn_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/api_const.dart';
import '../../constants/shared_prefs_keys.dart';
import '../../services/network_api.dart';
import '../../utils/ui_parameters.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/gradient_rect_btn_widget.dart';
import '../../widgets/loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNo;
  final String countryCode;
  const OtpScreen({
    super.key,
    required this.countryCode,
    required this.phoneNo,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 60);
  bool canResend = false;
  bool isLoading = false;

  String smsCode = "";
  String _verificationId = "";
  int? _resendToken;
  int maxlength = 10;

  final FirebaseAuth auth = FirebaseAuth.instance;

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(seconds: 60));
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    if (countdownTimer != null && !(countdownTimer!.isActive)) {
      setState(() {
        canResend = true;
      });
    }
    return ScreenBackgroundWidget(
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                ),
                const GradientHorizontalDivider(),
                const SizedBox(height: 40),
                Text(
                  AppLocalizations.of(context)!.submitCode,
                  // "Submit your confirmation\ncode.",
                  style: poppinsSemiBoldTextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.sentMessage,
                      style: poppinsRegTextStyle.copyWith(
                        color: const Color(0xffA9A9A9),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "+${widget.countryCode} ${widget.phoneNo}",
                      style: poppinsMedTextStyle.copyWith(
                        fontSize: 15,
                        color: kPearColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 45),
                TextField(
                  cursorColor: Colors.white,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Color(0xff171717),
                    filled: true,
                  ),
                  style: poppinsMedTextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 17,
                    letterSpacing: 12,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => smsCode = value,
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "00:$seconds",
                      style: poppinsMedTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      onPressed: canResend
                          ? () {
                              resetTimer();
                              startTimer();
                              setState(() {
                                canResend = false;
                              });
                              print("reset");
                              // reSendOTP(
                              //     phone:
                              //         "+{${widget.countryCode}${widget.phoneNo}}");
                              checkAndGetOtp();
                            }
                          : null,
                      child: Text(
                        AppLocalizations.of(context)!.resentOtp,
                        style: poppinsMedTextStyle.copyWith(
                          fontSize: 15,
                          color: canResend ? Colors.white : kGraniteGrayColor,
                        ),
                      ),
                    )
                  ],
                ),
                TextWhiteBtnWidget(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  title: AppLocalizations.of(context)!.verify,
                  onTap: () async {
                    if (!countdownTimer!.isActive) {
                      showSnackbar(
                        context: context,
                        title: AppLocalizations.of(context)!.timeOut,
                      );
                      return;
                    }

                    setState(() {
                      isLoading = true;
                    });

                    // Create a PhoneAuthCredential with the code
                    try {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                        verificationId: LoginScreen.verificationId,
                        smsCode: smsCode,
                      );

                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential);

                      if (await checkAccount()) {
                        loginApiHit();
                        if (context.mounted) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (_) => const BottomBar()),
                            (route) => false,
                          );
                        }
                      } else {
                        if (context.mounted) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (_) => SignupScreen(
                                phoneNo: widget.phoneNo,
                                selectedCountryCode: widget.countryCode,
                              ),
                            ),
                            (route) => false,
                          );
                        }
                      }
                    } catch (e) {
                      showSnackbar(
                        context: context,
                        title: AppLocalizations.of(context)!.wrongOtp,
                      );
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                ),
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

  @override
  void dispose() {
    if (countdownTimer!.isActive) countdownTimer!.cancel();
    super.dispose();
  }

  void checkAndGetOtp() async {
    print('check otp');
    if (widget.phoneNo.length != maxlength) {
      showSnackbar(
        context: context,
        title: "Invalid phone number",
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+${widget.countryCode}${widget.phoneNo}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('vericication failed-----------------------------------');
        print(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        LoginScreen.verificationId = verificationId;

        print('code send');
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = LoginScreen.verificationId;
      },
    );
    setState(() {
      isLoading = false;
    });
  }

  // Future<bool> reSendOTP({required String phone}) async {
  //   print('resend otp');
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: phone,
  //     verificationCompleted: (PhoneAuthCredential credential) {
  //       print('phone verification completed');
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       print('failed verification-------------$e');
  //     },
  //     codeSent: (String verificationId, int? resendToken) async {
  //       _verificationId = verificationId;
  //       _resendToken = resendToken;
  //     },
  //     timeout: const Duration(seconds: 50),
  //     forceResendingToken: _resendToken,
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       verificationId = _verificationId;
  //     },
  //   );
  //   debugPrint("_verificationId: $_verificationId");
  //   return true;
  // }

  Future<bool> checkAccount() async {
    try {
      print('check account');
      var response = await NetworkApi.post200(
        url: checkAccountUrl,
        body: {
          "countryCode": "+${widget.countryCode}",
          "phoneNumber": widget.phoneNo,
        },
      );
      print(response);
      if (response["code"] != 200) return false;
      print('number exit');
      return response["data"]["isUser"];
    } catch (e) {
      return false;
    }
  }

  void loginApiHit() async {
    try {
      print('hit login api');
      var response = await NetworkApi.post200(
        url: loginUrl,
        body: {
          "countryCode": "+${widget.countryCode}",
          "phoneNumber": widget.phoneNo,
        },
      );
      if (response["code"] != 200) {
        showSnackbar(
          context: context,
          title: response["message"],
        );
        return;
      }

      authorizationValue = response["data"]["token"];

      saveToPrefs(response["data"]);
      print("saved to prefs");
    } catch (e) {
      print('error in loginHit api - $e');
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
}
