import 'package:flutter/material.dart';
import 'package:navigation/data/tasks_list.dart';
import 'package:navigation/domain/task.dart';

class DetailScreen extends StatelessWidget{
  const DetailScreen({
    super.key,
    required this.taskId,
  });

  final String taskId;

  @override
  Widget build(BuildContext context) {
    final task = tasksList.firstWhere((task) => task.id == taskId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
      ),
      body: TaskDetailView(task: task),
    );
  }
}

class TaskDetailView extends StatelessWidget {
  const TaskDetailView({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (task.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(task.imageUrl!),
            ),
          const SizedBox(height: 20),
          Text(
            task.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            task.description,
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            task.dueDate,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}