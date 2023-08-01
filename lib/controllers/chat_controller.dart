import 'package:ai_chatbot_flutter/constants/api_const.dart';
import 'package:ai_chatbot_flutter/models/chat_model.dart';
import 'package:ai_chatbot_flutter/screens/chat_screen/screen/chat_screen.dart';
import 'package:ai_chatbot_flutter/services/headers_map.dart';
import 'package:ai_chatbot_flutter/services/network_api.dart';
import 'package:get/state_manager.dart';
import '../services/api_service.dart';

class ChatController extends GetxController {
  final RxList<ChatModel> _chatList = <ChatModel>[].obs;

  RxList<ChatModel> get getChatList => _chatList;

  int msgCounter = 0;
  RxBool _isTyping = false.obs;
  RxBool get isTyping => _isTyping;
  var messageId = '';
  var createdAt = '';
  bool getsession_id = false;

  void toggleTypingBool() => _isTyping.value = !_isTyping.value;

  void addUserMessage({required String msg}) {
    _chatList.add(ChatModel(msg: msg, chatIndex: 0, isUser: true));
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg, required String chosenModelId}) async {
    print("controller : sendMessageAndGetAnswers");
    print(msg);
    _isTyping.value = true;
    if (chosenModelId.toLowerCase().startsWith("gpt")) {
      print(chosenModelId);

      final chat = await ApiService.sendMessageGPT(
        message: msg,
        modelId: chosenModelId,
      );
      _chatList.addAll(chat);
    } else {
      _chatList.addAll(await ApiService.sendMessage(
        message: msg,
        modelId: chosenModelId,
      ));
    }
    msgCounter += 1;
    _isTyping.value = false;
  }

  List<String> getAnswers() {
    final List<String> answers = _chatList
        .where((chat) => chat.isUser == false)
        .map((chat) => chat.msg)
        .toList();
    return answers;
  }

  String getCurrentAnswer() {
    final List<ChatModel> answers =
        _chatList.where((chat) => chat.isUser == false).toList();
    if (answers.isNotEmpty) {
      return answers.last.msg;
    }
    return '';
  }

  void addMessageAndReply(String message, String reply) {
    _chatList.add(ChatModel(msg: message, chatIndex: 0, isUser: true));
    _chatList.add(ChatModel(msg: reply, chatIndex: 0, isUser: false));
  }

  void replyMessage(String reply) async {
    print('replyMessage');
    final body = {"reply": reply, "messageId": messageId};
    final headers = {
      "Authorization": authorizationValue,
    };
    var response = await NetworkApi.post(
        url: replyMessageUrl, body: body, headers: headers);

    print('reply----$response');
  }

  Future<void> titleChat(String text) async {
    print('firstChat');
    try {
      final body = {"title": text, "sessionId": sessionId};
      final headers = {
        "Authorization": authorizationValue,
      };
      var response = await NetworkApi.post(
          url: sessionChatUrl, body: body, headers: headers);
      print('==========${response['message']}');
      print(response);
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendMessage(String text) async {
    print('sendMessage');
    try {
      final body = {"message": text, "sessionId": sessionId};
      final headers = {
        "Authorization": authorizationValue,
      };
      var response = await NetworkApi.post(
          url: sendMessageUrl, body: body, headers: headers);
      messageId = response['data']['_id'];
      createdAt = response['data']['createdAt'];

      print("----$response");
      print(messageId);
      print(createdAt);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getSessionHistory(String params) async {
    print('Chat Session History');
    try {
      final queryParams = {
        'sessionId': params,
      };
      final headers = {
        "Authorization": authorizationValue,
      };
      var response = await NetworkApi.getResponseWithParams(
          url: chatSessionUrl, headers: headers, queryParams: queryParams);

      print('chat Session History-$response');
      if (response['message'] == 'Success') {
        List<dynamic> data = response['data'];
        for (var item in data) {
          final message = item['message'];
          final reply = item['reply'];
          addMessageAndReply(message, reply);
        }
      }
    } catch (e) {
      print('not ok session History');
      print(e);
    }
  }

  @override
  void dispose() {
    print("ChatController disposed");
    super.dispose();
  }
}
