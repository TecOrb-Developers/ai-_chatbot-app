import 'dart:convert';
import 'package:ai_chatbot_flutter/constants/api_const.dart';
import 'package:ai_chatbot_flutter/constants/shared_prefs_keys.dart';
import 'package:ai_chatbot_flutter/services/headers_map.dart';
import 'package:ai_chatbot_flutter/services/network_api.dart';
import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/utils/image_assets.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:ai_chatbot_flutter/utils/ui_parameters.dart';
import 'package:ai_chatbot_flutter/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gradient_borders/gradient_borders.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/gradient_back_widget.dart';
import '../../../widgets/screen_background_widget.dart';
import '../../chat_screen/screen/chat_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenBackgroundWidget(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const CustomAppBar(
              leading: botIcon,
              trailing: notificationBadgeIcon,
            ),
            homeBotIcon,
            aiTextIcon,
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ChatScreen()),
                );
              },
              child: GradientBackWidget(
                topChild: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.chatNow,
                      style: poppinsMedTextStyle.copyWith(
                        fontSize: 16,
                        color: kBlackColor,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.freemess,
                      style: poppinsLightTextStyle.copyWith(
                        color: kBlackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 110,
            ),
            // if (circularIndicatorShow) const LoadingIndicator(),
          ],
        ),
      ),
    );
  }
}

class SquareBtnIconBadge extends StatelessWidget {
  const SquareBtnIconBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: GradientBoxBorder(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: whiteGradientBoxColor,
              ),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.notification_add_sharp,
            color: Colors.white,
          ),
        ),
        Positioned(
          top: -1,
          right: -1,
          child: Container(
            height: 15,
            width: 15,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: kBlackColor,
              shape: BoxShape.circle,
            ),
            child: Container(
              height: 10,
              width: 10,
              decoration: const BoxDecoration(
                color: kPearColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
