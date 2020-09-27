import 'package:flutter/material.dart';
import 'package:facebook/Screens/Login/components/background.dart';
import 'package:facebook/constants.dart';

class ButtonTextColor extends StatelessWidget {
  final Function press;
  final IconData icon;
  final Text text;
  final Color color;
  const ButtonTextColor({
    Key key,
    this.press,
    this.icon,
    this.text,
    this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: Row(
        children: [
          FlatButton(
            child: Icon(Icons.add),
            color: color,

          ),
          Text(
            "Đăng nhập bằng tài khoản khác",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: kPrimaryColorText),
          )
        ],
      ),

    );
  }
}