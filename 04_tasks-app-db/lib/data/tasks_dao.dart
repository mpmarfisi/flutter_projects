import 'package:floor/floor.dart';
import 'package:navigation/domain/task.dart';

@dao
abstract class TasksDao {
  @Query('SELECT * FROM Task')
  Future<List<Task>> getAllTasks();

  @Query('SELECT * FROM Task WHERE id = :id')
  Future<Task?> getTaskById(String id);

  @insert
  Future<void> insertTask(Task task);

  @update
  Future<void> updateTask(Task task);

  @delete
  Future<void> deleteTask(Task task);
}


