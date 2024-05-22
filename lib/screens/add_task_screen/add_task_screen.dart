// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_ku_mobile_app/models/task_model.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';
import 'package:task_ku_mobile_app/utils/utils.dart';
import 'package:task_ku_mobile_app/widgets/input_field.dart';
import 'package:task_ku_mobile_app/widgets/notification.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final List<Color> levelPriorityColors = const [
    Color(0xFFff6666),
    Color(0xffffb347),
    Color(0xFF9acd32),
    Color(0xFF6495ed),
  ];
  final List<String> levelPriorityText = const [
    'High Priority',
    'Medium Priority',
    'Low Priority',
    'Informational',
  ];

  Color? selectedColorLevelPriority;
  String? selectedColorLevelText;
  int currentColorIndex = 0;
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
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Add Task',
          style: titleStyle,
        ),
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Text(
              'Select Priority Level',
              style: regularStyle,
            ),
            const SizedBox(
              height: 12,
            ),
            Wrap(
              spacing: 10,
              runAlignment: WrapAlignment.center,
              children: levelPriorityColors.asMap().entries.map((entry) {
                final index = entry.key;
                final color = entry.value;
                Color borderColor;
                String levelPriority;

                // Assign border color based on index
                switch (currentColorIndex) {
                  case 0:
                    borderColor = Colors.red;
                    break;
                  case 1:
                    borderColor = Colors.orange;
                    break;
                  case 2:
                    borderColor = Colors.green;
                    break;
                  case 3:
                    borderColor = Colors.blue;
                    break;
                  case 4:
                    borderColor = Colors.grey;
                    break;
                  default:
                    borderColor = Colors.black;
                }

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColorLevelPriority = color;
                      selectedColorLevelText = levelPriorityText[index];
                      currentColorIndex = index;
                    });
                    Utils.showSnackbar(context,
                        'You choose task level ${levelPriorityText[index]}!');
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: currentColorIndex == index
                          ? Border.all(
                              color:
                                  borderColor, // Use the borderColor based on index
                              width: 2.0,
                            )
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: titleController.text.isNotEmpty &&
                          descController.text.isNotEmpty
                      ? () async {
                          final title = titleController.text;
                          final desc = descController.text;
                          final selectedDate = _selectedDate;
                          final startTime = _startTime;
                          final endTime = _endTime;
                          final colorBox = selectedColorLevelPriority;

                          createTodo(
                              title: title,
                              desc: desc,
                              taskDate: selectedDate,
                              startTime: startTime,
                              endTime: endTime,
                              isDone: false,
                              colorBox: colorBox!.value,
                              levelPriority: selectedColorLevelText!);
                          titleController.clear();
                          descController.clear();
                          Navigator.of(context).pop();
                          sendNotification(
                              'Hi, your task "${title}" is already set up!',
                              'We keep reminds you every day until its done!😁');
                          sendNotificationPeriodically(
                              'Hello, did your already finish your ${title} task?',
                              'Dont worry, we just remind you there is a task to do! 😊');

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Task Successfully added!')));
                        }
                      : null,
                  child: Text(
                    'Add Task',
                    style: regularWhiteStyle,
                  )),
            )
          ],
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
      required bool isDone,
      required String levelPriority}) async {
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
      colorBox: colorBox,
      levelPriority: selectedColorLevelText!,
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
