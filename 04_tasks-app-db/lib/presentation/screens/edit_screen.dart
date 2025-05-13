import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/domain/task.dart';

class EditScreen extends StatefulWidget {
  final Task? task;
  final String userId;

  const EditScreen({super.key, this.task, required this.userId});

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
    id = task?.id ?? DateTime.now().toString().substring(0, 10);
    title = task?.title ?? '';
    description = task?.description ?? '';
    imageUrl = task?.imageUrl ?? '';
    dueDate = task?.dueDate ?? '';
    category = task?.category ?? 'General';
    priority = task?.priority ?? 0;
    progress = task?.progress ?? 0;
    isCompleted = task?.isCompleted ?? false;
    setState(() {});
  }

  Future<void> _selectDueDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dueDate.isNotEmpty ? DateTime.parse(dueDate) : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        dueDate = '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
      });
    }
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
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Due Date'),
                controller: TextEditingController(text: dueDate),
                onTap: _selectDueDate,
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
                validator: (value) {
                  final parsedValue = int.tryParse(value ?? '');
                  if (parsedValue == null || parsedValue < 0 || parsedValue > 3) {
                    return 'Priority must be between 0 and 3';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: progress.toString(),
                decoration: const InputDecoration(labelText: 'Progress'),
                keyboardType: TextInputType.number,
                onSaved: (value) => progress = int.tryParse(value ?? '0') ?? 0,
                validator: (value) {
                  final parsedValue = int.tryParse(value ?? '');
                  if (parsedValue == null || parsedValue < 0 || parsedValue > 100) {
                    return 'Progress must be between 0 and 100';
                  }
                  return null;
                },
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
                      createdAt: widget.task?.createdAt ?? DateTime.now().toString().substring(0, 10),
                      completedAt: isCompleted ? DateTime.now().toString().substring(0, 10) : null, 
                      userId: widget.userId,
                    );
                    context.pop(task);
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