import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  CalendarFormat _calendarFormat = CalendarFormat.week;
  bool _isSearching = false;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _resetFilters() {
    setState(() {
      _selectedDay = null;
      _searchQuery = '';
      _searchController.clear();
      _selectedPriority = null;
      _focusedDay = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks =
        taskProvider.tasks.where((task) => !task.isCompleted).toList();

    return Scaffold(
      appBar:
          _isSelectionMode ? _buildSelectionAppBar() : _buildDefaultAppBar(),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            headerStyle: const HeaderStyle(formatButtonVisible: false),
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
              child: const FaIcon(FontAwesomeIcons.plus),
            ),
    );
  }

  AppBar _buildDefaultAppBar() {
    if (_isSearching) {
      return AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () {
            setState(() {
              _isSearching = false;
              _searchQuery = '';
              _searchController.clear();
            });
          },
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: const InputDecoration(
            hintText: 'Search tasks...',
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.times),
            onPressed: () {
              setState(() {
                _searchQuery = '';
                _searchController.clear();
              });
            },
          ),
        ],
      );
    }

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
          icon: const FaIcon(FontAwesomeIcons.search),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
        ),
        PopupMenuButton<dynamic>(
          onSelected: (value) {
            if (value == 'clear_priority') {
              setState(() {
                _selectedPriority = null;
              });
            } else if (value is Priority) {
              setState(() {
                _selectedPriority = value;
              });
            }
          },
          itemBuilder: (context) => <PopupMenuEntry<dynamic>>[
            const PopupMenuItem<dynamic>(
              enabled: false,
              child: Text('Filter by Priority'),
            ),
            ...Priority.values.map((priority) {
              return PopupMenuItem<Priority>(
                value: priority,
                child: Text('  ${priority.toString().split('.').last}'),
              );
            }).toList(),
            if (_selectedPriority != null)
              PopupMenuItem<String>(
                value: 'clear_priority',
                child: const Text('  Clear Filter'),
              ),
          ],
          icon: const FaIcon(FontAwesomeIcons.filter),
        ),
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.cog),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const SettingsPage()),
          ),
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'toggle_calendar') {
              setState(() {
                _calendarFormat = _calendarFormat == CalendarFormat.week
                    ? CalendarFormat.month
                    : CalendarFormat.week;
              });
            } else if (value == 'reset_filters') {
              _resetFilters();
            } else if (value == 'completed_tasks') {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CompletedTasksPage()),
              );
            }
          },
          itemBuilder: (context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'toggle_calendar',
              child: ListTile(
                leading: FaIcon(
                  _calendarFormat == CalendarFormat.week
                      ? FontAwesomeIcons.calendarWeek
                      : FontAwesomeIcons.calendarDay,
                ),
                title: const Text('Change Calendar View'),
              ),
            ),
            PopupMenuItem<String>(
              value: 'completed_tasks',
              child: const ListTile(
                leading: FaIcon(FontAwesomeIcons.checkCircle),
                title: Text('Completed Tasks'),
              ),
            ),
            PopupMenuItem<String>(
              value: 'reset_filters',
              child: const ListTile(
                leading: FaIcon(FontAwesomeIcons.arrowsRotate),
                title: Text('Reset Filters'),
              ),
            ),
          ],
          icon: const FaIcon(FontAwesomeIcons.ellipsisV),
        ),
      ],
    );
  }

  AppBar _buildSelectionAppBar() {
    return AppBar(
      title: Text('${_selectedTasks.length} selected'),
      leading: IconButton(
        icon: const FaIcon(FontAwesomeIcons.times),
        onPressed: () {
          setState(() {
            _isSelectionMode = false;
            _selectedTasks.clear();
          });
        },
      ),
      actions: [
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.trash),
          onPressed: () {
            final taskProvider =
                Provider.of<TaskProvider>(context, listen: false);
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
