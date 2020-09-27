import 'package:flutter/material.dart';
import 'package:facebook/constants.dart';

class RectangleButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Function onPressed;

  const RectangleButton({
    Key key,
    @required this.icon,
    @required this.iconSize,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
        shape: BoxShape.rectangle,
      ),
      child: IconButton(
        icon: Icon(icon),
        iconSize: iconSize,
        color: kPrimaryColor,
        onPressed: onPressed,
      ),
    );
  }
}
