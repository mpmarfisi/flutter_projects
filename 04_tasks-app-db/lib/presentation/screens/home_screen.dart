import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/domain/task.dart';
import 'package:navigation/main.dart';
import 'package:navigation/presentation/widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.username});

  final String username;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Task>> _tasksFuture;

  @override
  void initState() {
    super.initState();
    if (widget.username.isEmpty) {
      throw Exception('Invalid username passed to HomeScreen');
    }
    _tasksFuture = database.tasksDao.getTasksByUserId(widget.username);
  }

  void _refreshTasks() {
    setState(() {
      _tasksFuture = database.tasksDao.getTasksByUserId(widget.username);
    });
  }

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
                context.push('/profile', extra: widget.username);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                context.pop(context); // Close the drawer
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
                      content: const Text('Are you sure you want to logoff?'),
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
      // body: _TasksView(username: widget.username),
      body: _TasksView(
        tasksFuture: _tasksFuture,
        onTasksUpdated: _refreshTasks, // Pass the callback to _TasksView
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await context.push('/edit', extra: {'userId': widget.username}) as Task?;
          if (newTask != null) {
            await database.tasksDao.insertTask(newTask);
            _refreshTasks(); // Refresh tasks after adding a new one
          }
        },
        shape: CircleBorder(
          side: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 3,
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TasksView extends StatelessWidget {
  const _TasksView({
    required this.tasksFuture,
    required this.onTasksUpdated,
  });

  final Future<List<Task>> tasksFuture;
  final VoidCallback onTasksUpdated; // Callback to notify HomeScreen

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: tasksFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No tasks available.'));
        } else {
          final tasks = snapshot.data!;
          final priority0Tasks = tasks.where((task) => task.priority == 0).toList();
          final priority1Tasks = tasks.where((task) => task.priority == 1).toList();
          final priority2Tasks = tasks.where((task) => task.priority == 2).toList();
          final priority3Tasks = tasks.where((task) => task.priority == 3).toList();

          final hasTasks = priority0Tasks.isNotEmpty ||
              priority1Tasks.isNotEmpty ||
              priority2Tasks.isNotEmpty ||
              priority3Tasks.isNotEmpty;

          return hasTasks
              ? ListView(
                  children: [
                    if (priority0Tasks.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Priority 0',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...priority0Tasks.map((task) => TaskItem(
                            task: task,
                            onTap: () async {
                              final result = await context.push('/task-details/${task.id}');
                              if (result == true) {
                                onTasksUpdated(); // Notify HomeScreen to refresh tasks
                              }
                            },
                          )),
                    ],
                    if (priority1Tasks.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Priority 1',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...priority1Tasks.map((task) => TaskItem(
                            task: task,
                            onTap: () async {
                              final result = await context.push('/task-details/${task.id}');
                              if (result == true) {
                                onTasksUpdated(); // Notify HomeScreen to refresh tasks
                              }
                            },
                          )),
                    ],
                    if (priority2Tasks.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Priority 2',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...priority2Tasks.map((task) => TaskItem(
                            task: task,
                            onTap: () async {
                              final result = await context.push('/task-details/${task.id}');
                              if (result == true) {
                                onTasksUpdated(); // Notify HomeScreen to refresh tasks
                              }
                            },
                          )),
                    ],
                    if (priority3Tasks.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Priority 3',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...priority3Tasks.map((task) => TaskItem(
                            task: task,
                            onTap: () async {
                              final result = await context.push('/task-details/${task.id}');
                              if (result == true) {
                                onTasksUpdated(); // Notify HomeScreen to refresh tasks
                              }
                            },
                          )),
                    ],
                  ],
                )
              : const Center(
                  child: Text('No tasks available for any priority.'),
                );
        }
      },
    );
  }
}
