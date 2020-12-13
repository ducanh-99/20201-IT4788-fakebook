import 'package:facebook/components/components.dart';
import 'package:facebook/components/search_app_bar.dart';
import 'package:facebook/data/models/user.dart';
import 'package:facebook/data/source/localdatasource/data_personal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tiengviet/tiengviet.dart';
import '../../constants.dart';
import 'package:clipboard/clipboard.dart';
import 'package:toast/toast.dart';
import 'package:facebook/Screens/Home/edit_profile.dart';

class Setup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void showToast(String msg, {int duration, int gravity}) {
      Toast.show(msg, context, duration: duration, gravity: gravity);
    }

    var link = 'https://www.facebook.com/' +
        TiengViet.parse(currentUser.username).toLowerCase().replaceAll(" ", "");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: Text(
            'Cài đặt trang cá nhân',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: kBlack),
          ),
          iconTheme: IconThemeData(color: kColorTextNormal),
          actions: [
            CircleButton(
              icon: Icons.search,
              iconSize: 30.0,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SearchBackGround();
                  },
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            InkWell(
              child: ListTile(
                leading: Icon(MdiIcons.pencilOutline),
                title: Text('Chỉnh sửa trang cá nhân',
                    style: TextStyle(fontSize: 16.0)),
                onTap: () => {
                  print("Chuyen den chỉnh sửa trang cá nhân"),
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return EditProfile();
                    }),
                  )
                },
              ),
            ),
            Divider(
              height: 5.0,
            ),
            InkWell(
              child: ListTile(
                leading: Icon(MdiIcons.toolboxOutline),
                title: Text('Lưu trữ', style: TextStyle(fontSize: 16.0)),
                onTap: () => {},
              ),
            ),
            Divider(
              height: 5.0,
            ),
            InkWell(
              child: ListTile(
                leading: Icon(MdiIcons.eyeOutline),
                title: Text('Chế độ xem', style: TextStyle(fontSize: 16.0)),
                onTap: () => {},
              ),
            ),
            Divider(
              height: 5.0,
            ),
            InkWell(
              child: ListTile(
                leading: Icon(MdiIcons.formatListBulleted),
                title:
                    Text('Nhật ký hoạt động', style: TextStyle(fontSize: 16.0)),
                onTap: () => {},
              ),
            ),
            Divider(
              height: 5.0,
            ),
            InkWell(
              child: ListTile(
                leading: Icon(MdiIcons.textBoxOutline),
                title:
                    Text('Quản lý bài viết', style: TextStyle(fontSize: 16.0)),
                onTap: () => {},
              ),
            ),
            Divider(
              height: 5.0,
            ),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.search),
                title: Text('Tìm kiếm trên trang cá nhân',
                    style: TextStyle(fontSize: 16.0)),
                onTap: () => {},
              ),
            ),
            Divider(
              height: 5.0,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Liên kết đến trang cá nhân',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Liên kết của riêng bạn trên Facebook',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  Divider(
                    height: 5.0,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'https://www.facebook.com/' +
                        TiengViet.parse(currentUser.username)
                            .toLowerCase()
                            .replaceAll(" ", ""),
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  InkWell(
                    child: Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                          color: backgroundColor,
                          border:
                              Border.all(width: 2.0, color: Colors.grey[300]),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: FlatButton(
                          onPressed: () async {
                            await FlutterClipboard.copy(link);
                            showToast("Đã sao chép liên kết vào bộ nhớ tạm",
                                gravity: Toast.BOTTOM);
                          },
                          child: Text('SAO CHÉP LIÊN KẾT',
                              style: TextStyle(color: kBlack))),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SetupUser extends StatelessWidget {
  final User user;

  const SetupUser({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    void showToast(String msg, {int duration, int gravity}) {
      Toast.show(msg, context, duration: duration, gravity: gravity);
    }

    var link = 'https://www.facebook.com/' +
        TiengViet.parse(user.username).toLowerCase().replaceAll(" ", "");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: Text(
            'Cài đặt trang cá nhân',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: kBlack),
          ),
          iconTheme: IconThemeData(color: kColorTextNormal),
          actions: [
            CircleButton(
              icon: Icons.search,
              iconSize: 30.0,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SearchBackGround();
                  },
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            InkWell(
              child: ListTile(
                leading: Icon(MdiIcons.accountMultiple),
                title:
                Text('Xem quan hệ bạn bè', style: TextStyle(fontSize: 16.0)),
                onTap: () => {},
              ),
            ),
            Divider(
              height: 5.0,
            ),
            InkWell(
              child: ListTile(
                leading: Icon(MdiIcons.alertOctagon),
                title: Text('Tìm hỗ trợ hoặc báo cáo trang', style: TextStyle(fontSize: 16.0)),
                onTap: () => {},
              ),
            ),
            Divider(
              height: 5.0,
            ),
            InkWell(
              child: ListTile(
                leading: Icon(MdiIcons.accountCancel),
                title:
                Text('Chặn', style: TextStyle(fontSize: 16.0)),
                onTap: () => {},
              ),
            ),
            Divider(
              height: 5.0,
            ),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.search),
                title: Text('Tìm kiếm trên trang cá nhân',
                    style: TextStyle(fontSize: 16.0)),
                onTap: () => {},
              ),
            ),
            Divider(
              height: 5.0,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Liên kết đến trang cá nhân ' + user.username,
                    style:
                    TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Liên kết của bạn bè trên Facebook',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  Divider(
                    height: 5.0,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'https://www.facebook.com/' +
                        TiengViet.parse(user.username)
                            .toLowerCase()
                            .replaceAll(" ", ""),
                    style:
                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  InkWell(
                    child: Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                          color: backgroundColor,
                          border:
                          Border.all(width: 2.0, color: Colors.grey[300]),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: FlatButton(
                          onPressed: () async {
                            await FlutterClipboard.copy(link);
                            showToast("Đã sao chép liên kết vào bộ nhớ tạm",
                                gravity: Toast.BOTTOM);
                          },
                          child: Text('SAO CHÉP LIÊN KẾT',
                              style: TextStyle(color: kBlack))),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
