import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';

class BackButton extends StatelessWidget {
  final Function press;
  final IconData icon;

  const BackButton({
    Key key,
    this.press,
    this.icon = Icons.arrow_back,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        onPressed: press,
      ),
    );
  }
}
