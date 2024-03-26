import 'package:flutter/material.dart';
import 'package:test_drive/enums/task_status_enum.dart';

class TaskStatusDropdown extends StatelessWidget {
  final TaskStatus selectedStatus;
  final ValueChanged<TaskStatus?> onChanged;

  TaskStatusDropdown({
    required this.selectedStatus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<TaskStatus>(
      value: selectedStatus,
      decoration: InputDecoration(
        labelText: 'Task Status',
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
      ),
      onChanged: onChanged,
      items: TaskStatus.values
          .map<DropdownMenuItem<TaskStatus>>((TaskStatus status) {
        return DropdownMenuItem<TaskStatus>(
          value: status,
          child: Text(status.toString().split('.').last),
        );
      }).toList(),
    );
  }
}
