import 'package:ai_chatbot_flutter/controllers/profile_controller.dart';
import 'package:ai_chatbot_flutter/screens/add_card_screen/add_card_screen.dart';
import 'package:ai_chatbot_flutter/screens/home_screen/screen/home_screen.dart';
import 'package:ai_chatbot_flutter/screens/settings_screen/screen/settings_screen.dart';
import 'package:ai_chatbot_flutter/screens/subscription_screen/screen/subscription_screen.dart';
import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/image_assets.dart';
import '../utils/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _index = 1;

  late final ProfileController profileController;

  @override
  void initState() {
    super.initState();

    print('get profile!');
    profileController = Get.put(ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      extendBody: true,
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          return Stack(
            children: [
              _screens[_index],
              Visibility(
                visible: controller.isLoading,
                child: const Scaffold(
                  backgroundColor: Colors.black38,
                  body: Center(
                    child: LoadingIndicator(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        onPressed: () {
          setState(() {
            _index = 1;
          });
        },
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0x30C7F431),
                offset: Offset(0, 14),
                blurRadius: 15,
                spreadRadius: 9,
              ),
            ],
          ),
          child: chatBtnFabIcon,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        color: Colors.transparent,
        notchMargin: 8,
        child: BottomNavigationBar(
          iconSize: 0,
          backgroundColor: const Color(0xff171717),
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color(0xff8b8b8b),
          showUnselectedLabels: true,

          // showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: poppinsRegTextStyle.copyWith(

              // color: Colors.yellow,
              // fontSize: 13,
              ),

          selectedFontSize: 13,
          unselectedFontSize: 13,
          unselectedLabelStyle: poppinsRegTextStyle.copyWith(
              //  const Color(0xff8B8B8B),
              ),
          currentIndex: _index,
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: unselectedSubCardIcon,
              activeIcon: selectedSubCardIcon,
              label: AppLocalizations.of(context)!.subscription,
            ),
            BottomNavigationBarItem(
              icon: Visibility(
                visible: false,
                child: Icon(
                  Icons.abc,
                  size: 0,
                ),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: unselectedSettingsIcon,
              activeIcon: selectedSettingsIcon,
              label: AppLocalizations.of(context)!.setting,
            ),
          ],
        ),
      ),
    );
  }

  final List<Widget> _screens = [
    const SubscrptionScreen(),
    const HomeScreen(),
    const SettingScreen(),
  ];
}
