import 'package:ai_chatbot_flutter/constants/api_const.dart';
import 'package:ai_chatbot_flutter/screens/chat_history_screen/chat_history.dart';
import 'package:ai_chatbot_flutter/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:ai_chatbot_flutter/screens/help_and_support_screen/help_and_support_screen.dart';
import 'package:ai_chatbot_flutter/screens/login_screen/login_screen.dart';
import 'package:ai_chatbot_flutter/screens/privacy_policy_screen.dart/privacy_policy_screen.dart';
import 'package:ai_chatbot_flutter/screens/select_language_screen/select_language_screen.dart';
import 'package:ai_chatbot_flutter/screens/settings_screen/widgets/ListileShimmerWidget.dart';
import 'package:ai_chatbot_flutter/screens/term_and_condition/term_and_condition.dart';
import 'package:ai_chatbot_flutter/services/headers_map.dart';
import 'package:ai_chatbot_flutter/services/network_api.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../services/auth_service.dart';
import '../../../utils/image_assets.dart';
import '../../../utils/text_styles.dart';
import '../../../utils/util.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../current_subscription_screen/current_subscription_scrren.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/settings_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

bool isImage = false;
var stripeId = '';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var name = '';
  var image = '';
  bool isLoading = false;
  var selectedCountryCode = '';
  var email = '';
  var phoneNo = '';
  bool subscription = false;
  bool isUploading = false;

  void initState() {
    super.initState();
    getProfile();
  }

  Future<void> getProfile() async {
    print('getProfile');
    try {
      final headers = {
        "Authorization": authorizationValue,
      };
      var response = await NetworkApi.getResponse(
        url: getProfileUrl,
        headers: headers,
      );
      print('getProfile--$response');
      if (response['code'] == 200) {
        print('ok');
        isLoading = true;
        setState(() {
          name = response['data']['name'];
          selectedCountryCode = response['data']['countryCode'];
          email = response['data']['email'];
          phoneNo = response['data']['phoneNumber'];
          stripeId = response['data']['stripeId'];
          subscription = response['data']['subscription'];
          if (response['data']['image'] != null) {
            print('image');
            image = response['data']['image'];
            isImage = true;
          } else {
            print('image null');
          }
        });
      }
      print('okk');
    } catch (e) {
      print("no");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          CustomAppBar(
            leading: Text(
              AppLocalizations.of(context)!.setting,
              style: poppinsMedTextStyle.copyWith(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            trailing: notificationBadgeIcon,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x15C7F431),
                  Color(0x00171717),
                ],
              ),
            ),
            child: Column(
              children: [
                isLoading
                    ? Row(
                        children: [
                          isImage
                              ? ProfileAvatar(
                                  backgroundImage: NetworkImage(image))
                              : const ProfileAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/avatar.png"),
                                ),
                          const SizedBox(width: 12),
                          Expanded(
                              child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: poppinsMedTextStyle.copyWith(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "V1.1.16",
                                      style: poppinsRegTextStyle.copyWith(
                                        color: Colors.white54,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return EditProfileScreen(
                                          email: email,
                                          image: image,
                                          phoneNo: phoneNo,
                                          selectedCountryCode:
                                              selectedCountryCode,
                                          subscription: subscription,
                                          name: name,
                                        );
                                      },
                                    )).then(
                                      (value) {
                                        getProfile();
                                      },
                                    );
                                  },
                                  icon: editProfileIcon)
                            ],
                          ))
                        ],
                      )
                    : Shimmer.fromColors(
                        baseColor: Colors.grey.shade900,
                        highlightColor: Colors.grey.shade500,
                        child: const ShimmerListTile()),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    children: [
                      SettingsTileWidget(
                        icon: selectLanguageIcon,
                        text: AppLocalizations.of(context)!.selectlan,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const SelectLanguage();
                            },
                          ));
                        },
                      ),
                      SettingsTileWidget(
                        icon: chatHistoryIcon,
                        text: AppLocalizations.of(context)!.chatHistory,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const ChatHistoryScreen();
                            },
                          ));
                        },
                      ),
                      SettingsTileWidget(
                        icon: currentSubscriptionIcon,
                        text: AppLocalizations.of(context)!.currentsubs,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const CurrentSubscriptionScreen();
                            },
                          ));
                        },
                      ),
                      SettingsTileWidget(
                        icon: helpSupportIcon,
                        text: AppLocalizations.of(context)!.helpSupport,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const HelpAndSupportScreen();
                            },
                          ));
                        },
                      ),
                      SettingsTileWidget(
                        icon: termsConditionsIcon,
                        text: AppLocalizations.of(context)!.termcondition,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const TermAndConditionScreen();
                            },
                          ));
                        },
                      ),
                      SettingsTileWidget(
                        icon: privacyPolicyIcon,
                        text: AppLocalizations.of(context)!.privacyPolicy,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const PrivacyPolicyScreen();
                            },
                          ));
                        },
                      ),
                      SettingsTileWidget(
                        icon: logoutIcon,
                        text: AppLocalizations.of(context)!.logout,
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  backgroundColor:
                                      const Color.fromARGB(255, 58, 54, 54),
                                  title: Text(
                                    AppLocalizations.of(context)!.logout,
                                    style: poppinsMedTextStyle.copyWith(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  content: Text(
                                    AppLocalizations.of(context)!.doYouLogOut,
                                    style: poppinsMedTextStyle.copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.no,
                                        style: poppinsRegTextStyle.copyWith(
                                          color: Colors.blue,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.of(ctx).pop();
                                        if (await AuthService().signOut()) {
                                          if (context.mounted) {
                                            showSnackbar(
                                              context: context,
                                              title:
                                                  AppLocalizations.of(context)!
                                                      .successfullyLogOut,
                                            );

                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const LoginScreen()),
                                              (route) => false,
                                            );
                                          }
                                        }
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.yes,
                                        style: poppinsRegTextStyle.copyWith(
                                          color: Colors.blue,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 55),
        ],
      ),
    );
  }

  Future<void> logout() async {
    print('logout');
    final headers = {
      "Authorization": authorizationValue,
    };
    var response =
        await NetworkApi.getResponse(url: logOutUrl, headers: headers);
    print(response);
  }
}
