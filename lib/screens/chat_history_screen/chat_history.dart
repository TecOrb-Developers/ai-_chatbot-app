import 'package:ai_chatbot_flutter/constants/api_const.dart';
import 'package:ai_chatbot_flutter/constants/chatHistoryItem_class.dart';
import 'package:ai_chatbot_flutter/screens/chat_history_screen/chat_history_box.dart';
import 'package:ai_chatbot_flutter/screens/chat_screen/screen/chat_screen.dart';
import 'package:ai_chatbot_flutter/services/headers_map.dart';
import 'package:ai_chatbot_flutter/services/network_api.dart';
import 'package:ai_chatbot_flutter/widgets/gradient_rect_btn_widget.dart';
import 'package:ai_chatbot_flutter/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../utils/ui_parameters.dart';
import '../../utils/util.dart';
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
  List<ChatHistoryItem> chatHistory = [];
  bool isHistory = false;

  String formatDate(String dateString, String time) {
    final date = DateTime.parse(dateString);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    if (date.isAtSameMomentAs(today)) {
      return 'Today $time';
    } else if (date.isAtSameMomentAs(yesterday)) {
      return 'Yesterday $time';
    } else {
      return DateFormat('MMM d, yyyy').format(date);
    }
  }

  Future<List<ChatHistoryItem>> getChatHistory() async {
    print('Chat History');
    try {
      setState(() {
        isHistory = true;
      });
      final headers = {
        "Authorization": authorizationValue,
      };
      var response =
          await NetworkApi.getResponse(url: chatHistorUrl, headers: headers);
      print('chat History Response-$response');

      List<dynamic> responseData = response['data'];
      setState(() {
        chatHistory = responseData.map((item) {
          return ChatHistoryItem(
              text: item['title'],
              time: item['time'],
              sessionItemId: item['_id'],
              date: item['date']);
        }).toList();
      });
      setState(() {
        isHistory = false;
      });
      print('chatHistory-${chatHistory[0].sessionItemId}');
      return chatHistory;
    } catch (e) {
      print(e);
      return []; // Return an empty list on error
    }
  }

  void initState() {
    print('init state');
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
            const SizedBox(height: 20),
            isHistory
                ? const Expanded(
                    child: Center(
                      child: LoadingIndicator(),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: chatHistory.length,
                      itemBuilder: (context, index) {
                        title = chatHistory[index].text;

                        return Slidable(
                          key: ValueKey(index),
                          endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 58, 54, 54),
                                            title: Text(
                                              'Remove Chat',
                                              style:
                                                  poppinsMedTextStyle.copyWith(
                                                color: Colors.white,
                                                fontSize: 17,
                                              ),
                                            ),
                                            content: Text(
                                              "Do you really want to remove this Chat ?",
                                              style:
                                                  poppinsMedTextStyle.copyWith(
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
                                                  'No',
                                                  style: poppinsRegTextStyle
                                                      .copyWith(
                                                    color: Colors.blue,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  deleteSession(
                                                      chatHistory[index]
                                                          .sessionItemId);
                                                  setState(() {
                                                    chatHistory.removeAt(index);
                                                  });

                                                  Navigator.of(ctx).pop();
                                                },
                                                child: Text(
                                                  'Yes',
                                                  style: poppinsRegTextStyle
                                                      .copyWith(
                                                    color: Colors.blue,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  foregroundColor: Colors.red,
                                  backgroundColor: kBlackColor,
                                  icon: Icons.delete_sweep_outlined,
                                ),
                              ]),
                          child: ChatHistoryBox(
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
                              time: formatDate(chatHistory[index].date,
                                  chatHistory[index].time)),
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Future<void> deleteSession(String session_id) async {
    try {
      print('delete Session');
      final headers = {"Authorization": authorizationValue};
      var response = await NetworkApi.getResponse(
          url: '$deleteSessionUrl$session_id', headers: headers);
      if (response['message'] == 'Success') {
        showSnackbar(
          context: context,
          title: response['message'],
        );
      }
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
