class TaskModel {
  String id;
  final String title;
  final String desc;
  final DateTime taskDate;
  final String startTask;
  final String endTask;

  TaskModel({
    this.id = '',
    required this.title,
    required this.desc,
    required this.taskDate,
    required this.startTask,
    required this.endTask,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'desc': desc,
        'taskDate': taskDate,
        'startTask': startTask,
        'endTask': endTask,
      };

  static TaskModel fromJson(Map<String, dynamic> json) {
    return TaskModel(
        title: json['title'],
        desc: json['desc'],
        taskDate: json['taskDate'].toDate(),
        startTask: json['startTask'],
        endTask: json['endTask']);
  }
}
