import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_ku_mobile_app/models/task_model.dart';
import 'package:task_ku_mobile_app/screens/add_task_screen/add_task_screen.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';
import 'package:task_ku_mobile_app/widgets/nav_drawer.dart';

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
    return Scaffold(
      drawer: NavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AddTaskScreen();
          }));
        },
        child: Icon(Icons.add),
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black),
      body: SafeArea(
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
                        user?.displayName ?? 'Guest',
                        style: titleBlackStyle.copyWith(fontSize: 22),
                      )
                    ],
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(user?.photoURL ??
                        'https://img3.pngdownload.id/dy/1b9ce737ab4309d77f8ae34c5c4871b4/L0KzQYm3VsI3N6Z8i5H0aYP2gLBuTfF3aaVmip9Ac3X1PbT2jgB2fJZ3Rdtsb372PcT2hwR4aaNqRdZudnXvf8Hskr02amQ3T9VsOXPmQYbtV745P2M8SqkDMEG4Q4G3U8U1OGI9S6g3cH7q/kisspng-avatar-user-computer-icons-software-developer-5b327cc9cc15f7.872727801530035401836.png'),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
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
              SizedBox(
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
              SizedBox(
                height: 15,
              ),
              StreamBuilder<List<TaskModel>>(
                  stream: readTasks(),
                  builder: (context, snapshot) {
                    print(snapshot);
                    try {
                      if (snapshot.hasError) {
                        return Text('Something error ${snapshot.error}!');
                      } else if (snapshot.hasData) {
                        final tasks = snapshot.data!;
                        return ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) =>
                              buildTask(tasks[index], index),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                        );
                      } else if (!snapshot.hasData) {
                        return Text('No Data');
                      } else {
                        return CircularProgressIndicator();
                      }
                    } catch (e) {
                      return SizedBox();
                    }
                  })
            ],
          ),
        ),
      )),
    );
  }
}

Stream<List<TaskModel>> readTasks() {
  return FirebaseFirestore.instance
      .collection('todo-list')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((e) => TaskModel.fromJson(e.data())).toList();
  });
}

Widget buildTask(TaskModel taskModel, int index) {
  bool isChecked = false;

  return Container(
    margin: EdgeInsets.only(top: 15),
    padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
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
              taskModel.title,
              style: regularStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Description : ',
              style: titleStyle.copyWith(fontSize: 16),
            ),
            Container(
              child: Text(
                taskModel.desc,
                style: regularStyle.copyWith(fontSize: 10),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Start Time : ',
              style: titleStyle.copyWith(fontSize: 16),
            ),
            Text(
              taskModel.startTask,
              style: regularStyle,
            ),
          ],
        ),
        IconButton(
            onPressed: () async {
              var collection =
                  FirebaseFirestore.instance.collection('todo-list');
              var snapshots = await collection.get();
              var doc = snapshots.docs;
              collection.doc(snapshots.docs[index].id).delete();
            },
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ))
      ],
    ),
  );
}
