import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';
import 'package:task_ku_mobile_app/widgets/input_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String? _endTime;
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
          padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            children: [
              InputField(
                titleText: 'Title',
                hintText: 'Enter your title...',
                controller: titleController,
              ),
              SizedBox(
                height: 10,
              ),
              InputField(
                titleText: 'Description',
                hintText: 'Enter your description...',
                controller: descController,
              ),
              SizedBox(
                height: 10,
              ),
              InputField(
                titleText: 'Task Date',
                hintText: DateFormat.yMd().format(_selectedDate),
                controller: titleController,
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
                    onPressed: () {},
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

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime?.format(context) ?? '';
    if (pickedTime == null) {
      print('Time is NULL');
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
        print(_selectedDate);
      });
    } else {
      print('something wrong!');
    }
  }
}
