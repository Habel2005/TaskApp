import 'package:flutter/material.dart';

enum Priority { high, medium, low }

class Task {
  String id;
  String title;
  DateTime dueDate;
  TimeOfDay? notificationTime;
  Priority priority;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.dueDate,
    this.notificationTime,
    this.priority = Priority.medium,
    this.isCompleted = false,
  });

  bool get isDone => isCompleted;
}
