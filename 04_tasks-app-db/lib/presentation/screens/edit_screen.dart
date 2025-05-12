import 'package:flutter/material.dart';
import 'package:navigation/domain/task.dart';

class EditScreen extends StatefulWidget {
  final Task? task;

  const EditScreen({super.key, this.task});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String id;
  late String title;
  late String description;
  late String imageUrl;
  late String dueDate;
  late String category;
  late int priority;
  late int progress;
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    final task = widget.task;
    id = task?.id ?? DateTime.now().toString();
    title = task?.title ?? '';
    description = task?.description ?? '';
    imageUrl = task?.imageUrl ?? '';
    dueDate = task?.dueDate ?? '';
    category = task?.category ?? 'General';
    priority = task?.priority ?? 0;
    progress = task?.progress ?? 0;
    isCompleted = task?.isCompleted ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: title,
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) => title = value ?? '',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Title is required' : null,
              ),
              TextFormField(
                initialValue: description,
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => description = value ?? '',
              ),
              TextFormField(
                initialValue: imageUrl,
                decoration: const InputDecoration(labelText: 'Image URL'),
                onSaved: (value) => imageUrl = value ?? '',
              ),
              TextFormField(
                initialValue: dueDate,
                decoration: const InputDecoration(labelText: 'Due Date'),
                onSaved: (value) => dueDate = value ?? '',
              ),
              TextFormField(
                initialValue: category,
                decoration: const InputDecoration(labelText: 'Category'),
                onSaved: (value) => category = value ?? 'General',
              ),
              TextFormField(
                initialValue: priority.toString(),
                decoration: const InputDecoration(labelText: 'Priority'),
                keyboardType: TextInputType.number,
                onSaved: (value) => priority = int.tryParse(value ?? '0') ?? 0,
              ),
              TextFormField(
                initialValue: progress.toString(),
                decoration: const InputDecoration(labelText: 'Progress'),
                keyboardType: TextInputType.number,
                onSaved: (value) => progress = int.tryParse(value ?? '0') ?? 0,
              ),
              SwitchListTile(
                title: const Text('Completed'),
                value: isCompleted,
                onChanged: (value) => setState(() => isCompleted = value),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    final task = Task(
                      id: id,
                      title: title,
                      description: description,
                      imageUrl: imageUrl,
                      dueDate: dueDate,
                      category: category,
                      priority: priority,
                      progress: progress,
                      isCompleted: isCompleted,
                      createdAt: widget.task?.createdAt ?? DateTime.now().toIso8601String(),
                      completedAt: isCompleted ? DateTime.now().toIso8601String() : null, 
                      userId: '',
                    );
                    Navigator.pop(context, task);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}