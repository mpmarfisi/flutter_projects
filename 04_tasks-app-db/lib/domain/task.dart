import 'package:floor/floor.dart';

@Entity(tableName: 'Task')
class Task {
  @primaryKey
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String dueDate;
  final String category;
  final int priority;
  final int progress;
  final bool isCompleted;
  final String? createdAt; // Changed from DateTime? to String?
  final String? completedAt; // Changed from DateTime? to String?

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.dueDate,
    required this.priority,
    this.category = 'General',
    this.progress = 0,
    this.isCompleted = false,
    this.createdAt, // Updated type
    this.completedAt, // Updated type
  });
}
