import 'package:flutter/material.dart';
import 'package:test_drive/enums/task_status_enum.dart';

class TaskStatusText extends StatelessWidget {
  final TaskStatus status;
  final TextAlign textAlign;
  final TextStyle textStyle;
  final Color textColor;

  TaskStatusText({
    required this.status,
    this.textAlign = TextAlign.start,
    this.textStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    this.textColor = Colors.black54,
  });

  @override
  Widget build(BuildContext context) {
    return _buildTaskStatusText();
  }

  Text _buildTaskStatusText() {
    String text;
    switch (status) {
      case TaskStatus.pending:
        text = "Pending";
        break;
      case TaskStatus.inProgress:
        text = "In progress";
        break;
      case TaskStatus.completed:
        text = "Completed";
        break;
      case TaskStatus.backlog:
        text = "Backlog";
        break;
      default:
        text = "Unknown status";
        break;
    }
    return Text(
      text,
      textAlign: textAlign,
      style: textStyle.copyWith(color: textColor),
    );
  }
}
