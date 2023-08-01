import 'package:ai_chatbot_flutter/screens/login_screen/login_screen.dart';
import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/utils/image_assets.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:flutter/material.dart';
import '../../../widgets/text_white_btn_widget.dart';
import '../widgets/dot_indicator.dart';
import '../widgets/walkthrough_content.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WalkthroughScreenOne extends StatefulWidget {
  const WalkthroughScreenOne({super.key});

  @override
  State<WalkthroughScreenOne> createState() => _WalkthroughScreenOneState();
}

class _WalkthroughScreenOneState extends State<WalkthroughScreenOne> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 25,
              bottom: 2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 10),
                  child: TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.skip,
                      style: poppinsRegTextStyle.copyWith(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const ClampingScrollPhysics(),
              itemCount: 2,
              onPageChanged: (value) {
                setState(() {
                  _pageIndex = value;
                });
              },
              itemBuilder: (context, index) {
                return WalkthroughContent(
                  icon: _onboardData[index]["image"],
                  text: _onboardData[index]["text"],
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                2,
                (index) => DotIndicator(isAcitve: index == _pageIndex),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextWhiteBtnWidget(
            onTap: () {
              if (_pageIndex == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
                return;
              }
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
            title: _pageIndex == 0
                ? AppLocalizations.of(context)!.next
                : AppLocalizations.of(context)!.getStarted,
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

List _onboardData = [
  {
    "image": helloAiBotIcon,
    "text": "Welcome to your personal\nchat solution",
  },
  {
    "image": aiChatBotIcon,
    "text": "Get your solution on a\nsingle click",
  },
];
