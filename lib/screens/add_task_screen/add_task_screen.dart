import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:task_ku_mobile_app/models/task_model.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';
import 'package:task_ku_mobile_app/utils/utils.dart';
import 'package:task_ku_mobile_app/widgets/input_field.dart';
import 'package:task_ku_mobile_app/utils/notification.dart';

class AddTaskScreen extends StatefulWidget {
  final bool isEdit;
  final TaskModel? taskModels;
  final int? index;
  const AddTaskScreen(
      {Key? key, required this.isEdit, this.taskModels, this.index})
      : super(key: key);

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

  final List<String> priorityNotifLevel = [
    "Every Minute",
    "Hourly",
    "Daily",
    "Weekly",
  ];

  String selectedPriorityNotifLevel = 'Every Minute';
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Color? selectedColorLevelPriority;
  String? selectedColorLevelText;
  int currentColorIndex = 0;
  late DateTime _selectedDate;
  String _startTime = DateFormat("HH:mm").format(DateTime.now()).toString();
  String _endTime = DateFormat("HH:mm")
      .format(DateTime.now().add(const Duration(hours: 3)))
      .toString();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  bool isDone = false;
  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      setState(() {
        titleController.text = widget.taskModels!.title;
        descController.text = widget.taskModels!.desc;
        _selectedDate = widget.taskModels!.taskDate;
        _startTime = widget.taskModels!.startTask;
        _endTime = widget.taskModels!.endTask;
        selectedColorLevelPriority = Color(widget.taskModels!.colorBox);
        selectedColorLevelText = widget.taskModels!.levelPriority;
        currentColorIndex =
            ((Utils.numberOfPriority(selectedColorLevelText!) - 4) * -1);
      });
    } else {
      _selectedDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          !widget.isEdit ? 'Add Task' : 'Edit Task',
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
                  titleText: 'Start Time',
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
                  titleText: 'End Time',
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
              height: 12,
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
                    Utils.showSnackbar(
                      context,
                      'You choose task level ${levelPriorityText[index]}!',
                    );
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
                              width: 10.0,
                            )
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
            if (Utils.numberOfPriority(selectedColorLevelText!) == 3 ||
                Utils.numberOfPriority(selectedColorLevelText!) == 2) ...[
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton<dynamic>(
                  isExpanded: true,
                  underline: const SizedBox.shrink(),
                  value: selectedPriorityNotifLevel,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: priorityNotifLevel.map((notifLevel) {
                    return DropdownMenuItem(
                      value: notifLevel,
                      child: Text(
                        notifLevel,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPriorityNotifLevel = value;
                    });
                  },
                ),
              ),
            ],
            if (widget.isEdit) ...[
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
                          isDone = !isDone;
                        });
                      }),
                ],
              ),
            ],
            const Spacer(),
            if (selectedColorLevelText != null &&
                Utils.numberOfPriority(selectedColorLevelText!) == 4) ...[
              Row(
                children: [
                  const Expanded(
                    child: Icon(
                      Icons.warning_amber_rounded,
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      'You will be reminded every hour if you choose High Priority level',
                      style: regularStyle.copyWith(fontSize: 11),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
            ],
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: titleController.text.isNotEmpty &&
                          descController.text.isNotEmpty &&
                          selectedColorLevelPriority != null
                      ? () async {
                          !widget.isEdit
                              ? _addAction()
                              : _editAction(flutterLocalNotificationsPlugin);
                        }
                      : null,
                  child: Text(
                    !widget.isEdit ? 'Add Task' : 'Edit Task',
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
      idNotification: Utils.idNotifGenerator(title),
      id: docTodo.id,
      numOfPriority: Utils.numberOfPriority(levelPriority),
      title: title,
      desc: desc,
      taskDate: taskDate,
      startTask: startTime,
      endTask: endTime,
      isDone: false,
      colorBox: colorBox,
      levelPriority: selectedColorLevelText!,
      dateTime: Utils.formattedDateDisplayed(taskDate),
    );

    final json = task.toJson();

    await docTodo.set(json);
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    if (mounted) {
      String formatedTime = pickedTime?.format(context) ?? '10:00 AM';
      if (pickedTime == null) {
      } else if (isStartTime == true) {
        setState(() {
          _startTime = formatedTime;
        });
      } else if (isStartTime == false) {
        setState(() {
          _endTime = formatedTime;
        });
      }
    }
  }

  Future<TimeOfDay?> _showTimePicker() async {
    final TimeOfDay? result = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );

    if (result != null) {
      return TimeOfDay(
        hour: result.hourOfPeriod,
        minute: result.minute,
      );
    }

    return null;
  }

  void _addAction() async {
    final title = titleController.text;
    final desc = descController.text;
    final selectedDate = _selectedDate;
    final startTime = _startTime;
    final endTime = _endTime;
    final colorBox = selectedColorLevelPriority;

    Utils.idNotifGenerator(title);

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
    sendNotification('Hi, your task "$title" is already set up!',
        'We keep reminds you every day until its done!😁');
    if (Utils.numberOfPriority(selectedColorLevelText!) == 4) {
      sendNotificationPeriodically(
        id: Utils.idNotifGenerator(title),
        title: 'Hello, did your already finish your $title task?',
        body: 'Dont worry, we just remind you there is a task to do! 😊',
        interval: RepeatInterval.hourly,
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task Successfully added!')));
  }

  void _editAction(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    final title = titleController.text.isNotEmpty
        ? titleController.text
        : widget.taskModels!.title;
    final desc = descController.text.isNotEmpty
        ? descController.text
        : widget.taskModels!.desc;
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
      debugPrint(e.toString());
    }

    if (isDone == true) {
      cancelNotification(widget.taskModels!.idNotification);
    }

    titleController.clear();
    descController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task Successfully edited!')));
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
    final editedTask = TaskModel(
        idNotification: widget.taskModels!.idNotification,
        numOfPriority: Utils.numberOfPriority(widget.taskModels!.levelPriority),
        dateTime: Utils.formattedDateDisplayed(taskDate),
        levelPriority: widget.taskModels!.levelPriority,
        colorBox: widget.taskModels!.colorBox,
        id: snapshots.docs[widget.index!].id,
        title: title,
        desc: desc,
        taskDate: taskDate,
        startTask: startTime,
        endTask: endTime,
        isDone: isDone);

    final json = editedTask.toJson();
    collection.doc(snapshots.docs[widget.index!].id).set(json);
  }

  Future _getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (pickerDate != null) {
      setState(() {
        _selectedDate = pickerDate;
      });
    } else {}
  }
}
