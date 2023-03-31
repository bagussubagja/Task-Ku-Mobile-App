// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:task_ku_mobile_app/models/task_model.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';
import 'package:task_ku_mobile_app/widgets/input_field.dart';

class EditTaskScreen extends StatefulWidget {
  TaskModel taskModels;
  int index;

  EditTaskScreen({Key? key, required this.taskModels, required this.index})
      : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  DateTime _selectedDate = DateTime.now();

  String _startTime = DateFormat("HH:mm").format(DateTime.now()).toString();
  String _endTime = "";

  bool isDone = false;

  final TextEditingController titleController = TextEditingController();

  final TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.taskModels.title;
    descController.text = widget.taskModels.desc;
    _startTime = widget.taskModels.startTask;
    _endTime = widget.taskModels.endTask;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: Text(
            'Edit Task',
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
                hintText: widget.taskModels.title,
                controller: titleController,
              ),
              const SizedBox(
                height: 10,
              ),
              InputField(
                titleText: 'Description',
                hintText: widget.taskModels.desc,
                controller: descController,
              ),
              const SizedBox(
                height: 10,
              ),
              InputField(
                titleText: 'Task Date',
                hintText:
                    widget.taskModels.taskDate.toString().substring(0, 10),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Do you already finish this task?'),
                  Switch(
                      value: isDone,
                      onChanged: (value) {
                        setState(() {
                          isDone = true;
                        });
                      }),
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
                      try {
                        editTodo(
                            title: title,
                            desc: desc,
                            taskDate: selectedDate,
                            startTime: _startTime,
                            endTime: _endTime,
                            isDone: isDone);

                        Navigator.of(context).pop();
                      } catch (e) {
                        if (kDebugMode) {
                          print(e.toString());
                        }
                      }

                      if (isDone == true) {
                        await flutterLocalNotificationsPlugin.cancelAll();
                      }

                      titleController.clear();
                      descController.clear();

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Task Successfully edited!')));
                    },
                    child: Text(
                      'Edit Task',
                      style: regularStyle,
                    )),
              )
            ],
          ),
        ),
      )),
    );
  }

  Future editTodo(
      {required String title,
      required String desc,
      required DateTime taskDate,
      required String startTime,
      required String endTime,
      required bool isDone}) async {
    final user = FirebaseAuth.instance.currentUser;
    var collection =
        FirebaseFirestore.instance.collection('todo-list ${user?.uid}');
    var snapshots = await collection.get();
    var doc = snapshots.docs;
    final editedTask = TaskModel(
        id: snapshots.docs[widget.index].id,
        title: title,
        desc: desc,
        taskDate: taskDate,
        startTask: startTime,
        endTask: endTime,
        isDone: isDone);
    final json = editedTask.toJson();
    collection.doc(snapshots.docs[widget.index].id).set(json);
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime?.format(context) ?? _endTime;
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
    return showTimePicker(
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
