import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import '../widgets/task_list_item.dart';
import 'add_task_page.dart';
import 'completed_tasks_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String _searchQuery = '';
  Priority? _selectedPriority;
  bool _isSelectionMode = false;
  final Set<String> _selectedTasks = {};

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks.where((task) => !task.isCompleted).toList();

    return Scaffold(
      appBar: _isSelectionMode ? _buildSelectionAppBar() : _buildDefaultAppBar(),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.twoWeeks,
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
                  .where((task) => isSameDay(task.dueDate, day))
                  .toList();
            },
          ),
          const SizedBox(height: 8.0),
          _buildSearchBar(),
          Expanded(
            child: _buildTaskList(tasks),
          ),
        ],
      ),
      floatingActionButton: _isSelectionMode
          ? null
          : FloatingActionButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AddTaskPage()),
              ),
              child: const Icon(Icons.add),
            ),
    );
  }

  AppBar _buildDefaultAppBar() {
    return AppBar(
      title: Text(
        'Task-it',
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.check_circle_outline),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const CompletedTasksPage()),
          ),
        ),
        PopupMenuButton<Priority>(
          onSelected: (priority) {
            setState(() {
              _selectedPriority = priority;
            });
          },
          itemBuilder: (context) => Priority.values
              .map((priority) => PopupMenuItem(
                    value: priority,
                    child: Text(priority.toString().split('.').last),
                  ))
              .toList(),
          icon: const Icon(Icons.filter_list),
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const SettingsPage()),
          ),
        ),
      ],
    );
  }

  AppBar _buildSelectionAppBar() {
    return AppBar(
      title: Text('${_selectedTasks.length} selected'),
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          setState(() {
            _isSelectionMode = false;
            _selectedTasks.clear();
          });
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            final taskProvider = Provider.of<TaskProvider>(context, listen: false);
            for (final taskId in _selectedTasks) {
              taskProvider.deleteTask(taskId);
            }
            setState(() {
              _isSelectionMode = false;
              _selectedTasks.clear();
            });
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskList(List<Task> tasks) {
    List<Task> filteredTasks = tasks;

    if (_searchQuery.isNotEmpty) {
      filteredTasks = filteredTasks
          .where((task) =>
              task.title.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    if (_selectedPriority != null) {
      filteredTasks = filteredTasks
          .where((task) => task.priority == _selectedPriority)
          .toList();
    }

    final selectedTasks = _selectedDay == null
        ? filteredTasks
        : filteredTasks
            .where((task) => isSameDay(task.dueDate, _selectedDay!))
            .toList();

    if (selectedTasks.isEmpty) {
      return const Center(
        child: Text('No tasks for this day.'),
      );
    }

    return ListView.builder(
      itemCount: selectedTasks.length,
      itemBuilder: (context, index) {
        final task = selectedTasks[index];
        return TaskListItem(
          task: task,
          isSelected: _selectedTasks.contains(task.id),
          isSelectionMode: _isSelectionMode,
          onSelected: () {
            setState(() {
              if (_isSelectionMode) {
                if (_selectedTasks.contains(task.id)) {
                  _selectedTasks.remove(task.id);
                } else {
                  _selectedTasks.add(task.id);
                }
                if (_selectedTasks.isEmpty) {
                  _isSelectionMode = false;
                }
              } else {
                _isSelectionMode = true;
                _selectedTasks.add(task.id);
              }
            });
          },
        );
      },
    );
  }
}
