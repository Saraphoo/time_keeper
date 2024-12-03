# Time Keeper

**A Flutter-based mobile application for managing and tracking tasks and time.**  
Time Keeper allows users to record their activities, assign priorities, and analyze past tasks using customizable queries. The app is built with Flutter for the frontend and SQLite for secure data storage.

---

## Features

### **1. Task Recording**
- Record tasks with the following details:
    - **Date**: Specify the task's date (e.g., `2024-12-01` or use `today`).
    - **From Time**: Start time of the task (e.g., `9:00 AM`).
    - **To Time**: End time of the task (e.g., `11:00 AM`).
    - **Task**: Describe the activity (e.g., "Studied for Math Exam").
    - **Tag**: Categorize the task (e.g., "STUDY").
    - **Priority**: Assign a priority (1 = Low, 5 = High).

### **2. Task Querying**
- Query recorded tasks based on:
    - **Date**: Retrieve tasks from a specific date.
    - **Task**: Search tasks containing a keyword.
    - **Tag**: Filter tasks by category.
    - **Priority**: Filter tasks by priority levels.

### **3. Reports**
- Generate reports for tasks completed within a specified date range.
- View detailed insights, including start and end times.

### **4. Priority Analysis**
- View the most frequently logged tasks using the "Priority" feature.

### **5. Offline Support**
- Record tasks without an internet connection.
- Data syncs seamlessly with SQLite when the connection is restored.

---

## Getting Started

### Prerequisites
Ensure you have the following installed:
- Flutter SDK ([Download Flutter](https://flutter.dev/docs/get-started/install))
- Android Studio or Visual Studio Code for development
- A device or emulator for testing

### Setup
1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd time_keeper
