import 'package:facebook/Screens/Signup/components/background.dart';
import 'package:facebook/bloc/sign_bloc.dart';
import 'package:facebook/data/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/components/rounded_password_field.dart';
import 'confirm.dart';

class PhoneSignup extends StatelessWidget {
  final User user;
  SignUpBloc _registerBloc = SignUpBloc();
  PhoneSignup({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumber = new TextEditingController();
    print('b');
    print(user.birthday);

    Size size = MediaQuery.of(context).size;
    return Background(
      text: Text(
        "Số điện thoại",
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
                      autofocus: false,
                      controller: phoneNumber,
                      onChanged: (value) {
                        user.phone = value;
                        print('a');
                        print(user.birthday);
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
                  print(user.birthday);
                  // _registerBloc.signUp(user, (){
                  //   Navigator.push(
                  //       context, MaterialPageRoute(builder: (context) => ConfirmSignup(user: user)));
                  // }, (code){
                  //
                  // });
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
