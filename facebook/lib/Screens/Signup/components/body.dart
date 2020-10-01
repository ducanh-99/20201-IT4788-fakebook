import 'package:facebook/Screens/Signup/components/name_signup.dart';
import 'package:flutter/material.dart';
import 'package:facebook/Screens/Login/login_screen.dart';
import 'package:facebook/Screens/Signup/components/background.dart';
import 'package:facebook/Screens/Signup/components/or_divider.dart';
import 'package:facebook/Screens/Signup/components/social_icon.dart';
import 'package:facebook/components/already_have_an_account_acheck.dart';
import 'package:facebook/components/app_bar.dart';
import 'package:facebook/components/rounded_button.dart';
import 'package:facebook/components/rounded_input_field.dart';
import 'package:facebook/components/rounded_password_field.dart';
import 'package:facebook/constants.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      // title: Text(
      //   "Tạo tài khoản",
      //   style: TextStyle(color: kColorTextNormal, fontSize: 17),
      // ),
      text: Text(
        "Tạo tài khoản",
        style: TextStyle(color: kColorTextNormal, fontSize: 17),
      ),
      // appBar: AppBar(
      //     title: Text(
      //       "Tạo tài khoản",
      //       style: TextStyle(color: kColorTextNormal, fontSize: 17),
      //     ),
      //     backgroundColor: backgroundColor,
      //     iconTheme: IconThemeData(color: kColorTextNormal)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            // RoundedInputField(
            //   hintText: "Your Email",
            //   onChanged: (value) {},
            // ),
            // RoundedPasswordField(
            //   onChanged: (value) {},
            // ),
            Text(
              "Tham gia Facebook",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              "Chúng tôi sẽ giúp bạn tạo tài khoản mới sau vài bước dễ dàng",
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            // SizedBox(
            //   width: double.infinity,
            //   child: FlatButton(
            //     color: kPrimaryColor,
            //     child: Text(
            //       "Tiếp",
            //       style: TextStyle(color: textColor),
            //     ),
            //   ),
            // ),
            // FlatButton(
            //   child: Text(
            //     "Tiếp",
            //   ),
            //   color: kPrimaryColor,
            //   textColor: backgroundColor,
            //   onPressed: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context) {
            //       return NameSignup();
            //     }));
            //   },
            // ),
            SizedBox(height: size.height * 0.05),
            ButtonTheme(
              minWidth: double.infinity,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NameSignup();
                  }));
                },
                child: Text('Tiếp'),
                color: kPrimaryColor,
                textColor: backgroundColor,
              ),
            ),
            SizedBox(height: size.height * 0.2),
            Align(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                child: new Text(
                  "Bạn đã có tài khoản?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: kPrimaryColorText),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                },
              ),
            ),

            // AlreadyHaveAnAccountCheck(
            //   login: false,
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
            // OrDivider(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     SocalIcon(
            //       iconSrc: "assets/icons/facebook.svg",
            //       press: () {},
            //     ),
            //     SocalIcon(
            //       iconSrc: "assets/icons/twitter.svg",
            //       press: () {},
            //     ),
            //     SocalIcon(
            //       iconSrc: "assets/icons/google-plus.svg",
            //       press: () {},
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
