import 'message_model.dart';
class Conversation {
  final String conversationId;
  final String receiverId;
  final String receiverName;
  List<Message> listMessage;
  final String lastMessage;
  final String createAt;
  Conversation({
    this.conversationId,
    this.receiverId,
    this.listMessage,
    this.receiverName,
    this.lastMessage,
    this.createAt
  });
}