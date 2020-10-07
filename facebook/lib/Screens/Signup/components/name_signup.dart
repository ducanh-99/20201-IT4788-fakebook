import 'package:facebook/Screens/Signup/components/background.dart';
import 'package:facebook/Screens/Signup/components/birthday_signup.dart';
import 'package:facebook/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';

class NameSignup extends StatelessWidget {
  User user = new User();

  NameSignup({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController first = new TextEditingController();
    TextEditingController last = new TextEditingController();
    // if (user.lastName != "") {
    //   last.text = user.lastName;
    // } else {
    //   last.text = "";
    // }
    // if (user.firstName != "") {
    //   first.text = user.firstName;
    // } else {
    //   first.text = "";
    // }
    Size size = MediaQuery.of(context).size;
    return Background(
      text: Text(
        "Tên",
        style: TextStyle(color: kColorTextNormal, fontSize: 17),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.1),
            Text(
              "Bạn tên gì?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: TextFormField(
                      autofocus: true,
                      controller: first,
                      onChanged: (value) {
                        user.firstName = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Họ",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Vui lòng điền đầy đủ thông tin!';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: TextFormField(
                      autofocus: true,
                      controller: last,
                      onChanged: (value) {
                        user.lastName = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Tên",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Vui lòng điền đầy đủ thông tin!';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
            ButtonTheme(
              minWidth: double.infinity,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BirthdaySignup(
                          user: user,
                        ),
                      ));
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
