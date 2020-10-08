class User {
  String firstName;
  String lastName;
  String birthday;
  String phone;
  String email;
  String password;

  Map<String, dynamic> toJSON() => {
        'firstName': firstName,
        'lastName': lastName,
        'birthday': birthday,
        'email': email,
        'phone': phone,
        'password': password
      };
}
