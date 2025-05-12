import 'package:flutter/material.dart';
import 'package:navigation/data/tasks_list.dart';
import 'package:navigation/domain/task.dart';
import 'package:navigation/main.dart';
import 'package:navigation/presentation/screens/edit_screen.dart';

class DetailScreen extends StatelessWidget{
  const DetailScreen({
    super.key,
    required this.taskId,
  });

  final String taskId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              // final updatedTask = await context.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => EditScreen(task: task),
              //   ),
              // );
              // if (updatedTask != null) {
              //   // Handle the updated task (e.g., update the task list)
              // }
            },
          ),
        ],
      ),
      body: FutureBuilder<Task?>(
        future: database.tasksDao.getTaskById(taskId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Task not found.'));
          } else {
            final task = snapshot.data!;
            return TaskDetailView(task: task);
          }
        },
      ),
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
      child: PageView(
        children: [
          SlideFirstView(task: task),
          SlideSecondView(task: task),
          SlideThirdView(task: task),
        ]
      ),
    );
  }
}

class SlideFirstView extends StatelessWidget {
  const SlideFirstView({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(task.imageUrl),
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
      ],
    );
  }
}

class SlideSecondView extends StatelessWidget {
  const SlideSecondView({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          task.category,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Progress: ${task.progress.toString()}",
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          "Priority: ${task.priority.toString()}",
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

class SlideThirdView extends StatelessWidget {
  const SlideThirdView({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Created At: ${task.createdAt}',
          style: const TextStyle(fontSize: 18),
        ),
        if (task.isCompleted)
          Text(
            'Completed At: ${task.completedAt}',
            style: const TextStyle(fontSize: 18),
          ),
      ],
    );
  }
}

