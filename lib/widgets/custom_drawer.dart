
import 'package:beehairsalon/views/login.dart';
import 'package:flutter/material.dart';
import 'package:beehairsalon/config/palette.dart';

class CustomDrawer extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://secure.gravatar.com/avatar/d2ac88422b29a9a124df38d676bff03d?s=40&r=g'),
            ),
            accountName: new Text('Duy Cường'),
            accountEmail: new Text('codigoalphacol@gmail.com'),

          ),
          new Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Chỉnh sửa tài khoản'),
            onTap: () {
              // change app state...
              Navigator.pop(context); // close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.settings_backup_restore),
            title: Text('Đổi mật khẩu'),
            onTap: () {
              // change app state...
              Navigator.pop(context); // close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.change_history),
            title: Text('Lịch sử đặt lịch'),
            onTap: () {
              // change app state...
              Navigator.pop(context); // close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.announcement),
            title: Text('Trợ giúp và phản hồi'),
            onTap: () {
              // change app state...
              Navigator.pop(context); // close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.settings_power),
            title: Text('Đăng xuất'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LogIn()), (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}