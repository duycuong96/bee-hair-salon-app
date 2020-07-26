
import 'package:beehairsalon/views/login.dart';
import 'package:flutter/material.dart';
import 'package:beehairsalon/config/palette.dart';
import 'package:beehairsalon/providers/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CustomDrawer extends StatefulWidget {
  @override
  CustomDrawerState createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer> {

  String _name = "";

  Future<String> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name');
    });

  }

  @override
  void initState() {
    getUserData().then(updateName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://secure.gravatar.com/avatar/d2ac88422b29a9a124df38d676bff03d?s=40&r=g'),
            ),
            accountName: new Text(_name == null ? 'Cuong VD' : _name),
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

  void updateName(String name) {
    setState(() {
      this._name = name;
    });
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}



