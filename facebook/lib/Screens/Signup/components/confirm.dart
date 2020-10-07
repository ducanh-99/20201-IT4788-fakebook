import 'package:facebook/Screens/Login/login_screen.dart';
import 'package:facebook/Screens/Signup/components/background.dart';
import 'package:facebook/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ConfirmSignup extends StatelessWidget {
  final User user;

  ConfirmSignup({Key key, @required this.user}) : super(key: key);

  apiRegister(User userData) async {
    var response = await http.post(
      "https://fakebook-20201.herokuapp.com/api/auth/signup",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'phonenumber': userData.phone,
        'password': userData.password,
        'lastname': userData.lastName,
        'firtname': userData.firstName,
        'birthday': userData.birthday,
      }),
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController firstName = new TextEditingController();
    TextEditingController lastName = new TextEditingController();
    // firstName.text = user.firstName;
    // lastName.text= user.lastName;
    Size size = MediaQuery.of(context).size;
    return Background(
      text: Text(
        "Xác nhận tài khoản",
        style: TextStyle(color: kColorTextNormal, fontSize: 17),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.02),
            // Text(
            //   "Hoàn tất đăng ký",
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            // ),
            SizedBox(height: size.height * 0.05),
            Text(
              "Chúng tôi đã gửi SMS kèm mã xác nhận tới ",
            ),
            Text(
              "Nhập mã gồm 5 chữ số từ SMS của bạn ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Text("FB-",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16))),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kPrimaryColor, width: 5.0))),
                    ),
                  ),
                ),
              ],
            ),
            ButtonTheme(
              minWidth: double.infinity,
              child: MaterialButton(
                onPressed: () async {
                  var response = await http.post(
                    "https://fakebook-20201.herokuapp.com/api/auth/signup",
                    headers: {
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode({
                      'phonenumber': user.phone,
                      'password': user.password,
                      'lastname': user.lastName,
                      'firtname': user.firstName,
                      'birthday': user.birthday,
                    }),
                  );
                  var responseJson = json.decode(response.body);
                  print(responseJson);
                  if (responseJson['code'] == 1000) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  } else {
                    print(responseJson['message']);
                  }
                },
                child: Text('Tiếp'),
                color: kPrimaryColor,
                textColor: backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
