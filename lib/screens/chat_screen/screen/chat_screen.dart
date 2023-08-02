import 'dart:io';
import 'package:ai_chatbot_flutter/constants/api_const.dart';
import 'package:ai_chatbot_flutter/controllers/chat_controller.dart';
import 'package:ai_chatbot_flutter/services/headers_map.dart';
import 'package:ai_chatbot_flutter/services/network_api.dart';
import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/utils/image_assets.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:ai_chatbot_flutter/utils/ui_parameters.dart';
import 'package:ai_chatbot_flutter/utils/util.dart';
import 'package:ai_chatbot_flutter/widgets/half_grad_container.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/gradient_text.dart';
import '../../../widgets/loading_indicator.dart';
import '../../chat_history_screen/chat_history.dart';
import '../widget/chat_widget.dart';
import '../widget/docbox_widget.dart';
import '../widget/send_message_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String sessionId = '';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    this.session_id,
  });
  final String? session_id;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String msg = '';
  bool loading = false;

  final TextEditingController textController = TextEditingController();
  late ScrollController _listScrollController;

  late dynamic pdf;
  late final ChatController chatController;

  bool circularIndicatorShow = false;
  @override
  void initState() {
    super.initState();
    try {
      print('1');
      _listScrollController = ScrollController();
      print('2');
      chatController = Get.put(ChatController());
      print('3');
      if (widget.session_id == null) {
        print('4');
        chatNow();
        print('5');
      } else {
        print('6');
        chatController.getSessionHistory(widget.session_id!);
        print('7');
        setState(() {
          chatController.getsession_id = true;
          sessionId = widget.session_id!;
          print('8');
        });
      }
    } catch (e) {
      print("8");
      print(e);
    }
  }

  Future<void> chatNow() async {
    print('chat Now');
    setState(() {
      circularIndicatorShow = true;
    });
    try {
      final headers = {
        "Authorization": authorizationValue,
      };
      var response =
          await NetworkApi.post(url: newChatUrl, body: {}, headers: headers);
      print("okkkk chat now");
      print(response);
      print(response['data']);
      if (response['message'] == "Success") {
        sessionId = response['data']['sessionId'];
      }
      print('sessionId-----------------------$sessionId');
    } catch (e) {
      print(e);
    }
    setState(() {
      circularIndicatorShow = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomAppBar(
                  leading: leftArrowIcon,
                  title: AppLocalizations.of(context)!.aiChatbot,
                  trailing: uploadIcon,
                  leadingOnTap: () => Navigator.of(context).pop(),
                  trailingOnTap: () => showExportBottomSheet(context),
                ),
              ),
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    controller: _listScrollController,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    physics: const ClampingScrollPhysics(),
                    itemCount: chatController.getChatList.length,
                    itemBuilder: (context, index) {
                      var chat = chatController.getChatList[index];
                      return ChatWidget(
                        text: chat.msg!,
                        isSender: chat.isUser ?? false,
                      );
                    },
                  ),
                ),
              ),
              Obx(
                () => chatController.isTyping.value
                    ? const SpinKitThreeBounce(
                        color: Colors.grey,
                        size: 18,
                      )
                    : const SizedBox.shrink(),
              ),
              SendMessageWidget(
                textController: textController,
                onTap: () async {
                  await sendMessageFCT(controller: chatController);
                },
              ),
            ],
          ),
          Visibility(
            visible: circularIndicatorShow,
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
    Get.delete<ChatController>();
    _listScrollController.dispose();
    super.dispose();
  }

  void scrollListToEND() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    });

    print("scrolled");
  }

  Future<void> sendMessageFCT({required ChatController controller}) async {
    if (controller.isTyping.value || textController.text.isEmpty) return;

    if (controller.msgCounter == 10) {
      showChatLimitExhaustedBottomSheet(context);
      return;
    }

    try {
      msg = textController.text.trim();
      textController.clear();
      controller.addUserMessage(msg: msg);

      if (controller.msgCounter == 0) {
        controller.titleChat(msg);
      }
      controller.sendMessage(msg);
      setState(() {
        scrollListToEND();
      });

      await controller.sendMessageAndGetAnswers(
        msg: msg,
        chosenModelId: "gpt-3.5-turbo",
      );
      // List<String> answers = controller.getAnswers();
      String? ans = controller.getCurrentAnswer();
      controller.replyMessage(ans!);
      // print('Answers: $answers');
      print('ans--$ans');
      setState(() {
        scrollListToEND();
      });
    } catch (error) {
      showSnackbar(
        context: context,
        title: error.toString(),
      );
    }
  }

  Future<dynamic> showChatLimitExhaustedBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: closeCircleIcon,
            ),
            const SizedBox(height: 10),
            DecoratedBox(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                color: Colors.white,
              ),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffF9F3FF),
                      Color(0x00F9F3FF),
                      Color(0x00F9F3FF),
                      Color(0x00F9F3FF),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    const BottomSheetHeadDivider(),
                    oopsEmojiIcon,
                    Text(
                      AppLocalizations.of(context)!.oopsChatLimit,
                      // "Oops you have exhausted\nyour chat limit",
                      textAlign: TextAlign.center,
                      style: poppinsMedTextStyle.copyWith(
                        fontSize: 20,
                        color: const Color(0xff313131),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xffF9F3FF),
                            Color(0x00F9F3FF),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 35),
                          Text(
                            AppLocalizations.of(context)!.buySubscripstion,
                            // "Buy the subscription and get all\nyour issues resolved",
                            textAlign: TextAlign.center,
                            style: poppinsMedTextStyle.copyWith(
                              fontSize: 20,
                              color: const Color(0xff313131),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: HalfGradContainer(
                                        onpress: () {},
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 22),
                                        borderGradientcolors:
                                            pinkBorderGradientColor,
                                        innerGradientcolors:
                                            pinkSurfaceGradColor,
                                        child: Column(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .weekly,
                                              style:
                                                  poppinsRegTextStyle.copyWith(
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              "₹ 800.00",
                                              style:
                                                  poppinsMedTextStyle.copyWith(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 13),
                                    Expanded(
                                      child: HalfGradContainer(
                                        onpress: () {},
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 22),
                                        borderGradientcolors:
                                            pinkBorderGradientColor,
                                        innerGradientcolors:
                                            pinkSurfaceGradColor,
                                        child: Column(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .weekly,
                                              style:
                                                  poppinsRegTextStyle.copyWith(
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              "₹ 800.00",
                                              style:
                                                  poppinsMedTextStyle.copyWith(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 22),
                                HalfGradContainer(
                                  onpress: () {},
                                  padding: const EdgeInsets.all(20),
                                  borderGradientcolors: pinkBorderGradientColor,
                                  innerGradientcolors: pinkSurfaceGradColor,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "1 DAY",
                                        style: poppinsRegTextStyle.copyWith(
                                          color: kBlackColor,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        "₹ 300.00",
                                        style: poppinsMedTextStyle.copyWith(
                                          color: kBlackColor,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  padding: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                    color: Color(0xffC082FF),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Color(0xffC082FF),
                                      ),
                                      BoxShadow(
                                        color: Color(0xffE0E0E0),
                                        spreadRadius: -20.0,
                                        blurRadius: 10.0,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "1 DAY",
                                        style: poppinsRegTextStyle.copyWith(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        "₹ 300.00",
                                        style: poppinsMedTextStyle.copyWith(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> getPdf(String msg, String type) async {
    try {
      setState(() {
        loading = true;
      });

      if (Platform.isAndroid) {
        if (await requestPermission(Permission.storage)) {
          print('get pdf1');
          final headers = {"Authorization": authorizationValue};

          final response = await Dio().get(
            "$baseUrl$getPdfUrl$sessionId",
            options: Options(
              headers: headers,
              responseType: ResponseType.bytes,
            ),
          );
          print('get pdf2');
          Directory? appDocumentsDirectory =
              await getExternalStorageDirectory();
          String filePath = '${appDocumentsDirectory!.path}/chatbot.docx';
          String newPath = '';
          List<String> folders = appDocumentsDirectory.path.split('/');
          for (int x = 1; x < folders.length; x++) {
            String folder = folders[x];
            if (folder != 'Android') {
              newPath += "/$folder"; // /storage/emulated/0
            } else {
              break;
            }
          }
          newPath = "$newPath/Download/${msg.trim()}.$type";

          print("appDocumentsDirectory.path---${appDocumentsDirectory.path}");
          File file = File(newPath);
          print('get pdf3-$newPath');

          await file.writeAsBytes(response.data);
          print('get pdf5');

          showSnackbar(
            context: context,
            title: " ${type.toUpperCase()} download successfully",
          );
        }
      } else {
        print('not android');
      }
    } catch (e) {
      print('get pdf4');
      showSnackbar(
        context: context,
        title: "Error downloading ${type.toUpperCase()}",
      );
      print('error====$e');
    }
    setState(() {
      loading = false;
    });
  }

  Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<dynamic> showExportBottomSheet(
    BuildContext context,
  ) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: closeCircleIcon,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  const BottomSheetHeadDivider(),
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.exportChatHistory,
                    style: poppinsMedTextStyle.copyWith(
                      fontSize: 20,
                      color: kBlackColor,
                    ),
                  ),
                  GradientText(
                    AppLocalizations.of(context)!.onlyPromber,
                    style: poppinsRegTextStyle.copyWith(fontSize: 20),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xffC082FF),
                        Color(0xffB0DD1B),
                        Color(0xffC192E2),
                        Color(0xffC082FF),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DocBoxWidget(
                          text: "PDF",
                          onpress: () {
                            if (msg == '') {
                              msg = title;
                            }
                            getPdf(msg, 'pdf');
                            Navigator.pop(context);
                          }),
                      SizedBox(width: 10),
                      DocBoxWidget(
                          text: "DOC",
                          onpress: () {
                            if (msg == '') {
                              msg = title;
                            }
                            getPdf(msg, 'docx');
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class BottomSheetHeadDivider extends StatelessWidget {
  const BottomSheetHeadDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      width: 40,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xffBABABA),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    );
  }
}
//  Directory appDocumentsDirectory =
//           await getApplicationDocumentsDirectory();
//       String newPath = '';
//       List<String> folders = appDocumentsDirectory.path.split('/');
//       for (int x = 1; x < folders.length; x++) {
//         String folder = folders[x];
//         if (folder != 'Android') {
//           newPath += "/" + folder;
//         } else {
//           break;
//         }
//       }
//       newPath = newPath + "/downloads";
//       appDocumentsDirectory = Directory(newPath);
//       String filePath = '${appDocumentsDirectory.path}/chatbot.pdf';

//       File file = File(filePath);


// get pdf3-/data/user/0/com.example.ai_chatbot_flutter/app_flutter/chatbot.pdf