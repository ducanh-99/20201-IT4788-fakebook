import 'package:facebook/data/source/remotedatasource/chat_remotedatasource.dart';

abstract class ChatRepository {
  getAllConversation();
  getConversationByUserId(String receiverId);
  removeConversation(String receiverId);
  sendMessage(String receiverId);
  removeMessage(String receiverId,int index);
}
class ChatRepositoryImpl implements ChatRepository {
  ChatRemoteDatasource _chatRemoteDatasource;
  ChatRepositoryImpl(this._chatRemoteDatasource);
  @override
  getAllConversation() async{
    await _chatRemoteDatasource.apiGetAllConversation();
  }

  @override
  getConversationByUserId(String receiverId) async {
    await _chatRemoteDatasource.apiGetConversationByUserId(receiverId);
  }

  @override
  removeConversation(receiverId) {
    // TODO: implement removeConversation
    throw UnimplementedError();
  }

  @override
  removeMessage(receiverId, index) {
    // TODO: implement removeMessage
    throw UnimplementedError();
  }

  @override
  sendMessage(receiverId) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }

}