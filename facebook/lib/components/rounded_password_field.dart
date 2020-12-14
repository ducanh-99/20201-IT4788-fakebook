import 'package:flutter/material.dart';
import 'package:facebook/components/text_field_container.dart';
import 'package:facebook/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);
  // bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Mật khẩu",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
class Password extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const Password({Key key, this.onChanged}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Password(onChanged);
  }

}
class _Password extends State<Password>{
  bool _showPassword = false;
  final ValueChanged<String> onChanged;

  _Password(this.onChanged);
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: !_showPassword,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Mật khẩu",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              this._showPassword ? Icons.remove_red_eye : MdiIcons.eyeOffOutline,
              color: this._showPassword ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              setState(() => this._showPassword = !this._showPassword);
            },
          ),
          border: InputBorder.none,
          // border: const OutlineInputBorder(),
        ),
      ),
    );
  }

}
