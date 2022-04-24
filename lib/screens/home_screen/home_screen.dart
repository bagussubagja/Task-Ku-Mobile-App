import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                        user?.displayName ?? '',
                        style: titleBlackStyle.copyWith(fontSize: 22),
                      )
                    ],
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(user?.photoURL ?? ''),
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
              )
            ],
          ),
        ),
      )),
    );
  }
}
