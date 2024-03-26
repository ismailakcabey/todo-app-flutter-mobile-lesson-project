import 'package:test_drive/models/user_model.dart';

class TaskHistory {
  final String id;
  final String creadUserId;
  final User? createdUser;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String description;

  TaskHistory(
      {required this.id,
      required this.creadUserId,
      this.createdUser,
      required this.createdAt,
      required this.updatedAt,
      required this.description});
}
