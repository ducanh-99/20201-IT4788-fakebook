class UserNotification {
  final String imageUrl;
  final String content;
  final String time;

  UserNotification({
    this.imageUrl,
    this.content,
    this.time
  });
}

List<UserNotification> notifications = [
  new UserNotification(imageUrl: 'assets/images/goalcast.png', content: 'Goalcast posted a new video', time: '3 hours ago'),
  new UserNotification(imageUrl: 'assets/images/playstation.jpg', content: 'Playstation posted a new video', time: '8 hours ago'),
  new UserNotification(imageUrl: 'assets/images/xbox.jpeg', content: 'Xbox posted a new video', time: '9 hours ago'),
  new UserNotification(imageUrl: 'assets/images/reddit.png', content: 'Reddit posted a new video', time: '22 hours ago'),
  new UserNotification(imageUrl: 'assets/images/linkedIn.jpg', content: 'Linkedin posted a new video', time: '1 day ago'),
  new UserNotification(imageUrl: 'assets/images/goalcast.png', content: 'Goalcast posted a new video', time: '4 days ago'),
  new UserNotification(imageUrl: 'assets/images/reddit.png', content: 'Reddit posted a new video', time: '6 days ago'),
  new UserNotification(imageUrl: 'assets/images/xbox.jpeg', content: 'Xbox posted a new video', time: '1 week ago'),
  new UserNotification(imageUrl: 'assets/images/linkedIn.jpg', content: 'Linkedin posted a new video', time: '3 weeks ago'),
  new UserNotification(imageUrl: 'assets/images/playstation.jpg', content: 'Playstation posted a new video', time: '1 month ago')
];