# Sarah Riley (Individual Project)

## Student Information
**Email**: [Rileys14@mymail.nku.edu](mailto:Rileys14@mymail.nku.edu)

---

## Planning the Individual Project

### **Summary of the Project**
A mobile application to help students manage and track their time by recording tasks, specifying dates, times, and tags, and querying these records. The app features a simple user interface for time tracking with fields for:
- Date
- Start and end time
- Task description
- Tag

The application also allows students to query their past activities based on:
- Date
- Task
- Tag

---

### **Goals**
1. Develop a mobile time-tracking application using Flutter for the front end and SQLite for backend services.
2. Allow users to:
    - Record tasks with flexible date and time inputs.
    - Tag tasks for easy categorization.
    - Query recorded tasks using customizable filters.

---

### **Why?**
Students want to improve their time management by:
- Logging and tracking how they spend their time on specific tasks and activities.
- Analyzing past activities to identify areas for productivity improvement.

This app provides flexibility in recording times and tasks while offering query functionality to review historical data.

---

## Features

### **1. Task Recording Screen**
A simple form where users can input:
- **Date**: Record the date of the task.
- **From**: Start time of the task.
- **To**: End time of the task.
- **Task**: Description of the activity (e.g., "Studied Java").
- **Tag**: A category for the task (e.g., "STUDY").
- **Priority**: A numerical priority level (e.g., 1 = Low, 5 = High).

---

### **2. Task Query Screen**
A search feature where users can query past tasks based on:
- **Date**: Find tasks from a specific date.
- **Task**: Search by specific activity (e.g., "Java").
- **Tag**: Filter tasks by a category (e.g., "STUDY").
- **Priority**: Filter tasks by importance.

---

### **3. SQLite Integration**
- Securely store and retrieve tasks using SQLite.
- Perform CRUD operations for task data.

---

### **4. Basic User Authentication**
- Users can log in and manage their tasks using SQLite Authentication.

---

## Project Test Plan

### **1. Task Recording**

#### **Test Case 2.1: Record a Task with Valid Inputs**
**Objective**: Verify that tasks can be recorded with correct inputs.

**Steps**:
1. Log in and navigate to the task recording screen.
2. Enter valid inputs for date, start time, end time, task, and tag.
3. Submit the form.

**Expected Result**: The task should be saved in the database, and a confirmation message should appear.

---

#### **Test Case 2.2: Record a Task with Invalid Time Format**
**Objective**: Ensure the app handles invalid time formats correctly.

**Steps**:
1. Enter an invalid time format (e.g., "25:00").
2. Submit the form.

**Expected Result**: The form should not be submitted, and an error message should indicate the invalid time format.

---

#### **Test Case 2.3: Record a Task with Missing Inputs**
**Objective**: Ensure the app prevents task recording if required fields are missing.

**Steps**:
1. Leave one or more fields blank (e.g., Task or Date).
2. Submit the form.

**Expected Result**: The form should not be submitted, and an error message should indicate missing fields.

---

### **2. Task Querying**

#### **Test Case 3.1: Query Tasks by Date**
**Objective**: Ensure tasks can be retrieved based on a specific date.

**Steps**:
1. Navigate to the task query screen.
2. Enter a valid date and submit the form.

**Expected Result**: The list of tasks for the given date should appear.

---

#### **Test Case 3.2: Query Tasks by Task Name**
**Objective**: Ensure tasks can be retrieved based on a specific task name.

**Steps**:
1. Navigate to the task query screen.
2. Enter a task keyword (e.g., "Java") and submit the form.

**Expected Result**: All tasks containing that keyword should appear.

---

#### **Test Case 3.3: Query Tasks by Tag**
**Objective**: Ensure tasks can be retrieved based on a specific tag.

**Steps**:
1. Navigate to the task query screen.
2. Enter a tag (e.g., "STUDY") and submit the form.

**Expected Result**: All tasks with that tag should appear.

---

### **3. SQLite Integration**

#### **Test Case 4.1: Data Syncing with SQLite**
**Objective**: Verify that tasks are properly stored and retrieved from SQLite.

**Steps**:
1. Check SQLite to confirm the task is stored.
2. Query the task from the app.

**Expected Result**: The task should be stored in SQLite and retrievable from the app.

---

#### **Test Case 4.2: Data Sync after Reconnection**
**Objective**: Ensure the app can sync data after going offline and reconnecting.

**Steps**:
1. Record a task offline.
2. Reconnect and check if the task syncs with SQLite.

**Expected Result**: The task should sync with SQLite once the connection is restored.

---

### **4. General Usability**

#### **Test Case 5.1: Navigation Between Screens**
**Objective**: Ensure users can navigate between screens.

**Steps**:
1. Log in and navigate through the app's screens.

**Expected Result**: Users should be able to navigate smoothly between different sections of the app without errors.

---

#### **Test Case 5.2: Error Messages Display Correctly**
**Objective**: Verify that appropriate error messages are displayed when invalid data is entered.

**Steps**:
1. Enter invalid data (e.g., incorrect date or time).

**Expected Result**: An appropriate error message should be displayed without crashing the app.

---

## Milestones and Deadlines

| **Milestone**                      | **Start Date** | **End Date**   | **Deliverables**                                                                                      |
|-------------------------------------|----------------|----------------|-------------------------------------------------------------------------------------------------------|
| Project Planning and Setup          | 10/11/2024     | 10/13/2024     | Finalize project requirements and set up tools.                                                      |
| Basic UI/UX Design                  | 10/14/2024     | 10/17/2024     | Low-fidelity designs for main screens.                                                               |
| SQLite Integration                  | 10/18/2024     | 10/22/2024     | Set up SQLite and CRUD operations.                                                                   |
| Prototype Version 1 Development     | 10/23/2024     | 10/29/2024     | Core task recording functionality connected to SQLite.                                               |
| User Authentication                 | 10/30/2024     | 11/03/2024     | Secure login, registration, and logout functionality.                                                |
| Task Query Functionality            | 11/04/2024     | 11/08/2024     | Query tasks by date, task, and tag.                                                                  |
| Data Validation and Error Handling  | 11/09/2024     | 11/12/2024     | Add input validation and error handling.                                                             |
| UI/UX Finalization                  | 11/13/2024     | 11/16/2024     | Refine and polish the user interface.                                                                |
| SQLite Sync and Offline Mode        | 11/17/2024     | 11/20/2024     | Enable offline mode and reliable syncing.                                                            |
| Final Version Development           | 11/21/2024     | 11/26/2024     | Final application ready for review.                                                                  |
| Final Testing and Bug Fixing        | 11/27/2024     | 11/30/2024     | Conduct rigorous testing and fix any bugs.                                                           |
| Deployment                          | 12/01/2024     | 12/01/2024     | Application fully developed and deployed.                                                            |

---

## Risk Analysis

### **1. Technical Risks**
- **SQLite Integration Issues**: Follow documentation and test SQLite early.
- **Data Syncing Issues**: Test offline and syncing features thoroughly.
- **Platform-Specific Bugs**: Test on both iOS and Android platforms.

### **2. Project Management Risks**
- **Scope Creep**: Define project scope clearly and avoid unnecessary features.
- **Time Overruns**: Use buffers in timelines and conduct frequent progress reviews.

### **3. User Risks**
- **User Adoption Issues**: Perform user testing early and iterate on feedback.
- **Incorrect Data Input**: Implement thorough input validation.

---

## Project Progress
### **Week-by-Week Details**
Refer to the original document for a detailed breakdown of weekly activities, milestones, and risks.
[Sarah Riley Individual Project](https://nku.instructure.com/courses/77209/pages/sarah-riley-individual-project)
