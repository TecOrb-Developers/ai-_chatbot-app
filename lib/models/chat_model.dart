class ChatModel {
  final String msg;
  final int chatIndex;
  final bool? isUser;

  ChatModel({
    required this.msg,
    required this.chatIndex,
    this.isUser = false,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        msg: json["msg"],
        chatIndex: json["chatIndex"],
      );
}
