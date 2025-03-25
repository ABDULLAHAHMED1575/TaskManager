import 'package:flutter/material.dart';
import 'package:project/widgets/MyCustomForm.dart';
import 'package:project/widgets/Button.dart';
import 'package:project/models/Registration.dart';
import 'package:project/pages/AdminDashboard.dart';
import 'package:project/pages/UserDashboard.dart';

class Login extends StatefulWidget {
  final List<Registration> registeredUsers;
  final List<Map> allTasks;
  final Function(Registration) onUserRegistered;
  final Function(Map) onTaskAdded;
  final Function(Map) onTaskUpdated;

  const Login({
    super.key,
    required this.registeredUsers,
    required this.allTasks,
    required this.onUserRegistered,
    required this.onTaskAdded,
    required this.onTaskUpdated,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _emailValidate = false;
  bool _passValidate = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _login() {
    setState(() {
      _emailValidate = _emailController.text.isEmpty;
      _passValidate = _passController.text.isEmpty;
    });

    if (!_emailValidate && !_passValidate) {
      final email = _emailController.text;
      final password = _passController.text;

      if (email == "admin" && password == "admin") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Admindashboard(
              registeredUsers: widget.registeredUsers,
              allTasks: widget.allTasks,
              onUserRegistered: widget.onUserRegistered,
              onTaskAdded: widget.onTaskAdded,
              onTaskUpdated: widget.onTaskUpdated,
            ),
          ),
        );
        return;
      }

      for (var user in widget.registeredUsers) {
        if (user.matches(email, password)) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Userdashboard(
                userEmail: email,
                allTasks: widget.allTasks,
                onTaskUpdated: widget.onTaskUpdated,
              ),
            ),
          );
          return;
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid credentials"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyCustomForm(
              hintText: "Email",
              controller: _emailController,
              validate: _emailValidate,
            ),
            const SizedBox(height: 20),
            MyCustomForm(
              hintText: "Password",
              obscureText: true,
              controller: _passController,
              validate: _passValidate,
            ),
            const SizedBox(height: 30),
            Button(
              text: "Login",
              onPressed: _login,
            ),
          ],
        ),
      ),
    );
  }
}