# Task-it Application Blueprint

## Overview

Task-it is a modern, intuitive, and feature-rich task management application designed to help users organize their daily tasks efficiently. The app boasts a sleek, user-friendly interface with a beautiful dark mode, persistent theme settings, and a range of productivity-enhancing features. Task-it is built with Flutter and uses the `provider` package for state management, ensuring a smooth and responsive user experience.

## Features

### Core Functionality

*   **Task Management:** Create, update, and delete tasks with ease.
*   **Task Prioritization:** Assign priority levels (High, Medium, Low) to tasks.
*   **Due Dates:** Set due dates for tasks to stay on schedule.
*   **Task Completion:** Mark tasks as complete to track your progress.
*   **Data Persistence:** Tasks are saved locally on your device, so you never lose your data.

### User Interface & Experience

*   **Modern UI:** A clean, visually appealing interface with a focus on usability.
*   **Light & Dark Themes:** Choose between a light theme and a beautiful, custom-designed dark theme.
*   **Theme Persistence:** Your theme preference is saved and automatically applied when you reopen the app.
*   **Dynamic Task View:** A unique, color-coded view for each task, inspired by modern calendar and task apps.
*   **Custom Icons:** Stylish icons from the `font_awesome_flutter` package for a polished look.
*   **Selection Mode:** A convenient selection mode for performing bulk actions on tasks.
*   **Search & Filter:** Easily find tasks with a powerful search and filtering system.

### Technical Details

*   **State Management:** Uses the `provider` package for efficient state management.
*   **Local Storage:** Uses the `shared_preferences` package to save tasks and theme settings.
*   **Dependencies:** `provider`, `shared_preferences`, `font_awesome_flutter`, `intl`, `timeago`

## Current Plan

This iteration focused on a major UI and functionality overhaul, including:

*   **Theme Persistence:** Implemented a mechanism to save and load the user's theme preference.
*   **UI Overhaul:**
    *   **Enhanced Dark Theme:** Created a more visually appealing dark theme.
    *   **Modern Icons:** Replaced default icons with a more stylish set.
    *   **Styled Controls:** Redesigned filter and sort controls as rounded "chips."
*   **Improved Task Interaction:** Adjusted the task list to improve the selection mode experience.
*   **Redesigned Task View:** Completely redesigned the `ViewTaskPage` with a dynamic, modern UI.
