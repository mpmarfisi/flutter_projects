import 'package:flutter/material.dart';
import 'package:navigation/domain/task.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.task,
    this.onTap,
  });

  final Task task;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: task.imageUrl != null
            ? _getImage(task.imageUrl!)
            : const Icon(Icons.task),
        title: Text(task.title),
        subtitle: Text('${task.description}'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => onTap?.call(),
      ),
    );
  }

  Widget _getImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(imageUrl),
    );
  }
}