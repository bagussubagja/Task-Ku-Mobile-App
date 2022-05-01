// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_ku_mobile_app/screens/about_screen/about_screen.dart';

class NavBar extends StatelessWidget {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NavBar({Key? key}) : super(key: key);
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
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('About'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return const AboutScreen();
            })),
          ),
         const Divider(),
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
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Your tasks successfully deleted!')));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
