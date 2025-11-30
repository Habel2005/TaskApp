import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import 'edit_task_page.dart';

class ViewTaskPage extends StatelessWidget {
  final Task task;

  const ViewTaskPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final Color priorityColor;
    switch (task.priority) {
      case Priority.high:
        priorityColor = Colors.red.shade400;
        break;
      case Priority.medium:
        priorityColor = Colors.orange.shade400;
        break;
      case Priority.low:
        priorityColor = Colors.green.shade400;
        break;
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                task.title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Hero(
                tag: task.id,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        priorityColor.withOpacity(0.8),
                        priorityColor.withOpacity(0.4),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit, size: 28),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditTaskPage(task: task),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 28),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Task'),
                      content: const Text(
                          'Are you sure you want to delete this task?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Provider.of<TaskProvider>(context, listen: false)
                                .deleteTask(task.id);
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(
                    icon: FontAwesomeIcons.solidCalendar,
                    label: 'Due Date',
                    value: DateFormat.yMMMEd().add_jm().format(task.dueDate),
                    context: context,
                  ),
                  const SizedBox(height: 24),
                  _buildInfoCard(
                    icon: FontAwesomeIcons.solidFlag,
                    label: 'Priority',
                    value: task.priority.toString().split('.').last,
                    valueColor: priorityColor,
                    context: context,
                  ),
                  const SizedBox(height: 24),
                  _buildInfoCard(
                    icon: task.isCompleted
                        ? FontAwesomeIcons.solidSquareCheck
                        : FontAwesomeIcons.square,
                    label: 'Status',
                    value: task.isCompleted ? 'Completed' : 'Pending',
                    context: context,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          FaIcon(icon, size: 24, color: Theme.of(context).primaryColor),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: valueColor ?? Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
