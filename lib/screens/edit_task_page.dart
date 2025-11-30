import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;

  const EditTaskPage({super.key, required this.task});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late DateTime _dueDate;
  late Priority _priority;
  TimeOfDay? _notificationTime;

  @override
  void initState() {
    super.initState();
    _title = widget.task.title;
    _dueDate = widget.task.dueDate;
    _priority = widget.task.priority;
    _notificationTime = widget.task.notificationTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
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
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Due Date: ${DateFormat.yMd().format(_dueDate)}',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _dueDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _dueDate = pickedDate;
                        });
                      }
                    },
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
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
                  if (value != null) {
                    setState(() {
                      _priority = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Notification Time: ${_notificationTime != null ? _notificationTime!.format(context) : 'Not set'}',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: _notificationTime ?? TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          _notificationTime = pickedTime;
                        });
                      }
                    },
                    child: const Text('Select Time'),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final updatedTask = Task(
                      id: widget.task.id,
                      title: _title,
                      dueDate: _dueDate,
                      priority: _priority,
                      notificationTime: _notificationTime,
                      isCompleted: widget.task.isCompleted,
                    );
                    Provider.of<TaskProvider>(context, listen: false)
                        .updateTask(updatedTask);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
