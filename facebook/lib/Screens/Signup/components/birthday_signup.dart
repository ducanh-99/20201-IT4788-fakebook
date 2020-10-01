import 'package:facebook/Screens/Signup/components/background.dart';
import 'package:facebook/Screens/Signup/components/privacy.dart';
import 'package:facebook/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';

class BirthdaySignup extends StatelessWidget {
  final User user;

  BirthdaySignup({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController firstName = new TextEditingController();
    TextEditingController lastName = new TextEditingController();
    // firstName.text = user.firstName;
    // lastName.text= user.lastName;
    Size size = MediaQuery.of(context).size;
    // showDatePicker(
    //     context: context,
    //     initialDate: DateTime.now(),
    //     firstDate: DateTime(1900),
    //     lastDate: DateTime(2025));
    return Background(
      text: Text(
        "Ngày sinh",
        style: TextStyle(color: kColorTextNormal, fontSize: 17),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.02),
            Text(
              "Sinh nhật của bạn khi nào?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
        // Row(
        //   children: [
        //     Expanded(
        //       flex: 1,
        //       child: Padding(
        //         padding: EdgeInsets.only(left: 5.0, right: 5.0),
        //         child: CupertinoDatePicker(
        //           initialDateTime: DateTime.now(),
        //           mode: CupertinoDatePickerMode.date,
        //           onDateTimeChanged: (){
        //
        //           },
        //
        //         )
        //       ),
        //     ),
        //     ]),

            // Form(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       TextFormField(
            //         validator: (value) {
            //           if (value.isEmpty) {
            //             return 'Please enter some text';
            //           }
            //           return null;
            //         },
            //       ),
            //       // TextFormField(
            //       //   controller: firstName,
            //       //   autofocus: true,
            //       //   // decoration: const InputDecoration(
            //       //   //   hintText: "Họ",
            //       //   //   labelText: "Họ",
            //       //   // ),
            //       //   validator: (String value) {
            //       //     return (value.length == 0)
            //       //         ? "Không được bỏ trống trường này"
            //       //         : null;
            //       //   },
            //       // ),
            //       // TextFormField(
            //       //   controller: lastName,
            //       //   // decoration: const InputDecoration(
            //       //   //   hintText: "Tên",
            //       //   //   labelText: "Tên",
            //       //   // ),
            //       //   validator: (String value) {
            //       //     return (value.length == 0)
            //       //         ? "Không được bỏ trống trường này"
            //       //         : null;
            //       //   },
            //       // ),
            //     ],
            //   ),
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Form(
            //
            //     ),
            //     TextField(
            //       controller: firstName,
            //       autofocus: true,
            //       decoration: new InputDecoration(
            //         hintText: "Họ",
            //         labelText: "Họ",
            //       ),
            //       // validator: (String value) {
            //       //   return (value.length == 0)
            //       //       ? "Không được bỏ trống trường này"
            //       //       : null;
            //       // },
            //     ),
            //     TextField(
            //       controller: lastName,
            //       decoration: new InputDecoration(
            //         hintText: "Tên",
            //         labelText: "Tên",
            //       ),
            //       // validator: (String value) {
            //       //   return (value.length == 0)
            //       //       ? "Không được bỏ trống trường này"
            //       //       : null;
            //       // },
            //     ),
            //
            //   ],
            // ),
            // RaisedButton(
            //   child: Text("Tiếp"),
            //   color: kPrimaryColor,
            //   textColor: backgroundColor,
            //   onPressed: () {
            //     user.firstName = firstName.text;
            //     user.lastName = lastName.text;
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) => User(user: user)),
            //     // );
            //   },
            // ),
            SizedBox(height: size.height * 0.05),
            ButtonTheme(
              minWidth: double.infinity,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PrivacySignup(user: user);
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
