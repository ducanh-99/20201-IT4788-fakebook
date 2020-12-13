import 'dart:convert';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:http/http.dart' as http;

abstract class ChatRemoteDatasource {
  apiGetAllConversation();
  apiGetConversationByUserId(String receiverId);
  apiRemoveConversation(String receiverId);
  apiSendMessage(String receiverId, String message);
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
          if(conversation['last_messages'] != null){
            listConversation[conversation['received']['user']] = Conversation(
                conversationId: conversation['id'],
                lastMessage: conversation['last_messages'][0]['text'],
                listMessage: [],
                receiverId: conversation['received']['user'],
                receiverName: conversation['received']['username']
            );
          }else{
            listConversation[conversation['received']['user']] = Conversation(
                conversationId: conversation['id'],
                listMessage: [],
                receiverId: conversation['received']['user'],
                receiverName: conversation['received']['username']
            );
          }
        }
        print(" get conversation");
        print(listConversation);
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
        listConversation[receiverId].listMessage = [];
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
  apiRemoveConversation(String receiverId) async {
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
      if(responseJson['code']==1000){
        print("Xoa cuoc tro chuyen thanh cong");
      } else {
        print("Xoa cuoc tro chuyen that bai ");
      }

    }).catchError((error) async {
      print(error);
      print('Error');
    });
  }

  @override
  apiRemoveMessage(String receiverId, int index) async {
    try{
      final baseUrl = "https://fakebook-20201.herokuapp.com/api/message/";
      final url = Uri.parse(baseUrl + receiverId);
      final request = http.Request("DELETE", url);
      request.headers.addAll(<String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      });
      request.body = jsonEncode({"index": index});
      final response = await request.send();
      final responseJson = json.decode(response.toString());
      if(responseJson['code']==1000){
        print('Xoa message thanh cong');
        listConversation[receiverId].listMessage.removeWhere((item) => item.index == index);
      }else{
        print('Xoa message that bai');
      }
    } catch(err){
      print('ERROR $err');
    }
  }

  @override
  apiSendMessage(String receiverId, String message) async {
    var response = await http.post(
      "https://fakebook-20201.herokuapp.com/api/message/" +receiverId,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'text':message}),
    ).then((value) async {
      var responseJson = json.decode(value.body);
      print(responseJson);
      listConversation[receiverId].listMessage.add(
          Message(
            index: responseJson['index'],
            createAt: responseJson['create'],
            message: responseJson['text'],
            isMe: true,
            profileImg: 'https://fakebook-20201.herokuapp.com/api/get_avt/' + receiverId,
          )
      );

    }).catchError((error) async {
      print(error);
      print('Error');
    });
  }


}