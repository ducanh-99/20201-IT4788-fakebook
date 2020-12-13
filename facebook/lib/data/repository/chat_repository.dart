import 'package:facebook/data/source/remotedatasource/chat_remotedatasource.dart';

abstract class ChatRepository {
  getAllConversation();
  getConversationByUserId(String receiverId);
  removeConversation(String receiverId);
  sendMessage(String receiverId,String message);
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
  removeConversation(String receiverId) async {
    await _chatRemoteDatasource.apiRemoveConversation(receiverId);
  }

  @override
  removeMessage(String receiverId, int index) async {
    await _chatRemoteDatasource.apiRemoveMessage(receiverId, index);
  }

  @override
  sendMessage(String receiverId, String message) async {
    await _chatRemoteDatasource.apiSendMessage(receiverId, message);
  }



}