// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'screens/menu_screen.dart';
import 'screens/task_screen.dart';
import 'screens/task_group_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(), // Ruta de login
        '/menu': (context) => MenuScreen(),
        '/task': (context) => TaskScreen(),
        '/taskGroup': (context) => TaskGroupScreen(),
      },
    );
  }
}
