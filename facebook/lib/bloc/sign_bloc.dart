import 'dart:async';

import 'package:facebook/data/models/user.dart';
import 'package:facebook/data/repository/user_repository.dart';
import 'package:facebook/data/source/localdatasource/user_local_datasource.dart';
import 'package:facebook/data/source/remotedatasource/user_remotedatasource.dart';
import 'package:facebook/utils/string_ext.dart';


class SignUpBloc{

  UserRepository _userRepositoryImpl = UserRepositoryImpl(
    UserLocalDatasourceImpl(),
    UserRemoteDatasourceImpl()
  );

  StreamController _firstNameController = new StreamController.broadcast();
  StreamController _lastNameController = new StreamController.broadcast();
  StreamController _birthdayController = new StreamController.broadcast();
  StreamController _emailController = new StreamController.broadcast();
  StreamController _phoneController = new StreamController.broadcast();
  StreamController _passController = new StreamController.broadcast();

  Stream get firstNameStream => _firstNameController.stream;

  Stream get lastNameStream => _lastNameController.stream;

  Stream get birthdayStream => _birthdayController.stream;

  Stream get emailStream => _emailController.stream;

  Stream get phoneStream => _phoneController.stream;

  Stream get passStream => _passController.stream;

  bool isValidInfo(String firstName, String lastName, String birthday,
      String email, String phone, String password) {
    bool result = true;
    if (firstName.isEmpty) {
      _firstNameController.sink.addError("Vui lòng nhập Họ");
      result = result && false;
    } else {
      _firstNameController.sink.add("OK");
      result = result && true;
    }
    if (lastName.isEmpty) {
      _lastNameController.sink.addError("Vui lòng nhập Tên");
      result = result && false;
    } else {
      _lastNameController.sink.add("OK");
      result = result && true;
    }
    if (birthday.isEmpty) {
      _birthdayController.sink.addError("Vui lòng nhập ngày sinh");
      result = result && false;
    } else {
      _birthdayController.sink.add("OK");
      result = result && true;
    }
    if (email.isEmpty) {
      _emailController.sink.addError("Vui lòng nhập email");
      result = result && false;
    } else if (!email.isValidEmail()) {
      _emailController.sink.addError("Email không hợp lệ");
      result = result && false;
    } else {
      _emailController.sink.add("OK");
      result = result && true;
    }
    if (phone.isEmpty) {
      _phoneController.sink.addError("Vui lòng nhập số điện thoại");
      result = result && false;
    } else {
      _phoneController.sink.add("OK");
      result = result && true;
    }
    if (!password.isValidPassword()) {
      _passController.sink.addError("Mật khẩu phải trên 8 ký tự");
      result = result && false;
    } else {
      _passController.sink.add("OK");
      result = result && true;
    }

    return result;
  }

  void signUp(User user, Function onSuccess, Function(String) onError) {
    _userRepositoryImpl.signUp(user, onSuccess, (code) {
      _onSignUpErr(code);
      onError(code);
    });
  }

  void _onSignUpErr(String code) {
    // switch (code) {
    //   case "ERROR_INVALID_EMAIL":
    //     _emailController.sink.addError("Email không hợp lệ");
    //     break;
    //   case "ERROR_WEAK_PASSWORD":
    //     _passController.sink.addError("Mật khẩu quá ngắn");
    //     break;
    //   case "ERROR_EMAIL_ALREADY_IN_USE":
    //     _emailController.sink.addError("Email đã tồn tại");
    //     break;
    //   case "ERROR_INVALID_CREDENTIAL":
    //     _emailController.sink.addError("Email không hợp lệ");
    //     break;
    //   default:
    // }
  }

  void dispose() {
    _firstNameController.close();
    _lastNameController.close();
    _phoneController.close();
    _emailController.close();
    _birthdayController.close();
    _passController.close();
  }
}