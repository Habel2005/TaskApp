import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import '../screens/add_task_screen.dart';

class TaskListItem extends StatelessWidget {
  final Task task;

  const TaskListItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: Theme.of(
        context,
      ).cardTheme.elevation, // Apply card theme elevation
      shape: Theme.of(context).cardTheme.shape, // Apply card theme shape
      margin: Theme.of(context).cardTheme.margin, // Apply card theme margin
      child: Slidable(
        key: Key(task.id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                taskProvider.deleteTask(task.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Task \'${task.title}\' deleted')),
                );
              },
              backgroundColor: colorScheme.error, // Use theme error color
              foregroundColor: colorScheme.onError,
              icon: Icons.delete_rounded,
              label: 'Delete',
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0),
                bottomLeft: Radius.circular(0),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            SlidableAction(
              onPressed: (context) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTaskScreen(task: task),
                    fullscreenDialog: true,
                  ),
                );
              },
              backgroundColor: colorScheme
                  .primaryContainer, // Use theme primaryContainer color
              foregroundColor: colorScheme.onPrimaryContainer,
              icon: Icons.edit_rounded,
              label: 'Edit',
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: task.isCompleted
                ? colorScheme.tertiary.withOpacity(0.1)
                : colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: CheckboxListTile(
            title: Text(
              task.title,
              style: textTheme.titleMedium!.copyWith(
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
                color: task.isCompleted
                    ? colorScheme.onSurfaceVariant
                    : colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(task.dueDate),
              style: textTheme.bodySmall!.copyWith(
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
                color: task.isCompleted
                    ? colorScheme.onSurfaceVariant
                    : colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            value: task.isCompleted,
            onChanged: (value) {
              taskProvider.toggleTaskCompletion(task.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Task \'${task.title}\' ${value! ? 'completed' : 'uncompleted'}',
                  ),
                ),
              );
            },
            secondary: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getPriorityColor(task.priority, colorScheme),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  _getPriorityText(task.priority),
                  style: textTheme.labelLarge!.copyWith(color: Colors.white),
                ),
              ),
            ),
            activeColor: colorScheme
                .tertiary, // Use theme tertiary color for active checkbox
            checkColor: colorScheme.onTertiary,
          ),
        ),
      ),
    );
  }

  Color _getPriorityColor(Priority priority, ColorScheme colorScheme) {
    switch (priority) {
      case Priority.high:
        return colorScheme.error; // Red accent
      case Priority.medium:
        return colorScheme.secondary; // Orange accent
      case Priority.low:
        return colorScheme.tertiary; // Green accent
    }
  }

  String _getPriorityText(Priority priority) {
    switch (priority) {
      case Priority.high:
        return 'H';
      case Priority.medium:
        return 'M';
      case Priority.low:
        return 'L';
    }
  }
}
