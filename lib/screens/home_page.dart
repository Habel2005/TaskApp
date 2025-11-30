import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import '../screens/add_task_page.dart';
import '../screens/completed_tasks_page.dart';
import '../screens/settings_page.dart';
import '../widgets/task_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';
  Priority? _filterPriority;
  SortBy _sortBy = SortBy.dueDate;
  List<String> _selectedTaskIds = [];

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.getFilteredAndSortedTasks(
      _searchQuery,
      _filterPriority,
      _sortBy,
    );
    final uncompletedTasks = tasks.where((task) => !task.isCompleted).toList();

    final bool isSelectionMode = _selectedTaskIds.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: isSelectionMode
            ? Text('${_selectedTaskIds.length} selected')
            : const Text('Task-it'),
        actions: isSelectionMode
            ? [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.trash),
                  onPressed: () {
                    for (final taskId in _selectedTaskIds) {
                      taskProvider.deleteTask(taskId);
                    }
                    setState(() {
                      _selectedTaskIds = [];
                    });
                  },
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.xmark),
                  onPressed: () {
                    setState(() {
                      _selectedTaskIds = [];
                    });
                  },
                ),
              ]
            : [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
                  onPressed: () {
                    showSearch(
                        context: context, delegate: TaskSearchDelegate());
                  },
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.solidSquareCheck),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CompletedTasksPage(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.gear),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
                  },
                ),
              ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildFilterChip(),
                const SizedBox(width: 8),
                _buildSortChip(),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: uncompletedTasks.length,
              itemBuilder: (context, index) {
                final task = uncompletedTasks[index];
                final isSelected = _selectedTaskIds.contains(task.id);
                return TaskListItem(
                  task: task,
                  isSelected: isSelected,
                  isSelectionMode: isSelectionMode,
                  onSelected: () {
                    setState(() {
                      if (isSelected) {
                        _selectedTaskIds.remove(task.id);
                      } else {
                        _selectedTaskIds.add(task.id);
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddTaskPage(),
            ),
          );
        },
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }

  Widget _buildFilterChip() {
    return PopupMenuButton<Priority?>(
      onSelected: (Priority? value) {
        setState(() {
          _filterPriority = value;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Priority?>>[
        const PopupMenuItem<Priority?>(
          value: null,
          child: Text('All Priorities'),
        ),
        ...Priority.values.map((priority) {
          return PopupMenuItem<Priority?>(
            value: priority,
            child: Text(priority.toString().split('.').last),
          );
        }),
      ],
      child: Chip(
        label: Text(_filterPriority?.toString().split('.').last ?? 'Filter'),
        avatar: const FaIcon(FontAwesomeIcons.filter),
      ),
    );
  }

  Widget _buildSortChip() {
    return PopupMenuButton<SortBy>(
      onSelected: (SortBy value) {
        setState(() {
          _sortBy = value;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SortBy>>[
        ...SortBy.values.map((sortBy) {
          return PopupMenuItem<SortBy>(
            value: sortBy,
            child: Text(sortBy.toString().split('.').last),
          );
        }),
      ],
      child: Chip(
        label: Text(_sortBy.toString().split('.').last),
        avatar: const FaIcon(FontAwesomeIcons.arrowDownWideShort),
      ),
    );
  }
}

class TaskSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const FaIcon(FontAwesomeIcons.xmark),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const FaIcon(FontAwesomeIcons.arrowLeft),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks =
        taskProvider.getFilteredAndSortedTasks(query, null, SortBy.dueDate);

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskListItem(
          task: task,
          isSelected: false,
          isSelectionMode: false,
          onSelected: () {},
        );
      },
    );
  }
}
