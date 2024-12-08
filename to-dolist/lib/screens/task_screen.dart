// lib/screens/task_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';
import '../models/task_group.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final groupId = ModalRoute.of(context)?.settings.arguments as String?;
    final taskProvider = Provider.of<TaskProvider>(context);

    if (groupId == null) return Scaffold(body: Center(child: Text('Error: No se encontró el grupo')));

    final group = taskProvider.getGroupById(groupId);
    final tasks = taskProvider.getTasksByGroup(groupId);

    return Scaffold(
      appBar: AppBar(
        title: Text(group.name),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                color: task.isCompleted ? Colors.grey : null,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    taskProvider.toggleTaskCompletion(group, task);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    taskProvider.deleteTask(group, task);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          taskProvider.addTask(context, group);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
