
enum Priority { high, medium, low }

class Task {
  String id;
  String title;
  DateTime dueDate;
  Priority priority;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.dueDate,
    this.priority = Priority.medium,
    this.isCompleted = false,
  });
}