import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../widgets/task_list.dart';

class CompletedTasksPage extends StatelessWidget {
  const CompletedTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final completedTasks = taskProvider.tasks.where((task) => task.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
      ),
      body: TaskList(
        tasks: completedTasks,
        selectedTasks: const {},
        onTaskSelected: (taskId) {},
      ),
    );
  }
}
