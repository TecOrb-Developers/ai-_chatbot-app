import 'package:ai_chatbot_flutter/constants/api_const.dart';
import 'package:ai_chatbot_flutter/constants/chatHistoryItem_class.dart';
import 'package:ai_chatbot_flutter/screens/chat_history_screen/chat_history_box.dart';
import 'package:ai_chatbot_flutter/screens/chat_screen/screen/chat_screen.dart';
import 'package:ai_chatbot_flutter/services/headers_map.dart';
import 'package:ai_chatbot_flutter/services/network_api.dart';
import 'package:ai_chatbot_flutter/widgets/gradient_rect_btn_widget.dart';
import 'package:ai_chatbot_flutter/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/ui_parameters.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/grad_horizontal_divider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String title = '';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  String formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    if (date.isAtSameMomentAs(today)) {
      return 'Today ${DateFormat('h:mm a').format(date)}';
    } else if (date.isAtSameMomentAs(yesterday)) {
      return 'Yesterday ${DateFormat('h:mm a').format(date)}';
    } else {
      return DateFormat('MMM d, yyyy').format(date);
    }
  }

  Future<List<ChatHistoryItem>> getChatHistory() async {
    print('Chat History');
    try {
      final headers = {
        "Authorization": authorizationValue,
      };
      var response =
          await NetworkApi.getResponse(url: chatHistorUrl, headers: headers);
      print('chat History Response-$response');

      List<dynamic> responseData = response['data'];
      List<ChatHistoryItem> chatHistory = responseData.map((item) {
        return ChatHistoryItem(
            text: item['title'],
            time: item['time'],
            sessionItemId: item['_id'],
            date: item['date']);
      }).toList();
      print('chatHistory-$chatHistory');
      return chatHistory;
    } catch (e) {
      print(e);
      return []; // Return an empty list on error
    }
  }

  void initState() {
    super.initState();
    getChatHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
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
              title: AppLocalizations.of(context)!.chatHistory,
            ),
            const GradientHorizontalDivider(),
            // const SizedBox(height: 20),
            FutureBuilder<List<ChatHistoryItem>>(
              future: getChatHistory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(
                    child: Center(child: LoadingIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<ChatHistoryItem> chatHistory = snapshot.data ?? [];
                  return Expanded(
                    child: ListView.builder(
                      itemCount: chatHistory.length,
                      itemBuilder: (context, index) {
                        title = chatHistory[index].text;
                        return ChatHistoryBox(
                            onpress: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return ChatScreen(
                                    session_id:
                                        chatHistory[index].sessionItemId,
                                  );
                                },
                              ));
                            },
                            text: chatHistory[index].text,
                            time: formatDate(chatHistory[index].date));
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
