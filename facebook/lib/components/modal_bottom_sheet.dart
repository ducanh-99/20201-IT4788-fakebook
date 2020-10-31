import 'package:facebook/constants.dart';
import 'package:flutter/material.dart';

void showModal(BuildContext context, List<Widget> widget) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
            height: double.infinity,
            child: Expanded(
                child: Column(
              children: widget,
            )),
            decoration: BoxDecoration(color: Theme.of(context).canvasColor));
      });
}

void showModalFullSheet(BuildContext context, List<Widget> widget) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SafeArea(
          // top: true,

          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Báo cáo',
                textAlign: TextAlign.center,
                style: TextStyle(color: kColorTextNormal),
              ),
              backgroundColor: backgroundColor,
            ),
          ),
          minimum: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
          // child: Container(
          // height: double.infinity,
          // child: Expanded(
          //     child: Column(
          //       children: widget,
          //     )),
          // decoration: BoxDecoration(color: Theme.of(context).canvasColor))
        );
        // return Scaffold(
        //   appBar: AppBar(
        //     title: Text('Báo cáo', textAlign: TextAlign.center, style: TextStyle(color: kColorTextNormal),),
        //     backgroundColor: backgroundColor,
        //   ),
        // );
      });
}

void showCommentSheet(BuildContext context, List<Widget> widget) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SafeArea(
          // top: true,

          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Bình luận',
                textAlign: TextAlign.center,
                style: TextStyle(color: kColorTextNormal),
              ),
              backgroundColor: backgroundColor,
            ),
          ),
          minimum: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
          // child: Container(
          // height: double.infinity,
          // child: Expanded(
          //     child: Column(
          //       children: widget,
          //     )),
          // decoration: BoxDecoration(color: Theme.of(context).canvasColor))
        );
        // return Scaffold(
        //   appBar: AppBar(
        //     title: Text('Báo cáo', textAlign: TextAlign.center, style: TextStyle(color: kColorTextNormal),),
        //     backgroundColor: backgroundColor,
        //   ),
        // );
      });
}


// void showAlert(){
//   Alert
// }
// Future<bool> onBackPressed(BuildContext context) {
//   return showDialog(
//     context: context,
//     builder: (context) => new AlertDialog(
//       title: new Text('Are you sure?'),
//       content: new Text('Do you want to exit an App'),
//       actions: <Widget>[
//         new GestureDetector(
//           onTap: () => Navigator.of(context).pop(false),
//           child: Text("NO"),
//         ),
//         SizedBox(height: 16),
//         new GestureDetector(
//           onTap: () => Navigator.of(context).pop(true),
//           child: Text("YES"),
//         ),
//       ],
//     ),
//   ) ??
//       false;
// }
