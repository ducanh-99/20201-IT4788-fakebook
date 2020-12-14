import 'package:facebook/Screens/Home/screens.dart';
import 'package:facebook/bloc/sign_bloc.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/data/source/localdatasource/user_local_datasource.dart';
import 'package:flutter/material.dart';
import 'package:facebook/Screens/Login/components/background.dart';
import 'package:facebook/Screens/Signup/signup_screen.dart';
import 'package:facebook/components/already_have_an_account_acheck.dart';
import 'package:facebook/components/rounded_button.dart';
import 'package:facebook/components/rounded_input_field.dart';
import 'package:facebook/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:facebook/data/source/remotedatasource/user_remotedatasource.dart';
import 'package:facebook/bloc/sign_bloc.dart';
import 'package:facebook/utils/context_ext.dart';
import 'package:facebook/data/source/localdatasource/local_data.dart';
import 'package:toast/toast.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignInBloc _signinBloc = SignInBloc();
    Size size = MediaQuery.of(context).size;
    var userLogin = {
      'phonenumber': '',
      'password': '',
    };
    void showToast(String msg, {int duration, int gravity}) {
      Toast.show(msg, context, duration: duration, gravity: gravity);
    }

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sai thông tin đăng nhập'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Tên người dùng hoặc mật khẩu không hợp lệ'),
                ],
              ),
            ),
            actions: <Widget>[
              InkWell(
                child: Text('OK',
                    style: TextStyle(color: kPrimaryColor, fontSize: 15)),
                onTap: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Đăng nhập",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Số điện thoại",
              onChanged: (value) {
                userLogin['phonenumber'] = value;
              },
            ),
            // RoundedPasswordField(
            //   onChanged: (value) {
            //     userLogin['password'] = value;
            //   },
            // ),
            Password(
              onChanged: (value) {
                userLogin['password'] = value;
              },
            ),
            // InkWell(
            //   child: Container(
            //     margin: EdgeInsets.symmetric(vertical: 10),
            //     width: size.width * 0.8,
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(5),
            //       child: FlatButton(
            //         padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            //         color: kPrimaryColor,
            //         onPressed: () async {
            //           _signinBloc.signIn(
            //               userLogin['phonenumber'], userLogin['password'], () {
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                 builder: (context) {
            //                   return NavScreen();
            //                 },
            //               ),
            //             );
            //           }, (code) {
            //             context.showToast(code);
            //           });
            //           // var response = await http.post(
            //           //   'https://fakebook-20201.herokuapp.com/api/auth/login',
            //           //   headers: {
            //           //     'Content-Type': 'application/json; charset=UTF-8',
            //           //   },
            //           //   body: jsonEncode({
            //           //     'phonenumber': userLogin['phonenumber'],
            //           //     'password': userLogin['password'],
            //           //   }),
            //           // );
            //           // var responseJson = json.decode(response.body);
            //           // print(responseJson['data']['id']);
            //           // if (responseJson['code'] == 1000) {
            //           //   print(responseJson['message']);
            //           // Navigator.push(
            //           //   context,
            //           //   MaterialPageRoute(
            //           //     builder: (context) {
            //           //       return NavScreen();
            //           //     },
            //           //   ),
            //           // );
            //           // }
            //         },
            //         child: Text(
            //           'Đăng nhập',
            //           style: TextStyle(color: textColor),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            RoundedButton(
              text: "Đăng nhập",
              press: () async {
                _signinBloc.signIn(
                    userLogin['phonenumber'], userLogin['password'], () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return NavScreen();
                      },
                    ),
                  );
                }, (res) {
                  // if (res.contains("9995")) {
                  //   showToast("Đăng nhập không thành công",
                  //       gravity: Toast.BOTTOM);
                  // } else {}
                  _showMyDialog();
                  // print("code");
                  // print(res);
                  // context.showToast(code);
                });
                // var response = await http.post(
                //   'https://fakebook-20201.herokuapp.com/api/auth/login',
                //   headers: {
                //     'Content-Type': 'application/json; charset=UTF-8',
                //   },
                //   body: jsonEncode({
                //     'phonenumber': userLogin['phonenumber'],
                //     'password': userLogin['password'],
                //   }),
                // );
                // var responseJson = json.decode(response.body);
                // print(responseJson['data']['id']);
                // if (responseJson['code'] == 1000) {
                //   print(responseJson['message']);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return NavScreen();
                //     },
                //   ),
                // );
                // }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
