import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/constants.dart';
import 'package:flutter/material.dart';
import 'package:facebook/data/models/user_notification.dart';

class NotificationWidget extends StatelessWidget {
  final UserNotification notification;

  NotificationWidget({this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 22.0,
                      backgroundImage: CachedNetworkImageProvider(notification.imageUrl),
                    ),
                    Positioned(
                      top: 32,
                      left: 32,
                      child:
                      // Container(
                      //   width: 20,
                      //   height: 20,
                      //   decoration: BoxDecoration(
                      //       color: kBlack,
                      //       shape: BoxShape.circle,
                      //       border:
                      //       Border.all(color: kBlack, width: 3)),
                      // ),
                      // Container(
                      //   width: 20,
                      //   height: 20,
                      //   padding: const EdgeInsets.all(4.0),
                      //   decoration: BoxDecoration(
                      //     color: kPrimaryColor,
                      //     shape: BoxShape.circle,
                      //   ),
                      //   child: const Icon(
                      //     Icons.thumb_up,
                      //     size: 10.0,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      // Container(
                      //   width: 25,
                      //   height: 25,
                      //   padding: const EdgeInsets.all(2.0),
                      //   decoration: BoxDecoration(
                      //     color: kPrimaryColor,
                      //     shape: BoxShape.circle,
                      //   ),
                      //   child: const Icon(
                      //     Icons.person,
                      //     size: 20.0,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      Container(
                        width: 25,
                        height: 25,
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person_add,
                          size: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      // Container(
                      //   width: 25,
                      //   height: 25,
                      //   padding: const EdgeInsets.all(2.0),
                      //   decoration: BoxDecoration(
                      //     color: kGreenComment,
                      //     shape: BoxShape.circle,
                      //   ),
                      //   child: const Icon(
                      //     Icons.comment,
                      //     size: 17.0,
                      //     color: Colors.white,
                      //   ),
                      // ),
                    ),
                  ],
                ),
                SizedBox(width: 15.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      child: Column(
                        children: [
                          Text(notification.username,
                              style: TextStyle(
                                  fontSize: 17.0, fontWeight: FontWeight.bold)),
                          Text(notification.content,
                              style: TextStyle(fontSize: 16.0)),
                        ],
                      ),
                    ),
                    // Text(notification.content,
                    //     style: TextStyle(
                    //         fontSize: 17.0, fontWeight: FontWeight.bold)),
                    Text(notification.time,
                        style: TextStyle(fontSize: 15.0, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(Icons.more_horiz),
                Text(''),
              ],
            )
          ],
        ),
        onTap: (){
          print("da an thong bao");
        },
      ),
    );
  }
}
