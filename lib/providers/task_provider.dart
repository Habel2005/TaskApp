import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Complete Flutter UI',
      dueDate: DateTime.now(),
      priority: Priority.high,
    ),
    Task(
      id: '2',
      title: 'Write documentation',
      dueDate: DateTime.now().add(const Duration(days: 1)),
      priority: Priority.medium,
    ),
    Task(
      id: '3',
      title: 'Test the app',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      isCompleted: true,
      priority: Priority.low,
    ),
  ];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
    }
  }

  void toggleTaskCompletion(String taskId) {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      notifyListeners();
    }
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((t) => t.id == taskId);
    notifyListeners();
  }
}
