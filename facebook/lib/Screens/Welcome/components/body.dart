import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:facebook/Screens/Login/login_screen.dart';
import 'package:facebook/Screens/Signup/signup_screen.dart';
import 'package:facebook/Screens/Welcome/components/background.dart';
import 'package:facebook/components/rectangle_button.dart';
import 'package:facebook/components/rounded_button.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/components/components.dart';
import '../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   "WELCOME TO EDU",
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: size.height * 0.05),
            // SvgPicture.asset(
            //   "assets/icons/chat.svg",
            //   height: size.height * 0.45,
            // ),
            Image.asset(
              "assets/images/fb.png",
              height: size.height * 0.2,
              width: size.width * 0.2,
            ),
            SizedBox(height: size.height * 0.05),
            Row(
              children: [
                RectangleButton(
                  icon: Icons.add,
                  iconSize: 25.0,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  },
                ),
                FlatButton(
                  child: new Text(
                    "Đăng nhập bằng tài khoản khác",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: kPrimaryColorText),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  },
                ),
              ],
            ),
            Row(
              children: [
                RectangleButton(
                  icon: Icons.search,
                  iconSize: 25.0,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  },
                ),
                FlatButton(
                  child: new Text(
                    "Tìm tài khoản",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: kPrimaryColorText),
                  ),
                ),
              ],
            ),
            // RoundedButton(
            //   text: "Đăng nhập",
            //   color: kPrimaryLightColor,
            //   textColor: kPrimaryColorText,
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return LoginScreen();
            //         },
            //       ),
            //     );
            //   },
            // ),
            // RoundedButton(
            //   text: "Đăng kí",
            //   color: kPrimaryLightColor,
            //   textColor: kPrimaryColorText,
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return SignUpScreen();
            //         },
            //       ),
            //     );
            //   },
            // ),
            Container(
              alignment: Alignment.bottomCenter,
              height: size.height * 0.08,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.lightBlue[50],
                shape: BoxShape.rectangle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: new Align(
                      alignment: FractionalOffset.bottomCenter,
                      child:
                      FlatButton(
                        child: new Text(
                          "TẠO TÀI KHOẢN FACEBOOK MỚI",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColorText),
                        ),
                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return SignUpScreen();
                              }));
                        },
                      ),
                    )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
