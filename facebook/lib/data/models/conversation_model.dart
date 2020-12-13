import 'message_model.dart';
class Conversation {
  final String conversationId;
  final String receiverId;
  final String receiverName;
  final List<Message> listMessage;
  final String lastMessage;
  Conversation({
    this.conversationId,
    this.receiverId,
    this.listMessage,
    this.receiverName,
    this.lastMessage
  });
}