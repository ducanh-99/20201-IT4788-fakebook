import 'package:facebook/data/repository/chat_repository.dart';
import 'package:facebook/data/source/remotedatasource/chat_remotedatasource.dart';

class ChatBloc {
  ChatRepository _chatRepositoryImpl = ChatRepositoryImpl(ChatRemoteDatasourceImpl());
  getAllConversation() async{
    print("get all conversation");
    await _chatRepositoryImpl.getAllConversation();
  }

  getConversationByUserId(String receiverId) async {
    print("get conversation by id");
    await _chatRepositoryImpl.getConversationByUserId(receiverId);
  }
  removeConversation(String receiverId) async {
    print("remove conversation by id");
    await _chatRepositoryImpl.removeConversation(receiverId);
  }

  removeMessage(String receiverId, int index) async {
    print("remove message");
    await _chatRepositoryImpl.removeMessage(receiverId, index);
  }

  sendMessage(String receiverId, String message) async {
    print("send message");
    await _chatRepositoryImpl.sendMessage(receiverId, message);
  }
}