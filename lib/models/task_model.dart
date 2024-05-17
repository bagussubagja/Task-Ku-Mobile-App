class TaskModel {
  String id;
  final String title;
  final String desc;
  final DateTime taskDate;
  final String startTask;
  final String endTask;
  final bool isDone;
  final int colorBox;

  TaskModel({
    this.id = '',
    required this.title,
    required this.desc,
    required this.taskDate,
    required this.startTask,
    required this.endTask,
    required this.isDone,
    required this.colorBox,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'desc': desc,
        'taskDate': taskDate,
        'startTask': startTask,
        'endTask': endTask,
        'isDone': isDone,
        'colorBox': colorBox,
      };

  static TaskModel fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'],
      desc: json['desc'],
      taskDate: json['taskDate'].toDate(),
      startTask: json['startTask'],
      endTask: json['endTask'],
      isDone: json['isDone'],
      colorBox: json['colorBox']
    );
  }
}
