import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: (day) {
              return tasks
                  .where((task) =>
                      task.dueDate.year == day.year &&
                      task.dueDate.month == day.month &&
                      task.dueDate.day == day.day)
                  .toList();
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: _buildTaskList(tasks),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList(List<Task> tasks) {
    final selectedTasks = _selectedDay == null
        ? <Task>[]
        : tasks
            .where((task) =>
                task.dueDate.year == _selectedDay!.year &&
                task.dueDate.month == _selectedDay!.month &&
                task.dueDate.day == _selectedDay!.day)
            .toList();

    if (selectedTasks.isEmpty) {
      return const Center(
        child: Text('No tasks for this day'),
      );
    }

    return ListView.builder(
      itemCount: selectedTasks.length,
      itemBuilder: (context, index) {
        final task = selectedTasks[index];
        return ListTile(
          title: Text(task.title),
          subtitle: Text(task.priority.toString().split('.').last),
          trailing: Checkbox(
            value: task.isCompleted,
            onChanged: (value) {
              Provider.of<TaskProvider>(context, listen: false)
                  .toggleTaskCompletion(task.id);
            },
          ),
        );
      },
    );
  }
}
