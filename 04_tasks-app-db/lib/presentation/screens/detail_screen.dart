import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/domain/task.dart';
import 'package:navigation/main.dart';

class DetailScreen extends StatefulWidget{
  const DetailScreen({
    super.key,
    required this.taskId,
  });

  final String taskId;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Task? task;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  Future<void> _loadTask() async {
    try {
      final fetchedTask = await database.tasksDao.getTaskById(widget.taskId);
      if (fetchedTask == null) {
        setState(() {
          errorMessage = 'Task not found.';
          isLoading = false;
        });
      } else {
        setState(() {
          task = fetchedTask;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: task == null ? null : () async {
              final updatedTask = await context.push('/edit', extra: {'task': task, 'userId': task!.userId});
              if (updatedTask != null) {
                await database.tasksDao.updateTask(updatedTask as Task);
                setState(() {
                  task = updatedTask; // Update the task after editing
                });
                context.pop(true); // Indicate that an update occurred
              }
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : TaskDetailView(task: task!),
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
        Image.network(
          task.imageUrl,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.broken_image,
              // size: 10,
              color: Colors.grey,
            );
          },
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

