import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            height: 200,
            width: 100,
            child: Image.asset('assets/images/Logo App_Full Name.png'),
          ),
          ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text('About'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Help Center'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign Out'),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
