import 'package:facebook/Screens/Signup/components/background.dart';
import 'package:facebook/Screens/Signup/components/privacy.dart';
import 'package:facebook/data/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_formfield/flutter_datetime_formfield.dart';
import 'package:date_time_picker/date_time_picker.dart';

class BirthdaySignup extends StatelessWidget {
  final User user;
  final dateFormat = DateFormat("dddd, MMMM, yyyy");
  final timeFormat = DateFormat("h:mm a");
  DateTime date;
  TimeOfDay time;

  BirthdaySignup({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    user.birthday = DateTime.now().toString();
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
              "Sinh nhật của bạn khi nào? ${user.lastName}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            DateTimePicker(
              initialValue: DateTime.now().toString(),
              icon: Icon(Icons.event),
              dateMask: 'd MMM, yyyy',
              firstDate: DateTime(1990),
              lastDate: DateTime(2100),
              dateLabelText: 'Date',
              onChanged: (val) {
                user.birthday = val;
              },
              validator: (val) {
                print(val);
                return null;
              },
              onSaved: (val) => print(val),
            ),
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
