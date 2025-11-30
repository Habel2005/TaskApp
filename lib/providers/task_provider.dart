import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/notification_service.dart';

enum SortBy {
  dueDate,
  priority,
}

class TaskProvider with ChangeNotifier {
  final NotificationService _notificationService = NotificationService();
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

  Priority? _filterPriority;
  SortBy _sortBy = SortBy.dueDate;

  Priority? get filterPriority => _filterPriority;
  SortBy get sortBy => _sortBy;

  List<Task> get tasks {
    List<Task> filteredTasks = _tasks;
    if (_filterPriority != null) {
      filteredTasks = _tasks.where((task) => task.priority == _filterPriority).toList();
    }

    filteredTasks.sort((a, b) {
      if (_sortBy == SortBy.dueDate) {
        return a.dueDate.compareTo(b.dueDate);
      } else {
        return a.priority.index.compareTo(b.priority.index);
      }
    });

    return filteredTasks;
  }

  void setFilter(Priority? priority) {
    _filterPriority = priority;
    notifyListeners();
  }

  void setSortBy(SortBy sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  void addTask(Task task) {
    _tasks.add(task);
    if (task.notificationTime != null) {
      final scheduledTime = DateTime(
        task.dueDate.year,
        task.dueDate.month,
        task.dueDate.day,
        task.notificationTime!.hour,
        task.notificationTime!.minute,
      );
      _notificationService.scheduleNotification(
          task.id.hashCode, task.title, 'Your task is due!', scheduledTime);
    }
    notifyListeners();
  }

  void addTasks(List<Task> tasks) {
    _tasks.addAll(tasks);
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

  void toggleTaskStatus(String taskId) {
    final task = _tasks.firstWhere((task) => task.id == taskId);
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((t) => t.id == taskId);
    notifyListeners();
  }

  void deleteTasks(List<String> taskIds) {
    _tasks.removeWhere((task) => taskIds.contains(task.id));
    notifyListeners();
  }
}
