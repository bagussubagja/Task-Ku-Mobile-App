// ignore_for_file: unused_field, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:task_ku_mobile_app/models/task_model.dart';
import 'package:task_ku_mobile_app/screens/edit_task_screen/edit_task_screen.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Howdy,',
                          style: regularBlackStyle.copyWith(fontSize: 18)),
                      Text(
                        user?.displayName ?? 'Workaholic!',
                        style: titleBlackStyle.copyWith(fontSize: 22),
                      )
                    ],
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(user?.photoURL ??
                        'https://img1.pngdownload.id/20180626/ehy/kisspng-avatar-user-computer-icons-software-developer-5b327cc951ae22.8377289615300354013346.jpg'),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                child: DatePicker(
                  DateTime.now(),
                  height: 100,
                  width: 80,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: bluePrimaryColor,
                  selectedTextColor: Colors.white,
                  dateTextStyle: TextStyle(fontSize: 18, color: greyColor),
                  monthTextStyle: TextStyle(fontSize: 12, color: greyColor),
                  dayTextStyle: TextStyle(fontSize: 12, color: greyColor),
                  onDateChange: (date) {
                    _selectedDate = date;
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today',
                    style: regularStyle.copyWith(color: greyColor),
                  ),
                  Text(
                    DateFormat.yMMMMd().format(DateTime.now()),
                    style: regularBlackStyle,
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              // StreamBuilder<List<TaskModel>>(
              //   stream: readTasks(),
              //   builder: (context, snapshot) {
              //     try {
              //       if (snapshot.hasError) {
              //         return Text('Something error ${snapshot.error}!');
              //       } else if (snapshot.hasData && snapshot.data != []) {
              //         print('ga null');
              //         final tasks = snapshot.data!;
              //         return ListView.builder(
              //           itemCount: tasks.length,
              //           primary: false,
              //           itemBuilder: (context, index) =>
              //               buildTask(tasks[index], index, context),
              //           scrollDirection: Axis.vertical,
              //           shrinkWrap: true,
              //         );
              //       } else if (snapshot.connectionState ==
              //           ConnectionState.waiting) {
              //         return const Center(
              //           child: CircularProgressIndicator(),
              //         );
              //       } else if (snapshot.data == [] ||
              //           snapshot.connectionState == ConnectionState.active) {
              //         print('null nich');
              //         return Align(
              //           alignment: Alignment.bottomCenter,
              //           child: Text('No Task Available!'),
              //         );
              //       } else {
              //         return const SizedBox.shrink();
              //       }
              //     } catch (e) {
              //       return const SizedBox();
              //     }
              //   },
              // )
              StreamBuilder<List<TaskModel>>(
                stream: readTasks(),
                builder: (context, snapshot) {
                  try {
                    if (snapshot.hasError) {
                      return Text('Something error ${snapshot.error}!');
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      final tasks = snapshot.data!;
                      return ListView.builder(
                        itemCount: tasks.length,
                        primary: false,
                        itemBuilder: (context, index) =>
                            buildTask(tasks[index], index, context),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('No Task Available!'),
                      );
                    }
                  } catch (e) {
                    return const SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Stream<List<TaskModel>> readTasks() {
  final user = FirebaseAuth.instance.currentUser;
  return FirebaseFirestore.instance
      .collection('todo-list ${user?.uid}')
      .orderBy(('taskDate'), descending: false)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((e) => TaskModel.fromJson(e.data())).toList();
  });
}

Widget buildTask(TaskModel taskModel, int index, BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 15),
    padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
    decoration: BoxDecoration(
        color: bluePrimaryColor, borderRadius: BorderRadius.circular(10)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title :',
              style: titleStyle.copyWith(fontSize: 16),
            ),
            Text(
              taskModel.title.length > 28
                  ? taskModel.title.substring(0, 28) + '...'
                  : taskModel.title,
              style: regularStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Description : ',
              style: titleStyle.copyWith(fontSize: 16),
            ),
            SizedBox(
              child: Text(
                taskModel.desc.length > 30
                    ? taskModel.desc.substring(0, 30) + '...'
                    : taskModel.desc,
                style: regularStyle.copyWith(fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task Date : ',
                      style: titleStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      taskModel.taskDate.toString().substring(0, 10),
                      style: regularStyle,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\t\t\t\t\t\t\t\t\t\t\t\t\t Start Time : ',
                      style: titleStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      '\t\t\t\t\t\t\t\t\t\t\t\t\t\t' + taskModel.startTask,
                      style: regularStyle,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        Column(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    // return EditTaskScreen(taskModel: taskModel[index]);
                    return EditTaskScreen(
                      taskModels: taskModel,
                      index: index,
                    );
                  }));
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                )),
            taskModel.isDone == false
                ? const Icon(
                    Icons.clear,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
            IconButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Message'),
                        content: Text(
                            'Are your sure to delete ${taskModel.title} task?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              FlutterLocalNotificationsPlugin
                                  flutterLocalNotificationsPlugin =
                                  FlutterLocalNotificationsPlugin();
                              final user = FirebaseAuth.instance.currentUser;
                              var collection = FirebaseFirestore.instance
                                  .collection('todo-list ${user?.uid}');
                              var snapshots = await collection.get();
                              var doc = snapshots.docs;
                              collection.doc(snapshots.docs[index].id).delete();
                              Navigator.pop(context);
                              await flutterLocalNotificationsPlugin.cancelAll();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Your task successfully deleted!')));
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
