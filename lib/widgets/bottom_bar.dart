import 'package:ai_chatbot_flutter/controllers/profile_controller.dart';
import 'package:ai_chatbot_flutter/screens/home_screen/screen/home_screen.dart';
import 'package:ai_chatbot_flutter/screens/settings_screen/screen/settings_screen.dart';
import 'package:ai_chatbot_flutter/screens/subscription_screen/screen/subscription_screen.dart';
import 'package:ai_chatbot_flutter/utils/colors.dart';
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

  @override
  void initState() {
    super.initState();
    ProfileController profileController = Get.put(ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      extendBody: true,
      body: _screens[_index],

      // Stack(
      //   children: [
      //     const SizedBox(
      //       height: double.infinity,
      //       width: double.infinity,
      //       child: DecoratedBox(
      //         decoration: BoxDecoration(
      //           color: Colors.transparent,
      //         ),
      //       ),
      //     ),
      //     Container(
      //       // height: double.infinity,
      //       // width: double.infinity,
      //       decoration: const BoxDecoration(
      //         gradient: RadialGradient(
      //           center: Alignment.topLeft,
      //           radius: 1.2,
      //           colors: [
      //             Color(0x40C7F431),
      //             Color(0x00C7F431),
      //           ],
      //         ),
      //       ),
      //       child: _screens[_index],
      //     ),
      //   ],
      // ),

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
