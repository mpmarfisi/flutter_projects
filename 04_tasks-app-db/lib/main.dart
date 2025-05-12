import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:navigation/core/database/database.dart';
import 'package:navigation/core/router/app_router.dart';

late AppDatabase database;
Future<void> main() async {
  // Ensure that the binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database and measure initialization time
  final stopwatch = Stopwatch()..start();
  database = await AppDatabase.create('task_app_db.db');
  stopwatch.stop();
  log('Database initialized in ${stopwatch.elapsed.inMilliseconds}ms');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router (
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
