enum TaskStatus {
  pending,
  inProgress,
  completed,
  backlog,
}

extension TaskStatusExtension on TaskStatus {
  static TaskStatus fromString(String status) {
    switch (status) {
      case 'pending':
        return TaskStatus.pending;
      case 'inProgress':
        return TaskStatus.inProgress;
      case 'completed':
        return TaskStatus.completed;
      case 'backlog':
        return TaskStatus.backlog;
      default:
        throw Exception('Invalid TaskStatus: $status');
    }
  }
}
