import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  DateTime _selectedDate = DateTime.now();

  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = "10:00 AM";

  bool isDone = false;

  final TextEditingController titleController = TextEditingController();

  final TextEditingController descController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            children: [
              InputField(
                titleText: 'Title',
                hintText: widget.taskModels.title,
                controller: titleController,
              ),
              SizedBox(
                height: 10,
              ),
              InputField(
                titleText: 'Description',
                hintText: widget.taskModels.desc,
                controller: descController,
              ),
              SizedBox(
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
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: InputField(
                    titleText: 'Start Date',
                    hintText: _startTime,
                    widget: Container(),
                    prefixIcon: Icon(Icons.access_time_rounded),
                    onTap: () {
                      _getTimeFromUser(isStartTime: true);
                    },
                  )),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: InputField(
                    titleText: 'End Date',
                    hintText: _endTime,
                    widget: Container(),
                    prefixIcon: Icon(Icons.access_time_rounded),
                    onTap: () {
                      _getTimeFromUser(isStartTime: false);
                    },
                  ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 290,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      final title = titleController.text;
                      final desc = descController.text;
                      final selectedDate = _selectedDate;
                      final startTime = _startTime;
                      final endTime = _endTime;
                      print(startTime);
                      try {
                        editTodo(
                            title: title,
                            desc: desc,
                            taskDate: selectedDate,
                            startTime: _startTime,
                            endTime: _endTime);
                        Navigator.of(context).pop();
                      } catch (e) {
                        print(e.toString());
                      }

                      titleController.clear();
                      descController.clear();

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Task Successfully edited!')));
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

  Future editTodo({
    required String title,
    required String desc,
    required DateTime taskDate,
    required String startTime,
    required String endTime,
  }) async {
    var collection = FirebaseFirestore.instance.collection('todo-list');
    var snapshots = await collection.get();
    var doc = snapshots.docs;
    final editedTask = TaskModel(
        id: snapshots.docs[widget.index].id,
        title: title,
        desc: desc,
        taskDate: taskDate,
        startTask: startTime,
        endTask: endTime);
    final json = editedTask.toJson();
    print(json);
    collection.doc(snapshots.docs[widget.index].id).update(json);
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime?.format(context) ?? _endTime;
    if (pickedTime == null) {
      print('Time is NULL');
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
        print(_startTime);
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
        print(_endTime);
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
        print(_selectedDate);
      });
    } else {
      print('something wrong!');
    }
  }
}
