import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';
extension BuildContextX on BuildContext {

  void showToast(String message) => Toast.show(message, this,
      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
}
