import 'package:floor/floor.dart';
import 'package:navigation/domain/user.dart';

@Entity(
  tableName: 'Task',
  foreignKeys: [
    ForeignKey(
      childColumns: ['userId'],
      parentColumns: ['username'],
      entity: User,
      onDelete: ForeignKeyAction.cascade, // Delete tasks if the user is deleted
    ),
  ],
)
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
  final String? createdAt;
  final String? completedAt;
  final String userId; // Foreign key to reference the User

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.dueDate,
    required this.priority,
    required this.userId, // Add userId
    this.category = 'General',
    this.progress = 0,
    this.isCompleted = false,
    this.createdAt,
    this.completedAt,
  });
}
