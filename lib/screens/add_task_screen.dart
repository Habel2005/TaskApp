
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;

  const AddTaskScreen({super.key, this.task});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late DateTime _dueDate;
  late Priority _priority;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _title = widget.task!.title;
      _dueDate = widget.task!.dueDate;
      _priority = widget.task!.priority;
    } else {
      _title = '';
      _dueDate = DateTime.now();
      _priority = Priority.medium;
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      if (widget.task == null) {
        taskProvider.addTask(
          Task(
            id: DateTime.now().toString(),
            title: _title,
            dueDate: _dueDate,
            priority: _priority,
          ),
        );
      } else {
        taskProvider.updateTask(
          Task(
            id: widget.task!.id,
            title: _title,
            dueDate: _dueDate,
            priority: _priority,
            isCompleted: widget.task!.isCompleted,
          ),
        );
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add New Task' : 'Edit Task', style: textTheme.headlineSmall),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(
                  labelText: 'Task Title',
                  hintText: 'e.g., Buy groceries',
                  labelStyle: textTheme.bodyMedium,
                  prefixIcon: Icon(Icons.task_alt_outlined, color: colorScheme.primary),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              const SizedBox(height: 24),
              Text('Due Date', style: textTheme.titleSmall!.copyWith(color: colorScheme.onSurface)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _dueDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: colorScheme.primary, // header background color
                            onPrimary: colorScheme.onPrimary, // header text color
                            onSurface: colorScheme.onSurface, // body text color
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: colorScheme.primary, // button text color
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedDate != null && pickedDate != _dueDate) {
                    setState(() {
                      _dueDate = pickedDate;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colorScheme.outline),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: colorScheme.primary),
                      const SizedBox(width: 12),
                      Text(
                        DateFormat.yMMMd().format(_dueDate),
                        style: textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      Icon(Icons.arrow_drop_down, color: colorScheme.onSurface),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text('Priority', style: textTheme.titleSmall!.copyWith(color: colorScheme.onSurface)),
              const SizedBox(height: 8),
              DropdownButtonFormField<Priority>(
                initialValue: _priority,
                decoration: InputDecoration(
                  labelText: 'Task Priority',
                  labelStyle: textTheme.bodyMedium,
                  prefixIcon: Icon(Icons.priority_high_rounded, color: colorScheme.primary),
                ),
                items: Priority.values.map((Priority priority) {
                  return DropdownMenuItem<Priority>(
                    value: priority,
                    child: Text(priority.toString().split('.').last, style: textTheme.bodyMedium),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _priority = value!;
                  });
                },
                onSaved: (value) => _priority = value!,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Text(widget.task == null ? 'Add Task' : 'Update Task'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
