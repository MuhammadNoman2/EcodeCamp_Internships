// lib/screens/today_tasks_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_list_item.dart';

class TodayTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        final todayTasks = taskProvider.tasks.where((task) {
          if (task.dueDate == null || task.isCompleted) return false;
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);
          final taskDate = DateTime(task.dueDate!.year, task.dueDate!.month, task.dueDate!.day);
          return taskDate.isAtSameMomentAs(today);
        }).toList();

        return ListView.builder(
          itemCount: todayTasks.length,
          itemBuilder: (context, index) {
            return TaskListItem(task: todayTasks[index]);
          },
        );
      },
    );
  }
}