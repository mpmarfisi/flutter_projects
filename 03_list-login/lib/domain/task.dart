class Task {
  final String title;
  final String description;
  final String imageUrl;
  final String dueDate;
  final String category;
  final int priority;
  final int progress;
  final bool isCompleted;
  final DateTime? createdAt;
  final DateTime? completedAt;

  Task({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.dueDate,
    required this.priority,
    this.category = 'General',
    this.progress = 0,
    this.isCompleted = false,
    this.createdAt,
    this.completedAt
  });
}
