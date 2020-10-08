import 'package:facebook/Screens/Signup/components/background.dart';
import 'package:facebook/data/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/components/rounded_password_field.dart';
import 'confirm.dart';

class PhoneSignup extends StatelessWidget {
  final User user;

  PhoneSignup({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumber = new TextEditingController();
    TextEditingController email = new TextEditingController();
    // firstName.text = user.firstName;
    // lastName.text= user.lastName;
    Size size = MediaQuery.of(context).size;
    return Background(
      text: Text(
        "Số điện thoại và email",
        style: TextStyle(color: kColorTextNormal, fontSize: 17),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.02),
            Text(
              "Hoàn tất đăng ký",
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
                      controller: phoneNumber,
                      onChanged: (value) {
                        user.phone = value;
                      },
                      decoration: InputDecoration(
                        labelText: "SDT",
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
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: TextFormField(
                      autofocus: true,
                      controller: email,
                      onChanged: (value) {
                        user.email = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
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
            RoundedPasswordField(
              onChanged: (value) {
                user.password = value;
              },
            ),
            SizedBox(height: size.height * 0.05),
            ButtonTheme(
              minWidth: double.infinity,
              child: MaterialButton(
                onPressed: () {
                  print(user.firstName);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ConfirmSignup(user: user);
                  }));
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
