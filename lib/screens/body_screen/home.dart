// ignore_for_file: unused_field, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_ku_mobile_app/constants/constants.dart';
import 'package:task_ku_mobile_app/models/task_model.dart';
import 'package:task_ku_mobile_app/screens/edit_task_screen/edit_task_screen.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';
import 'package:task_ku_mobile_app/utils/shared_preferences.dart';
import 'package:task_ku_mobile_app/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  DateTime _selectedDate = DateTime.now();

  String displayName = '';

  @override
  void initState() {
    super.initState();
    SharedPrefsHelper.getUserDisplayName().then((value) {
      setState(() {
        displayName = value;
      });
    });
  }

  Stream<List<TaskModel>> readTasks() {
    final user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('${Constants.collectionName} ${user?.uid}')
        .where(('dateTime'),
            isEqualTo: Utils.formattedDateDisplayed(_selectedDate))
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) => TaskModel.fromJson(e.data())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerSection(user!, displayName),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              child: DatePicker(
                DateTime(DateTime.now().year, DateTime.now().month, 1),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: bluePrimaryColor,
                selectedTextColor: Colors.white,
                dateTextStyle: TextStyle(fontSize: 18, color: greyColor),
                monthTextStyle: TextStyle(fontSize: 12, color: greyColor),
                dayTextStyle: TextStyle(fontSize: 12, color: greyColor),
                onDateChange: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
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
                  Utils.formattedDateDisplayed(_selectedDate),
                  style: regularStyle,
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            StreamBuilder<List<TaskModel>>(
              stream: readTasks(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Expanded(
                    child: Center(
                      child: Text('Error Occured: ${snapshot.error}'),
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final tasks = snapshot.data!;
                  return Expanded(
                      child: ListView.builder(
                    itemCount: tasks.length,
                    primary: true,
                    itemBuilder: (context, index) {
                      return buildTask(tasks[index], index, context);
                    },
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                  ));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return Expanded(
                      child: Center(
                    child: Text(
                      'Task Not Available',
                      style: regularStyle,
                    ),
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget _headerSection(User user, String displayName) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Constants.headerGreeting,
              style: regularStyle.copyWith(fontSize: 18)),
          Text(
            user.displayName != null && user.displayName!.isNotEmpty
                ? user.displayName!
                : user.email!,
            style: titleStyle.copyWith(fontSize: 22),
          )
        ],
      ),
      CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(
          user.photoURL ?? Constants.randomAvatar,
        ),
      )
    ],
  );
}

Widget buildTask(TaskModel taskModel, int index, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: const EdgeInsets.only(top: 15),
    padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
    decoration: BoxDecoration(
        color: Color(taskModel.colorBox),
        borderRadius: BorderRadius.circular(10)),
    child: Stack(
      children: [
        Positioned(
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Text(
              taskModel.levelPriority,
              style: regularBlackStyle.copyWith(
                fontSize: 8,
                color: Color(taskModel.colorBox),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title :',
                    style: titleWhiteStyle.copyWith(fontSize: 16),
                  ),
                  Text(
                    taskModel.title.length > 28
                        ? '${taskModel.title.substring(0, 28)}...'
                        : taskModel.title,
                    style: !taskModel.isDone
                        ? regularWhiteStyle
                        : regularWhiteStyle.copyWith(
                            decoration: TextDecoration.lineThrough,
                          ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Description : ',
                    style: titleWhiteStyle.copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    child: Text(
                      taskModel.desc.length > 30
                          ? '${taskModel.desc.substring(0, 30)}...'
                          : taskModel.desc,
                      style: !taskModel.isDone
                          ? regularWhiteStyle
                          : regularWhiteStyle.copyWith(
                              decoration: TextDecoration.lineThrough,
                            ),
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
                            style: titleWhiteStyle.copyWith(fontSize: 16),
                          ),
                          Text(
                            taskModel.taskDate.toString().substring(0, 10),
                            style: regularWhiteStyle,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Time : ',
                            style: titleWhiteStyle.copyWith(fontSize: 16),
                          ),
                          Text(
                            "${taskModel.startTask} WIB",
                            style: regularWhiteStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
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
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  FlutterLocalNotificationsPlugin
                                      flutterLocalNotificationsPlugin =
                                      FlutterLocalNotificationsPlugin();
                                  final user =
                                      FirebaseAuth.instance.currentUser;
                                  var collection = FirebaseFirestore.instance
                                      .collection('todo-list ${user?.uid}');
                                  var snapshots = await collection.get();
                                  var doc = snapshots.docs;
                                  collection
                                      .doc(snapshots.docs[index].id)
                                      .delete();
                                  Navigator.pop(context);
                                  await flutterLocalNotificationsPlugin
                                      .cancelAll();
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
        )
      ],
    ),
  );
}
