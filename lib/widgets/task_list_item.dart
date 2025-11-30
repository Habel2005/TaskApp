import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import '../screens/edit_task_page.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final bool isSelected;
  final VoidCallback onSelected;

  const TaskListItem({
    super.key,
    required this.task,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      child: ListTile(
        onTap: onSelected,
        selected: isSelected,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        leading: Checkbox(
          value: isSelected,
          onChanged: (value) => onSelected(),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Due: ${DateFormat.yMd().format(task.dueDate)}'),
            if (task.notificationTime != null)
              Text(
                  'Reminder: ${task.notificationTime!.format(context)}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditTaskPage(task: task),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                taskProvider.deleteTask(task.id);
              },
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
