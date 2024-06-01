import 'package:test_drive/models/user_model.dart';

class TaskHistory {
  final int id;
  final int createdUserId;
  final int taskId;
  final User? createdUser;
  final DateTime createdAt;
  final String description;

  TaskHistory(
      {required this.id,
      required this.createdUserId,
      required this.taskId,
      this.createdUser,
      required this.createdAt,
      required this.description});
  // Map'den TaskHistory nesnesine dönüştürme metodu
  factory TaskHistory.fromMap(Map<String, dynamic> map) {
    return TaskHistory(
      id: map['id'],
      createdUserId: map['createdUserId'],
      taskId: map['taskId'],
      createdUser:
          map['createdUser'] != null ? User.fromMap(map['createdUser']) : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      description: map['description'],
    );
  }

  // JSON formatına dönüştürme metodu
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdUserId': createdUserId,
      'taskId': taskId,
      'createdUser': createdUser?.toJson(), // User nesnesini JSON'a dönüştürür
      'createdAt': createdAt
          .toIso8601String(), // DateTime'i ISO 8601 biçimine dönüştürür
      'description': description,
    };
  }
}
