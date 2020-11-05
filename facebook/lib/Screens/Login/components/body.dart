import 'package:facebook/Screens/Home/screens.dart';
import 'package:facebook/bloc/sign_bloc.dart';
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
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your phoneNumber",
              onChanged: (value) {
                userLogin['phonenumber'] = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                userLogin['password'] = value;
              },
            ),
            RoundedButton(
              text: "LOGIN",
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
                }, (code) {
                  context.showToast(code);
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
