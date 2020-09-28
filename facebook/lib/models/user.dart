class User {
  String firstName;
  String lastName;
  DateTime birthday;
  String phone;
  String email;

  User(this.firstName,this.lastName, this.birthday, this.email, this.phone);

  Map<String, dynamic> toJSON() => {
        'firstName': firstName,
        'lastName': lastName,
        'birthday': birthday,
        'email': email,
        'phone': phone
      };
}
