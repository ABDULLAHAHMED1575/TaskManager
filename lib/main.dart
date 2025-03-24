import 'package:flutter/material.dart';
import 'package:project/pages/login.dart';
import 'package:project/models/Registration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Registration> registeredUsers = [];
  List<Map> allTasks = [];

  void _handleUserRegistration(Registration newUser) {
    setState(() => registeredUsers.add(newUser));
  }

  void _handleTaskAddition(Map newTask) {
    setState(() => allTasks.add(newTask));
  }

  void _handleTaskUpdate(Map updatedTask) {
    setState(() {
      final index = allTasks.indexWhere((t) => t['title'] == updatedTask['title']);
      if (index != -1) {
        allTasks[index] = updatedTask;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Management System',
      home: Login(
        registeredUsers: registeredUsers,
        allTasks: allTasks,
        onUserRegistered: _handleUserRegistration,
        onTaskAdded: _handleTaskAddition,
        onTaskUpdated: _handleTaskUpdate,
      ),
    );
  }
}