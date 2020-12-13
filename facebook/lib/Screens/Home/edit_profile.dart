import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/components/components.dart';
import 'package:facebook/components/search_app_bar.dart';
import 'package:facebook/data/source/localdatasource/data_personal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tiengviet/tiengviet.dart';
import '../../constants.dart';
import 'package:clipboard/clipboard.dart';
import 'package:toast/toast.dart';
class EditProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    void showToast(String msg, {int duration, int gravity}) {
      Toast.show(msg, context, duration: duration, gravity: gravity);
    }
    var link = 'https://www.facebook.com/' +
        TiengViet.parse(currentUser.username).toLowerCase().replaceAll(" ", "");
    const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: Text(
            'Chỉnh sửa trang cá nhân',
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
          // physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            Column(
              children: <Widget>[
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        // decoration:BoxDecoration(
                        //     borderRadius:BorderRadius.circular(10),
                        //     color:Colors.green
                        // ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Ảnh đại diện",style: TextStyle(color:Colors.black,fontSize:19, fontWeight: FontWeight.bold),)
                        ),
                      ),),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Chỉnh sửa",style: TextStyle(color:Colors.blue,fontSize:16),)
                        ),
                      ),),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 65.0,
                      backgroundImage:
                      CachedNetworkImageProvider(currentUser.avatar),
                    ),
                  ],
                )
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        // decoration:BoxDecoration(
                        //     borderRadius:BorderRadius.circular(10),
                        //     color:Colors.green
                        // ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Ảnh bìa",style: TextStyle(color:Colors.black,fontSize:19, fontWeight: FontWeight.bold),)
                        ),
                      ),),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Chỉnh sửa",style: TextStyle(color:Colors.blue,fontSize:16),)
                        ),
                      ),),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/login_bottom.png',
                          width: 350.0,
                          height: 200.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        // decoration:BoxDecoration(
                        //     borderRadius:BorderRadius.circular(10),
                        //     color:Colors.green
                        // ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Tiểu sử",style: TextStyle(color:Colors.black,fontSize:19, fontWeight: FontWeight.bold),)
                        ),
                      ),),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Thêm",style: TextStyle(color:Colors.blue,fontSize:16),)
                        ),
                      ),),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      'Hello, ' + currentUser.username+ '! How are you?',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        // decoration:BoxDecoration(
                        //     borderRadius:BorderRadius.circular(10),
                        //     color:Colors.green
                        // ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Chi tiết",style: TextStyle(color:Colors.black,fontSize:19, fontWeight: FontWeight.bold),)
                        ),
                      ),),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Chỉnh sửa",style: TextStyle(color:Colors.blue,fontSize:16),)
                        ),
                      ),),
                  ],
                ),
                ListView(
                  shrinkWrap: true,
                  // physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    InkWell(
                      child: ListTile(
                        leading: Icon(MdiIcons.pencilOutline),
                        title: Text('Từng học tại Đại học Bách Khoa Hà Nội - Hanoi University of Science and Technology',
                            style: TextStyle(fontSize: 16.0)),
                        onTap: () => {},
                      ),
                    ),
                    Divider(
                      height: 5.0,
                    ),
                    InkWell(
                      child: ListTile(
                        leading: Icon(MdiIcons.toolboxOutline),
                        title: Text('Đã học tại trường THPT Ba Đình', style: TextStyle(fontSize: 16.0)),
                        onTap: () => {},
                      ),
                    ),
                    Divider(
                      height: 5.0,
                    ),
                    InkWell(
                      child: ListTile(
                        leading: Icon(MdiIcons.eyeOutline),
                        title: Text('Sống tại Hà Nội', style: TextStyle(fontSize: 16.0)),
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
                        Text('Đến từ Nga Sơn', style: TextStyle(fontSize: 16.0)),
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
                        Text('Độc thân', style: TextStyle(fontSize: 16.0)),
                        onTap: () => {},
                      ),
                    ),
                    Divider(
                      height: 5.0,
                    ),
                    InkWell(
                      child: ListTile(
                        leading: Icon(Icons.search),
                        title: Text('Tham gia vào Tháng 3 năm 2013',
                            style: TextStyle(fontSize: 16.0)),
                        onTap: () => {},
                      ),
                    ),
                    Divider(
                      height: 5.0,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        // decoration:BoxDecoration(
                        //     borderRadius:BorderRadius.circular(10),
                        //     color:Colors.green
                        // ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Sở thích",style: TextStyle(color:Colors.black,fontSize:19, fontWeight: FontWeight.bold),)
                        ),
                      ),),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Thêm",style: TextStyle(color:Colors.blue,fontSize:16),)
                        ),
                      ),),
                  ],
                ),
                SizedBox(height: 300),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
