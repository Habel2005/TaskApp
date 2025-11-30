import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import '../services/notification_service.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  DateTime _dueDate = DateTime.now();
  TimeOfDay? _notificationTime;
  Priority _priority = Priority.medium;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _notificationTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _notificationTime = picked;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newTask = Task(
        id: DateTime.now().toString(),
        title: _title,
        dueDate: _dueDate,
        notificationTime: _notificationTime,
        priority: _priority,
      );
      Provider.of<TaskProvider>(context, listen: false).addTask(newTask);

      if (_notificationTime != null) {
        final notificationTime = DateTime(
          _dueDate.year,
          _dueDate.month,
          _dueDate.day,
          _notificationTime!.hour,
          _notificationTime!.minute,
        );
        NotificationService().scheduleNotification(
          newTask.id.hashCode,
          'Task Reminder',
          _title,
          notificationTime,
        );
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Due Date: ${DateFormat.yMd().format(_dueDate)}',
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Reminder Time: ${_notificationTime?.format(context) ?? 'Not set'}',
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectTime(context),
                    child: const Text('Select Time'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<Priority>(
                initialValue: _priority,
                decoration: const InputDecoration(labelText: 'Priority'),
                items: Priority.values.map((priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(priority.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _priority = value!;
                  });
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
