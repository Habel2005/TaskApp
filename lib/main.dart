
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/task_provider.dart';
import 'screens/task_list_screen.dart';
import 'theme/my_theme.dart'; // Import the custom theme

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        title: 'Task Manager',
        theme: MyTheme.lightTheme, // Apply the custom light theme
        home: const TaskListScreen(),
        debugShowCheckedModeBanner: false, // Hide the debug banner
      ),
    );
  }
}
