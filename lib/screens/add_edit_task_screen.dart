// screens/add_edit_task_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class AddEditTaskScreen extends StatefulWidget {
  final Task? task;

  AddEditTaskScreen({this.task});

  @override
  _AddEditTaskScreenState createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  DateTime? _dueDate;
  String _priority = 'Medium';

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _title = widget.task!.title;
      _dueDate = widget.task!.dueDate;
      _priority = widget.task!.priority;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              initialValue: widget.task?.title ?? '',
              decoration: const InputDecoration(labelText: 'Task Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              onSaved: (value) {
                _title = value!;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                const Text('Due Date: '),
                TextButton(
                  child: Text(_dueDate == null
                      ? 'Select Date'
                      : '${_dueDate!.day}/${_dueDate!.month}/${_dueDate!.year}'),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _dueDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != _dueDate) {
                      setState(() {
                        _dueDate = picked;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _priority,
              decoration: const InputDecoration(labelText: 'Priority'),
              items: ['Low', 'Medium', 'High'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _priority = newValue!;
                });
              },
            ),
            const SizedBox(height: 32),
            FloatingActionButton(
              child: const Text('Save Task'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final task = Task(
                    id: widget.task?.id,
                    title: _title,
                    dueDate: _dueDate,
                    priority: _priority,
                    isCompleted: widget.task?.isCompleted ?? false,
                  );
                  if (widget.task == null) {
                    Provider.of<TaskProvider>(context, listen: false).addTask(task);
                  } else {
                    Provider.of<TaskProvider>(context, listen: false).updateTask(task);
                  }
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}