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
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                context.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                context.pop(context); // Close the drawer
                // Navigate to Profile screen
                context.push('/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                context.pop(context); // Close the drawer
                // Navigate to Settings screen
                context.push('/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logoff'),
              onTap: () {
                context.pop(context); // Close the drawer
                // Handle logoff logic
                context.push('/login');
              },
            ),
          ],
        ),
      ),
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
