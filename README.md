# Task Management App

A task management app built with Flutter and GetX state management. This app features a monthly calendar view where users can create, read, delete, and edit tasks. The app provides a comprehensive way to manage tasks and keep track of schedules.

## Features

- **Monthly Calendar View**: Visualize your tasks on a monthly calendar for easy tracking.
- **Create New Tasks**: Add new tasks with details like title, description, due date, and priority.
- **Read/View Tasks**: View tasks in a list or calendar format.
- **Edit Existing Tasks**: Update task details whenever needed.
- **Delete Tasks**: Remove tasks that are no longer needed.
- **State Management using GetX**: Efficient state management for a smooth user experience.
- **SQL Database Integration**: Persistent storage of tasks using an SQL database.

## SQL Database

The app uses an SQL database to store tasks persistently. This ensures that tasks are not lost when the app is closed or the device is restarted.

### Database Structure

The database includes the following table:

#### Tasks Table

| Column    | Type    | Description                  |
|-----------|---------|------------------------------|
| id        | INTEGER | Primary key                  |
| taskName  | TEXT    | Task name                    |
| isDone    | INTEGER | Task completion status (0/1) |
| note      | TEXT    | Additional notes             |
| priority  | TEXT    | Task priority (high, medium, low) |

### SQL Operations

- **Create**: Insert new tasks into the database.
- **Read**: Query tasks from the database to display in the app.
- **Update**: Modify existing tasks in the database.
- **Delete**: Remove tasks from the database.

###

<div align="center">
   <img src="https://github.com/user-attachments/assets/1259ab2e-6ce4-407e-a4d9-6e8a996964db" height="500px" hspace=20></img>
  <img src="https://github.com/user-attachments/assets/d2816326-3a0a-4763-9d43-60ea98996d96" height="500px" hspace=20></img>
 <video src="https://github.com/user-attachments/assets/55cdc064-be34-4be4-bf37-5c8a412e5b47">
</div>



