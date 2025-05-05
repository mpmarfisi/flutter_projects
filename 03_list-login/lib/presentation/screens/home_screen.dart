import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/data/tasks_list.dart';
import 'package:navigation/domain/task.dart';
import 'package:navigation/presentation/widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.username});

  final String username;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _TasksView(),
    );
  }
}

class _TasksView extends StatelessWidget {
  const _TasksView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasksList.length,
      itemBuilder: (context, index){
        return TaskItem(
          task: tasksList[index],
          onTap: () {
            navigateToDetailScreen(context, tasksList[index]);
          },
        );
      }
    );
  }

  void navigateToDetailScreen(BuildContext context, Task task) {
    context.push('/task-details/${task.id}');
  }
}
