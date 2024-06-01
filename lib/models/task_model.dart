import 'package:test_drive/enums/task_status_enum.dart';
import 'package:test_drive/models/user_model.dart';
import 'package:test_drive/models/task_history_model.dart';

class Task {
  final int createdUserId;
  final int assignedUserId;
  final TaskStatus taskStatus;
  final int id;
  final int? updatedUserId;
  User? createdUser;
  final User? assignedUser;
  final User? updatedUser;
  final String title;
  final String summary;
  final DateTime createdAt;
  final DateTime? updatedAt;
  List<TaskHistory>? oldActionList;
  Task({
    required this.assignedUserId,
    required this.createdUserId,
    required this.taskStatus,
    required this.updatedUserId,
    required this.title,
    required this.id,
    required this.summary,
    required this.createdAt,
    this.updatedAt,
    this.createdUser,
    this.updatedUser,
    this.assignedUser,
    this.oldActionList,
  });

  Task copyWith({
    int? createdUserId,
    int? assignedUserId,
    TaskStatus? taskStatus,
    int? id,
    int? updatedUserId,
    User? createdUser,
    User? assignedUser,
    User? updatedUser,
    String? title,
    String? summary,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<TaskHistory>? oldActionList,
  }) {
    return Task(
      createdUserId: createdUserId ?? this.createdUserId,
      assignedUserId: assignedUserId ?? this.assignedUserId,
      taskStatus: taskStatus ?? this.taskStatus,
      id: id ?? this.id,
      updatedUserId: updatedUserId ?? this.updatedUserId,
      createdUser: createdUser ?? this.createdUser,
      assignedUser: assignedUser ?? this.assignedUser,
      updatedUser: updatedUser ?? this.updatedUser,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      oldActionList: oldActionList ?? this.oldActionList,
    );
  }

  // fromMap factory constructor
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      createdUserId: map['createdUserId'],
      assignedUserId: map['assignedUserId'],
      taskStatus: TaskStatusExtension.fromString(map['taskStatus']),
      id: map['id'],
      updatedUserId: map['updatedUserId'],
      title: map['title'],
      summary: map['summary'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
      createdUser:
          map['createdUser'] != null ? User.fromMap(map['createdUser']) : null,
      assignedUser: map['assignedUser'] != null
          ? User.fromMap(map['assignedUser'])
          : null,
      updatedUser:
          map['updatedUser'] != null ? User.fromMap(map['updatedUser']) : null,
      oldActionList: map['oldActionList'] != null
          ? List<TaskHistory>.from(
              map['oldActionList'].map((item) => TaskHistory.fromMap(item)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdUserId': createdUserId,
      'assignedUserId': assignedUserId,
      'taskStatus': taskStatus.toString(), // Enum'in string değerini alır
      'id': id,
      'updatedUserId': updatedUserId,
      'createdUser': createdUser?.toJson(), // User nesnesini JSON'a dönüştürür
      'assignedUser':
          assignedUser?.toJson(), // User nesnesini JSON'a dönüştürür
      'updatedUser': updatedUser?.toJson(), // User nesnesini JSON'a dönüştürür
      'title': title,
      'summary': summary,
      'createdAt': createdAt
          .toIso8601String(), // DateTime'i ISO 8601 biçimine dönüştürür
      'updatedAt': updatedAt!
          .toIso8601String(), // DateTime'i ISO 8601 biçimine dönüştürür
      'oldActionList': oldActionList
          ?.map((history) => history.toJson())
          .toList(), // TaskHistory listesini JSON'a dönüştürür
    };
  }
}
