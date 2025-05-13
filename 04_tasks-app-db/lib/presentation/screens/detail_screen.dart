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
                  task = updatedTask;
                });
                context.pop(true);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: task == null ? null : () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Delete Task'),
                    content: const Text('Are you sure you want to delete this task?'),
                    actions: [
                      TextButton(
                        onPressed: () => context.pop(),
                        child: const Text('Cancel'),
                      ),
                      FilledButton(
                        onPressed: () async {
                          await database.tasksDao.deleteTask(task!);
                          context.pop();
                          context.pop(true);
                        }, 
                        child: const Text('Delete'),
                      ),
                    ],
                  );
                },
              );
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
    return PageView(
      children: [
        SlideFirstView(task: task),
        SlideSecondView(task: task),
        SlideThirdView(task: task),
      ],
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  task.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.broken_image,
                      size: 100,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                task.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                task.description,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                task.category,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "Progress: ${task.progress}%",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                "Priority: ${task.priority}",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Created At: ${task.createdAt}',
                style: const TextStyle(fontSize: 18),
              ),
              if (task.isCompleted)
                const SizedBox(height: 10),
              if (task.isCompleted)
                Text(
                  'Completed At: ${task.completedAt}',
                  style: const TextStyle(fontSize: 18),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

