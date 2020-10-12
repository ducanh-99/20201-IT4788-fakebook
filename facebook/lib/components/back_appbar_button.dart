import 'package:flutter/material.dart';
import '../constants.dart';

class BackAppbarButton extends StatelessWidget {
  final Widget child;
  final Text text;
  final Widget button;

  const BackAppbarButton(
      {Key key, @required this.child, this.text, this.button})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // appBar: AppBar(
        //   title: title,
        //   backgroundColor: backgroundColor,
        // ),
        appBar: AppBar(
          title: text,
          backgroundColor: backgroundColor,
          iconTheme: IconThemeData(color: kColorTextNormal),
          actions: [button],
        ),
        body: child);
    // return Container(
    //   height: size.height,
    //   width: double.infinity,
    //   // Here i can use size.width but use double.infinity because both work as a same
    //   child: Stack(
    //     alignment: Alignment.center,
    //     children: <Widget>[
    //       // Positioned(
    //       //   bottom: 0,
    //       //   left: 0,
    //       //   child: FlatButton(
    //       //     child: new Text(
    //       //       "Bạn đã có tài khoản?",
    //       //       style: TextStyle(
    //       //           fontWeight: FontWeight.bold, color: kPrimaryColorText),
    //       //     ),
    //       //   ),
    //       // ),
    //       child,
    //     ],
    //   ),
    // );
  }
}
