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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      // title: const Text('Cerrar sesión'),
                      content: const Text('¿Are you sure you want to logoff?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            context.pop();
                          },
                        ),
                        FilledButton(
                          child: const Text('Logoff'),
                          onPressed: () {
                            context.pop();
                            context.pop(context);
                            context.go('/login');
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: _TasksView(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => SnackBar(
          content: const Text('Snackbar'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        ),
        label: const Text('+'), 
        shape: CircleBorder(
          side: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        // icon: const Icon(Icons.plus_one_outlined),
      ),
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
