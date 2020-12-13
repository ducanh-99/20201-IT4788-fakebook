import 'dart:convert';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:http/http.dart' as http;

abstract class ChatRemoteDatasource {
  apiGetAllConversation();
  apiGetConversationByUserId(String receiverId);
  apiRemoveConversation(String receiverId);
  apiSendMessage(String receiverId);
  apiRemoveMessage(String receiverId,int index);
}
class ChatRemoteDatasourceImpl implements ChatRemoteDatasource {
  @override
  apiGetAllConversation() async{
    var response = await http.post(
      "https://fakebook-20201.herokuapp.com/api/get_list_chat",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) async {
      var responseJson = json.decode(value.body);
      if(responseJson.length >0){
        print(responseJson);
        listConversation = {};
        for (var conversation in responseJson) {
          listConversation[conversation['received']['user']] =Conversation(
                  conversationId: conversation['id'],
                  lastMessage: conversation['last_messages'][0]['text'],
                  listMessage: [],
                  receiverId: conversation['received']['user'],
                  receiverName: conversation['received']['username']
              )
          ;
        }
      } else {
        listConversation = {};
      }

    }).catchError((error) async {
      print(error);
      print('Error');
    });
  }

  @override
  apiGetConversationByUserId(String receiverId) async{
    var response = await http.post(
      "https://fakebook-20201.herokuapp.com/api/get_chat/" +receiverId,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) async {
      var responseJson = json.decode(value.body);
      print(responseJson);
      if(responseJson['messages'].length >0){
        for (var message in responseJson['messages']) {
            listConversation[receiverId].listMessage.add(
              Message(
                index: message['index'],
                createAt: message['create'],
                message: message['text'],
                isMe: message['from_user'] == currentUser.id? true :false,
                profileImg: 'https://fakebook-20201.herokuapp.com/api/get_avt/' + receiverId,
              )
            );
        }
      } else {
        print("no message");
      }

    }).catchError((error) async {
      print(error);
      print('Error');
    });
  }

  @override
  apiRemoveConversation(receiverId) {
    // TODO: implement apiRemoveConversation
    throw UnimplementedError();
  }

  @override
  apiRemoveMessage(receiverId, index) {
    // TODO: implement apiRemoveMessage
    throw UnimplementedError();
  }

  @override
  apiSendMessage(receiverId) {
    // TODO: implement apiSendMessage
    throw UnimplementedError();
  }

}