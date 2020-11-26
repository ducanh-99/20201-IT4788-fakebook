import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ErrorConnect extends StatefulWidget {
  final AppBar appBar;

  const ErrorConnect({Key key, this.appBar}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ErrorConnectState(appBar);
  }
}

class _ErrorConnectState extends State<ErrorConnect> {
  final AppBar appBar;

  _ErrorConnectState(this.appBar);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 150),
            IconButton(
                icon: Icon(MdiIcons.wifiOff),
                iconSize: 70,
                onPressed: () {
                  print("Er connect");
                }),
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Đã xảy ra lỗi. Nhấp để thử lại")
                ],
              ),
              onTap: (){
                print(" Nhấp để thử lại");
              },
            )
          ],
        ),
      ),
    );
  }
}
