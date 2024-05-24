// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:task_ku_mobile_app/provider/google_sign_in.dart';
import 'package:task_ku_mobile_app/screens/about_screen/about_screen.dart';

class NavDrawer extends StatelessWidget {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NavDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            height: 200,
            width: 100,
            child: Image.asset('assets/images/Logo_App_Full_Name.png'),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('About'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return const AboutScreen();
            })),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete All Task'),
            onTap: () async {
              final user = FirebaseAuth.instance.currentUser;
              var collection = FirebaseFirestore.instance
                  .collection('todo-list ${user?.uid}');
              var snapshots = await collection.get();
              for (var doc in snapshots.docs) {
                await doc.reference.delete();
              }
              await flutterLocalNotificationsPlugin.cancelAll();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Your tasks successfully deleted!')));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
