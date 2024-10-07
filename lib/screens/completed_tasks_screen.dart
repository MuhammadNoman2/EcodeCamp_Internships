// lib/screens/completed_tasks_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';
import '../widgets/task_list_item.dart';

class CompletedTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        final completedTasks = taskProvider.tasks.where((task) => task.isCompleted).toList();

        return ListView.builder(
          itemCount: completedTasks.length,
          itemBuilder: (context, index) {
            return TaskListItem(task: completedTasks[index]);
          },
        );
      },
    );
  }
}