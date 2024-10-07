import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_list_item.dart';

class UpcomingTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        // Filter tasks to show only upcoming tasks that are not completed
        final upcomingTasks = taskProvider.tasks.where((task) {
          if (task.dueDate == null || task.isCompleted) return false; // Check if task is not completed
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);
          final taskDate = DateTime(task.dueDate!.year, task.dueDate!.month, task.dueDate!.day);
          return taskDate.isAfter(today); // Only future dates
        }).toList();

        // Build the list of upcoming tasks
        return ListView.builder(
          itemCount: upcomingTasks.length,
          itemBuilder: (context, index) {
            return TaskListItem(task: upcomingTasks[index]);
          },
        );
      },
    );
  }
}
