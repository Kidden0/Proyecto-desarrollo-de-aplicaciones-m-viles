// lib/providers/task_provider.dart
import 'package:flutter/material.dart';
import '../models/task_group.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskGroup> taskGroups = [];
  Map<String, List<Task>> tasksByGroup = {};

  void addGroup(BuildContext context) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Nuevo Grupo de Tareas'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Nombre del grupo'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                String groupId = DateTime.now().toString();
                taskGroups.add(TaskGroup(id: groupId, name: controller.text));
                tasksByGroup[groupId] = [];
                notifyListeners();
                Navigator.pop(context);
              }
            },
            child: Text('Agregar'),
          ),
        ],
      ),
    );
  }

  void editGroup(BuildContext context, TaskGroup group) {
    TextEditingController controller = TextEditingController(text: group.name);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Grupo de Tareas'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Nuevo nombre del grupo'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                group.name = controller.text;
                notifyListeners();
                Navigator.pop(context);
              }
            },
            child: Text('Actualizar'),
          ),
        ],
      ),
    );
  }

  void deleteGroup(TaskGroup group) {
    taskGroups.remove(group);
    tasksByGroup.remove(group.id);
    notifyListeners();
  }

  void addTask(BuildContext context, TaskGroup group) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Nueva Tarea'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Título de la tarea'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                String taskId = DateTime.now().toString();
                Task newTask = Task(id: taskId, title: controller.text);
                tasksByGroup[group.id]?.add(newTask);
                notifyListeners();
                Navigator.pop(context);
              }
            },
            child: Text('Agregar'),
          ),
        ],
      ),
    );
  }

  void toggleTaskCompletion(TaskGroup group, Task task) {
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  void deleteTask(TaskGroup group, Task task) {
    tasksByGroup[group.id]?.remove(task);
    notifyListeners();
  }

  TaskGroup getGroupById(String id) {
    return taskGroups.firstWhere((group) => group.id == id);
  }

  List<Task> getTasksByGroup(String groupId) {
    return tasksByGroup[groupId] ?? [];
  }
}
