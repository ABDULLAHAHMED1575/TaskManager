import 'package:flutter/material.dart';
import 'package:project/models/Registration.dart';
import 'package:project/widgets/MyCustomForm.dart';
import 'package:project/widgets/Button.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  bool _emailValidate = false;
  bool _passValidate = false;
  bool _confirmPassValidate = false;
  bool _passwordsMatch = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _createUser() {
    setState(() {
      _emailValidate = _emailController.text.isEmpty;
      _passValidate = _passController.text.isEmpty;
      _confirmPassValidate = _confirmPassController.text.isEmpty;
      _passwordsMatch = _passController.text == _confirmPassController.text;
    });

    if (!_emailValidate &&
        !_passValidate &&
        !_confirmPassValidate &&
        _passwordsMatch) {
      final newUser = Registration(_emailController.text, _passController.text);
      Navigator.pop(context, newUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create New User")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
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
            const SizedBox(height: 20),
            MyCustomForm(
              hintText: "Confirm Password",
              obscureText: true,
              controller: _confirmPassController,
              validate: _confirmPassValidate,
            ),
            if (!_passwordsMatch)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "Passwords don't match",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 30),
            Button(
              text: "Create User",
              onPressed: _createUser,
            ),
          ],
        ),
      ),
    );
  }
}