import 'package:flutter/material.dart';
import 'package:test_drive/enums/task_status_enum.dart';

class TaskStatusIcon extends StatelessWidget {
  final TaskStatus status;

  TaskStatusIcon(this.status);

  @override
  Widget build(BuildContext context) {
    return _buildTaskStatusIcon(status);
  }

  Icon _buildTaskStatusIcon(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return Icon(Icons.pending);
      case TaskStatus.inProgress:
        return Icon(Icons.hourglass_bottom);
      case TaskStatus.completed:
        return Icon(Icons.done);
      case TaskStatus.backlog:
        return Icon(Icons.block);
      default:
        return Icon(Icons.error);
    }
  }
}
