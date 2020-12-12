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
}