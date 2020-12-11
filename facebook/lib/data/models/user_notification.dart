class UserNotification {
  final String imageUrl;
  final String username;
  final String content;
  final String time;

  UserNotification({
    this.imageUrl,
    this.username,
    this.content,
    this.time
  });
}

List<UserNotification> notifications = [
  new UserNotification(imageUrl: 'assets/images/fb.png', content: 'đã thích bài viết của bạn', time: '3 hours ago', username: 'Xuân Dương Hoa'),
  // new UserNotification(imageUrl: 'assets/images/login_bottom.png', content: 'Dương Hoa', time: '8 hours ago'),
  // new UserNotification(imageUrl: 'assets/images/main_top.png', content: 'Dương Hoa', time: '9 hours ago'),
  // new UserNotification(imageUrl: 'assets/images/main_top.png', content: 'Dương Hoa', time: '22 hours ago'),
  // new UserNotification(imageUrl: 'assets/images/main_top.png', content: 'Dương Hoa', time: '1 day ago'),
  // new UserNotification(imageUrl: 'assets/images/fb.png', content: 'Dương Hoa', time: '4 days ago'),
  // new UserNotification(imageUrl: 'assets/images/login_bottom.png', content: 'Dương Hoa', time: '6 days ago'),
  // new UserNotification(imageUrl: 'assets/images/fb.png', content: 'Dương Hoa', time: '1 week ago'),
  // new UserNotification(imageUrl: 'assets/images/login_bottom.png', content: 'Dương Hoa', time: '3 weeks ago'),
  // new UserNotification(imageUrl: 'assets/images/fb.png', content: 'Dương Hoa', time: '1 month ago')
];