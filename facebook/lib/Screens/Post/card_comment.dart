// import 'package:facebook/constants.dart';
// import 'package:flutter/material.dart';
// // import 'package:json/main/constants.dart';
//
// class CardComment extends StatelessWidget {
//   final String comment_username;
//   final String comment_profile_pic;
//   final String comment_text;
//
//   CardComment(
//       {@required this.comment_username,
//       @required this.comment_profile_pic,
//       @required this.comment_text});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       // padding: const EdgeInsets.all(8.0),
//       padding:EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
//       child: Container(
//         // width: 500,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Container(
//                 height: 40,
//                 width: 40,
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                         image: AssetImage(comment_profile_pic),
//                         fit: BoxFit.cover)),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 10.0),
//               child: Container(
//                 // width: double.infinity,
//                 // width: MediaQuery.of(context).size.width,
//                 // height: double.infinity,
//                 // height: MediaQuery.of(context).size.height*0.5,
//                 decoration: BoxDecoration(
//                     color: kBackgroundGrey,
//                     borderRadius: BorderRadius.all(Radius.circular(20))),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.all(2.0),
//                         child: Text(
//                           comment_username,
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(2.0),
//                         child: Text(
//                           comment_text,
//                           style: TextStyle(
//                               fontSize: 13,
//                               // fontWeight: FontWeight.bold,
//                               color: Colors.grey[700]),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
