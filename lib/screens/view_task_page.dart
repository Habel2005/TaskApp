import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';

class ViewTaskPage extends StatelessWidget {
  final Task task;

  const ViewTaskPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final Color priorityColor;
    switch (task.priority) {
      case Priority.high:
        priorityColor = Colors.red;
        break;
      case Priority.medium:
        priorityColor = Colors.orange;
        break;
      case Priority.low:
        priorityColor = Colors.green;
        break;
    }

    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor: _getBackgroundColor(task.id, isLightTheme),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                task.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                color: _getBackgroundColor(task.id, isLightTheme)
                    .withAlpha((255 * 0.8).round()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                    icon: FontAwesomeIcons.solidCalendar,
                    label: 'Due Date',
                    value: DateFormat.yMMMd().format(task.dueDate),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    icon: FontAwesomeIcons.solidFlag,
                    label: 'Priority',
                    value: task.priority.toString().split('.').last,
                    valueColor: priorityColor,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    icon: task.isCompleted
                        ? FontAwesomeIcons.solidSquareCheck
                        : FontAwesomeIcons.square,
                    label: 'Status',
                    value: task.isCompleted ? 'Completed' : 'Pending',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        FaIcon(icon, size: 20),
        const SizedBox(width: 16),
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Color _getBackgroundColor(String taskId, bool isLightTheme) {
    final hash = taskId.hashCode;
    final r = (hash & 0xFF0000) >> 16;
    final g = (hash & 0x00FF00) >> 8;
    final b = hash & 0x0000FF;
    if (isLightTheme) {
      return Color.fromARGB(255, (r + 255) ~/ 2, (g + 255) ~/ 2, (b + 255) ~/ 2)
          .withAlpha((255 * 0.5).round());
    } else {
      return Color.fromARGB(255, r, g, b).withAlpha((255 * 0.2).round());
    }
  }
}
