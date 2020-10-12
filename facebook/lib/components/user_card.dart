import 'package:flutter/material.dart';
import '../data/models/models.dart';
import '../components/home_widget.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ProfileAvatar(imageUrl: user.imageUrl),
          const SizedBox(width: 6.0),
          Flexible(
            child: Text(
              user.username,
              style: const TextStyle(fontSize: 16.0),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
