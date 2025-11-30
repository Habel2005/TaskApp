# Task-it: A Flutter-based Task Management App

## Overview

Task-it is a feature-rich, cross-platform task management application built with Flutter. It helps users organize their daily tasks, set priorities, and receive timely reminders. The app boasts a clean, modern, and intuitive user interface that is easy to navigate and visually appealing.

## Key Features

*   **Task Management:** Create, edit, and delete tasks with ease. Each task has a title, due date, priority, and completion status.
*   **Search and Filter:** Quickly find tasks using the search bar or filter them by priority.
*   **Sort:** Organize tasks by due date or priority.
*   **Calendar View:** Visualize tasks in a calendar to get a clear overview of your schedule.
*   **Reminders:** Set reminders for tasks and receive notifications to stay on track.
*   **Theme:** Customize the app's appearance with light and dark themes.
*   **Sleek UI:** Enjoy a modern and intuitive user interface with smooth animations and a visually balanced layout.

## Project Structure

```
lib
├── main.dart
├── models
│   └── task.dart
├── providers
│   ├── task_provider.dart
│   └── theme_provider.dart
├── screens
│   ├── add_task_page.dart
│   ├── calendar_page.dart
│   ├── completed_tasks_page.dart
│   ├── edit_task_page.dart
│   ├── home_page.dart
│   └── settings_page.dart
├── services
│   └── notification_service.dart
├── theme
│   └── theme.dart
└── widgets
    ├── task_list.dart
    └── task_list_item.dart
```

## Screens

*   **`HomePage`:** The main screen of the app, displaying the task list, search and filter options, and navigation to other screens.
*   **`AddTaskPage`:** A screen for adding new tasks.
*   **`EditTaskPage`:** A screen for editing existing tasks.
*   **`CompletedTasksPage`:** A screen that displays a list of completed tasks.
*   **`CalendarPage`:** A screen that displays tasks in a calendar view.
*   **`SettingsPage`:** A screen for managing app settings, such as the theme.

## Providers

*   **`TaskProvider`:** Manages the state of the tasks, including adding, deleting, and updating tasks.
*   **`ThemeProvider`:** Manages the theme of the app, allowing the user to switch between light and dark modes.

## Services

*   **`NotificationService`:** Handles sending local notifications for task reminders.

## Models

*   **`Task`:** A data class that represents a single task, containing its ID, title, due date, priority, and completion status.

## Widgets

*   **`TaskList`:** A widget that displays a list of tasks.
*   **`TaskListItem`:** A widget that represents a single item in the task list.

## Theme

*   **`theme.dart`:** Defines the light and dark themes for the app.

## Dependencies

*   **`provider`:** For state management.
*   **`google_fonts`:** For custom fonts.
*   **`intl`:** For date and time formatting.
*   **`flutter_slidable`:** For adding swipe actions to the task list items.
*   **`table_calendar`:** For the calendar view.
*   **`flutter_local_notifications`:** For sending local notifications.
*   **`timezone`:** For handling time zones.

### Current Plan

*   Refactor the `HomePage` to improve readability and maintainability.

