import 'package:test_drive/enums/task_status_enum.dart';
import 'package:test_drive/models/user_model.dart';
import 'package:test_drive/models/task_history_model.dart';

class Task {
  final String createdUserId;
  final TaskStatus taskStatus;
  final String id;
  final String updatedUserId;
  final User? createdUser;
  final User? assignedUser;
  final User? updatedUser;
  final String title;
  final String summary;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<TaskHistory> oldActionList;
  Task({
    required this.createdUserId,
    required this.taskStatus,
    required this.updatedUserId,
    required this.title,
    required this.id,
    required this.summary,
    required this.createdAt,
    required this.updatedAt,
    this.createdUser,
    this.updatedUser,
    this.assignedUser,
    required this.oldActionList,
  });
}
