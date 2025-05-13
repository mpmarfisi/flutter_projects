// required package imports
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:navigation/data/user_dao.dart';
import 'package:navigation/domain/user.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:navigation/domain/task.dart';
import 'package:navigation/data/tasks_dao.dart';

part 'database.g.dart'; // el código generado va a estar en el .g.dart

@Database(version: 1, entities: [Task, User])
abstract class AppDatabase extends FloorDatabase {
  TasksDao get tasksDao;
  UserDao get userDao;

  static Future<AppDatabase> create(String name) {
    return $FloorAppDatabase.databaseBuilder(name).addCallback(Callback(
      onCreate: (database, version) async {
        await _prepopulate(database);
        // await _saveAssetsInDevice();
      },
    )).build();
  }

  static Future<void> _prepopulate(sqflite.DatabaseExecutor database) async {
    final users = [
      User(
        username: 'user123',
        name: 'User Name',
        email: 'user@example.com',
        password: 'pass123',
        bornDate: DateTime(1990, 1, 1).toIso8601String(),
      ),
    ];

    final tasks = [
      Task(
        id: '1',
        title: 'Sample Task',
        description: 'This is a sample task',
        imageUrl: 'https://via.placeholder.com/150',
        dueDate: '2023-12-31',
        priority: 1,
        userId: 'user123', // Associate task with user
        createdAt: DateTime.now().toIso8601String(),
      ),
    ];

    for (final user in users) {
      await database.insert('User', {
        'username': user.username,
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'imageUrl': user.imageUrl,
        'bornDate': user.bornDate,
      });
    }

    for (final task in tasks) {
      await database.insert('Task', {
        'id': task.id,
        'title': task.title,
        'description': task.description,
        'imageUrl': task.imageUrl,
        'dueDate': task.dueDate,
        'category': task.category,
        'priority': task.priority,
        'progress': task.progress,
        'isCompleted': task.isCompleted ? 1 : 0,
        'createdAt': task.createdAt,
        'completedAt': task.completedAt,
        'userId': task.userId, // Include userId
      });
    }
  }
}