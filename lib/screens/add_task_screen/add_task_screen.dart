// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_ku_mobile_app/models/task_model.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';
import 'package:task_ku_mobile_app/widgets/input_field.dart';
import 'package:task_ku_mobile_app/widgets/notification.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("HH:mm").format(DateTime.now()).toString();
  String _endTime = DateFormat("HH:mm")
      .format(DateTime.now().add(const Duration(hours: 3)))
      .toString();
  bool isDone = false;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: Text(
            'Add Task',
            style: titleBlackStyle.copyWith(fontSize: 22),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            children: [
              InputField(
                titleText: 'Title',
                hintText: 'Enter your title...',
                controller: titleController,
              ),
              const SizedBox(
                height: 10,
              ),
              InputField(
                titleText: 'Description',
                hintText: 'Enter your description...',
                controller: descController,
              ),
              const SizedBox(
                height: 10,
              ),
              InputField(
                titleText: 'Task Date',
                hintText: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                    onPressed: () {
                      _getDateFromUser();
                    },
                    icon: Icon(
                      Icons.calendar_today,
                      color: greyColor,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: InputField(
                    titleText: 'Start Date',
                    hintText: _startTime,
                    widget: Container(),
                    prefixIcon: const Icon(Icons.access_time_rounded),
                    onTap: () {
                      _getTimeFromUser(isStartTime: true);
                    },
                  )),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: InputField(
                    titleText: 'End Date',
                    hintText: _endTime,
                    widget: Container(),
                    prefixIcon: const Icon(Icons.access_time_rounded),
                    onTap: () {
                      _getTimeFromUser(isStartTime: false);
                    },
                  ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 290,
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      final title = titleController.text;
                      final desc = descController.text;
                      final selectedDate = _selectedDate;
                      final startTime = _startTime;
                      final endTime = _endTime;
                      const colorBox = 0xFF111111;

                      createTodo(
                        title: title,
                        desc: desc,
                        taskDate: selectedDate,
                        startTime: startTime,
                        endTime: endTime,
                        isDone: false,
                        colorBox: colorBox
                      );
                      titleController.clear();
                      descController.clear();
                      Navigator.of(context).pop();
                      sendNotification(
                          'Hi, your task "${title}" is already set up!',
                          'We keep reminds you every day until its done!😁');
                      sendNotificationPeriodically(
                          'Hello, did your already finish your ${title} task?',
                          'Dont worry, we just remind you there is a task to do! 😊');

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Task Successfully added!')));
                    },
                    child: Text(
                      'Add Task',
                      style: regularStyle,
                    )),
              )
            ],
          ),
        ),
      )),
    );
  }

  Future createTodo(
      {required String title,
      required String desc,
      required DateTime taskDate,
      required String startTime,
      required String endTime,
      required int colorBox,
      required bool isDone}) async {
    final user = FirebaseAuth.instance.currentUser;
    final docTodo =
        FirebaseFirestore.instance.collection('todo-list ${user?.uid}').doc();

    final task = TaskModel(
      id: docTodo.id,
      title: title,
      desc: desc,
      taskDate: taskDate,
      startTask: startTime,
      endTask: endTime,
      isDone: false,
      colorBox: colorBox
    );

    final json = task.toJson();

    await docTodo.set(json);
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime?.format(context) ?? '10:00 AM';
    if (pickedTime == null) {
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  Future<TimeOfDay?> _showTimePicker() async {
    return await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }

  Future _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {}
  }
}
