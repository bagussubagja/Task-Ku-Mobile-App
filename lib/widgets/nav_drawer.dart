import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_ku_mobile_app/provider/google_sign_in.dart';
import 'package:task_ku_mobile_app/screens/about_screen/about_screen.dart';
import 'package:task_ku_mobile_app/screens/help_center_screen/help_center_screen.dart';
import 'package:task_ku_mobile_app/screens/setting_screen/setting_screen.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Drawer(
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            height: 200,
            width: 100,
            child: Image.asset('assets/images/Logo_App_Full_Name.png'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text('About'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return AboutScreen();
            })),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Help Center'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return HelpCenterScreen();
            })),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return SettingScreen();
            })),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete All Task'),
            onTap: () async {
              final user = FirebaseAuth.instance.currentUser;
              var collection =
                  FirebaseFirestore.instance.collection('todo-list ${user?.uid}');
              var snapshots = await collection.get();
              for (var doc in snapshots.docs) {
                await doc.reference.delete();
              }
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Semua data telah dihapus!')));
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign Out'),
            onTap: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
          ),
        ],
      ),
    );
  }
}
