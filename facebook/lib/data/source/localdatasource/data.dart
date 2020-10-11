import 'package:facebook/data/models/models.dart';

final User currentUser = User(
  phone:
  "1234567890",
  password:
  "\$2b\$12\$0bVuLAzfM5jT9qhyaqHjx.Qj0LzGj6WNf2OT/CJ1keuqqdz8SW4mm",
  firstName
      :
  "tung	",
  lastName
      :
  "mun",
  username
  :
  "tung	 mun",
  birthday
      :
  "2020-10-07 22:44:47.714868",
  avatar
      :
  'https://images.unsplash.com/photo-1578133671540-edad0b3d689e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1351&q=80',
  // name: 'Marcus Ng',
  // imageUrl: https://images.unsplash.com/photo-1525253086316-d0c936c814f8
  // 'https://images.unsplash.com/photo-1578133671540-edad0b3d689e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1351&q=80',
);

final List<Post> posts = [
  Post(
    user: currentUser,
    caption: 'Check out these cool puppers :) hi',
    timeAgo: '58m',
    imageUrl: '',
    likes: 1202,
    comments: 184,
  ),
  Post(
    user: currentUser,
    caption:
    'Please enjoy this placeholder text: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    timeAgo: '3hr',
    imageUrl: null,
    likes: 683,
    comments: 79,
  ),
  Post(
    user: currentUser,
    caption: 'This is a very good boi.',
    timeAgo: '8hr',
    imageUrl:
    'https://images.unsplash.com/photo-1575535468632-345892291673?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    likes: 894,
    comments: 201,
  ),
  Post(
    user: currentUser,
    caption: 'Adventure 🏔',
    timeAgo: '15hr',
    imageUrl:
    'https://images.unsplash.com/photo-1573331519317-30b24326bb9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    likes: 722,
    comments: 183,
  ),
  Post(
    user: currentUser,
    caption:
    'More placeholder text for the soul: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    timeAgo: '1d',
    imageUrl: null,
    likes: 482,
    comments: 37,
  ),
  Post(
    user: currentUser,
    caption: 'A classic.',
    timeAgo: '1d',
    imageUrl:
    'https://images.unsplash.com/reserve/OlxPGKgRUaX0E1hg3b3X_Dumbo.JPG?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    likes: 1523,
    comments: 301,
  )
];
