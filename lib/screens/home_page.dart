import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import '../widgets/task_list.dart';
import 'add_task_page.dart';
import 'calendar_page.dart';
import 'completed_tasks_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Set<String> _selectedTasks = {};
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks.where((task) {
      return task.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: _HomePageAppBar(
        selectedTasks: _selectedTasks,
        onDelete: () {
          final deletedTasks = taskProvider.tasks
              .where((task) => _selectedTasks.contains(task.id))
              .toList();
          taskProvider.deleteTasks(_selectedTasks.toList());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${deletedTasks.length} tasks deleted'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  taskProvider.addTasks(deletedTasks);
                },
              ),
            ),
          );
          setState(() {
            _selectedTasks.clear();
          });
        },
      ),
      body: Column(
        children: [
          _SearchAndFilter(
            onSearchChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          Expanded(
            child: TaskList(
              tasks: tasks,
              selectedTasks: _selectedTasks,
              onTaskSelected: (taskId) {
                setState(() {
                  if (_selectedTasks.contains(taskId)) {
                    _selectedTasks.remove(taskId);
                  } else {
                    _selectedTasks.add(taskId);
                  }
                });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddTaskPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomePageAppBar({
    required this.selectedTasks,
    required this.onDelete,
  });

  final Set<String> selectedTasks;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(selectedTasks.isEmpty
          ? 'Task-it'
          : '${selectedTasks.length} selected'),
      actions: [
        if (selectedTasks.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CalendarPage(),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.done),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CompletedTasksPage(),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAndFilter extends StatelessWidget {
  const _SearchAndFilter({
    required this.onSearchChanged,
  });

  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: onSearchChanged,
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<Priority?>(
                  initialValue: taskProvider.filterPriority,
                  decoration: const InputDecoration(labelText: 'Filter by Priority'),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('All'),
                    ),
                    ...Priority.values.map((priority) {
                      return DropdownMenuItem(
                        value: priority,
                        child: Text(priority.toString().split('.').last),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    taskProvider.setFilter(value);
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: DropdownButtonFormField<SortBy>(
                  initialValue: taskProvider.sortBy,
                  decoration: const InputDecoration(labelText: 'Sort by'),
                  items: SortBy.values.map((sortBy) {
                    return DropdownMenuItem(
                      value: sortBy,
                      child: Text(sortBy.toString().split('.').last),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      taskProvider.setSortBy(value);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
