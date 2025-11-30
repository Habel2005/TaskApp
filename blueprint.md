'''
# Task Manager App Blueprint

## Overview

A streamlined task management app using Flutter to organize daily to-do lists. Key features include adding tasks with due dates, marking tasks as complete, viewing tasks by priority or due date, and quick editing options. The app uses a clean light mode theme with a modernistic UI and very slick design with color choices, providing a perfect and user-friendly experience with modern trendy UX.

## Features

*   **Add Tasks:** Users can add new tasks with a title, due date, and priority through a redesigned form with clear input fields and date picker.
*   **Edit Tasks:** Existing tasks can be easily edited via a dedicated screen, pre-populated with current task details.
*   **Delete Tasks:** Tasks can be deleted with a simple swipe-to-delete gesture, accompanied by a confirmation snackbar.
*   **Mark as Complete:** Tasks can be marked as complete using a checkbox, with a visual line-through effect on the title and a confirmation snackbar.
*   **Priority Levels:** Tasks can be assigned a priority level (High, Medium, or Low), visually represented by a color-coded circular avatar with the initial of the priority.
*   **Due Dates:** Each task has a due date, clearly displayed and easily editable via an integrated date picker.
*   **Modern UI/UX:** The app features a clean light mode theme with a modernistic and slick design. This includes:
    *   **Custom Color Scheme:** A vibrant yet professional color palette with a deep purple primary color and a teal accent.
    *   **Typography:** Utilizes `GoogleFonts.poppins` for headlines and `GoogleFonts.lato`/`GoogleFonts.openSans` for body text, ensuring readability and a modern aesthetic.
    *   **Elevated Components:** Buttons, cards, and floating action buttons feature multi-layered drop shadows and elegant color glows to create a strong sense of depth and interactivity.
    *   **Input Fields:** Cleanly designed input fields with subtle fill colors and focused border highlighting.
    *   **Task Cards:** Each task is presented within an elevated card, providing visual separation and a lifted appearance.
    *   **Empty State:** A user-friendly message and icon are displayed when there are no tasks, guiding the user to add new ones.
    *   **Snackbars:** Informative snackbars provide feedback for actions like task deletion or completion.

## Project Structure

```
lib
├── models
│   └── task.dart
├── providers
│   └── task_provider.dart
├── screens
│   ├── add_task_screen.dart
│   └── task_list_screen.dart
├── theme
│   └── my_theme.dart
└── widgets
    ├── empty_tasks.dart
    └── task_list_item.dart
```

## Dependencies

*   `provider`: For state management.
*   `google_fonts`: For custom fonts and typography.
*   `flutter_slidable`: For the swipeable task list items (delete and edit).
*   `intl`: For date formatting.

## Current Plan: UI/UX Refinement

**Goal:** Implement a clean light mode theme with modernistic UI and very slick design with color choices, ensuring a perfect UI with user-friendliness and modern trendy UX.

**Steps:**
1.  **Create `lib/theme/my_theme.dart`:** Define a custom `ThemeData` for the light mode, incorporating `ColorScheme.fromSeed`, `GoogleFonts` for `TextTheme`, and custom `AppBarTheme`, `ElevatedButtonTheme`, `FloatingActionButtonTheme`, `InputDecorationTheme`, and `CardTheme` for a consistent and modern look.
2.  **Update `lib/main.dart`:** Apply the `MyTheme.lightTheme` to the `MaterialApp` and set `debugShowCheckedModeBanner` to `false` for a cleaner presentation.
3.  **Create `lib/widgets/empty_tasks.dart`:** Implement a widget to display a friendly message and icon when the task list is empty.
4.  **Update `lib/screens/task_list_screen.dart`:** Integrate the `EmptyTasks` widget and update the `AppBar` styling to align with the new theme.
5.  **Update `lib/widgets/task_list_item.dart`:** Refactor the `TaskListItem` to use `Card` widgets for better visual appeal, apply theme-defined styles for text, colors, and shadows, and integrate `Slidable` for swipe actions (delete and edit) with themed colors and snackbar feedback.
6.  **Update `lib/screens/add_task_screen.dart`:** Enhance the `AddTaskScreen` with themed input decorations, a styled date picker, and improved layout for a more user-friendly experience.
7.  **Error Handling:** Ensure that all UI changes are implemented without introducing new errors and that existing functionalities remain robust.
'''