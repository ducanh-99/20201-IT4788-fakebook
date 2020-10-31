import 'package:facebook/Screens/Post/post_screen.dart';
import 'package:facebook/Screens/Post/post_screen_ful.dart';
import 'package:flutter/material.dart';
import 'package:facebook/data/models/models.dart';
import 'package:facebook/components/home_widget.dart';

class CreatePostContainer extends StatelessWidget {
  final User currentUser;

  const CreatePostContainer({Key key, @required this.currentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Post post = new Post();
    final bool isDesktop = Responsive.isDesktop(context);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: isDesktop ? 5.0 : 0.0),
      elevation: isDesktop ? 1.0 : 0.0,
      shape: isDesktop
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
          : null,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                ProfileAvatar(avatar: currentUser.avatar),
                const SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PostScreenFul(post: post);
                      }));
                    },
                    decoration: InputDecoration.collapsed(
                      hintText: 'Bạn đang nghĩ gì?',
                    ),
                  ),
                )
              ],
            ),
            const Divider(height: 10.0, thickness: 0.5),
            Container(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton.icon(
                    onPressed: () => print(currentUser.username),
                    icon: const Icon(
                      Icons.videocam,
                      color: Colors.red,
                    ),
                    label: Text('Video'),
                  ),
                  const VerticalDivider(width: 8.0),
                  FlatButton.icon(
                    onPressed: () => print('Photo'),
                    icon: const Icon(
                      Icons.photo_library,
                      color: Colors.green,
                    ),
                    label: Text('Ảnh'),
                  ),
                  const VerticalDivider(width: 8.0),
                  FlatButton.icon(
                    onPressed: () => print('Room'),
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.purpleAccent,
                    ),
                    label: Text('Checkin'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
