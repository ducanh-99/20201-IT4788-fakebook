import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';

class RadiusButton extends StatelessWidget {
  final Function press;
  final String text;
  final bool selected;

  const RadiusButton({
    Key key,
    this.press,
    this.text,
    this.selected = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: FlatButton(
        child: Text(
          text,
          style: TextStyle(color: kColorTextNormal),
        ),
        color: selected ? kPrimaryColor : kColorButton,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        onPressed: press,
      ),
    );
  }
}
