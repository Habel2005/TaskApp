import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';

enum SortBy {
  dueDate,
  priority,
}

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskProvider() {
    loadTasks();
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = prefs.getStringList('tasks') ?? [];
    _tasks = taskList.map((taskData) {
      final taskMap = json.decode(taskData) as Map<String, dynamic>;
      return Task(
        id: taskMap['id'],
        title: taskMap['title'],
        dueDate: DateTime.parse(taskMap['dueDate']),
        priority: Priority.values[taskMap['priority']],
        isCompleted: taskMap['isCompleted'],
      );
    }).toList();
    notifyListeners();
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = _tasks.map((task) {
      return json.encode({
        'id': task.id,
        'title': task.title,
        'dueDate': task.dueDate.toIso8601String(),
        'priority': task.priority.index,
        'isCompleted': task.isCompleted,
      });
    }).toList();
    await prefs.setStringList('tasks', taskList);
  }

  void addTask(Task task) {
    _tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void updateTask(Task task) {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      saveTasks();
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    saveTasks();
    notifyListeners();
  }

  void toggleTaskCompletion(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      final task = _tasks[index];
      _tasks[index] = task.copyWith(isCompleted: !task.isCompleted);
      saveTasks();
      notifyListeners();
    }
  }

  void toggleTaskCompletionInProvider(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      final task = _tasks[index];
      _tasks[index] = task.copyWith(isCompleted: !task.isCompleted);
      saveTasks();
      notifyListeners();
    }
  }

  List<Task> getFilteredAndSortedTasks(
    String searchQuery,
    Priority? filterPriority,
    SortBy sortBy,
  ) {
    List<Task> filteredTasks = _tasks.where((task) {
      final titleMatches =
          task.title.toLowerCase().contains(searchQuery.toLowerCase());
      final priorityMatches =
          filterPriority == null || task.priority == filterPriority;
      return titleMatches && priorityMatches;
    }).toList();

    filteredTasks.sort((a, b) {
      if (sortBy == SortBy.dueDate) {
        return a.dueDate.compareTo(b.dueDate);
      } else {
        return b.priority.index.compareTo(a.priority.index);
      }
    });

    return filteredTasks;
  }
}
