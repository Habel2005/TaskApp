import 'package:flutter/material.dart';

import '../models/task.dart';
import 'task_list_item.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Set<String> selectedTasks;
  final ValueChanged<String> onTaskSelected;

  const TaskList({
    super.key,
    required this.tasks,
    required this.selectedTasks,
    required this.onTaskSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskListItem(
          task: task,
          isSelected: selectedTasks.contains(task.id),
          onSelected: () => onTaskSelected(task.id),
        );
      },
    );
  }
}
