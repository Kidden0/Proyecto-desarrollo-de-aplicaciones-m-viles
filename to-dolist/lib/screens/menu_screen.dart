// lib/screens/menu_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task_group.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Menú Principal')),
      body: ListView.builder(
        itemCount: taskProvider.taskGroups.length,
        itemBuilder: (context, index) {
          final group = taskProvider.taskGroups[index];
          return ListTile(
            title: Text(group.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    taskProvider.editGroup(context, group);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    taskProvider.deleteGroup(group);
                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, '/task', arguments: group.id);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          taskProvider.addGroup(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
