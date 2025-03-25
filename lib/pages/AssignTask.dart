import 'package:flutter/material.dart';
import 'package:project/models/Registration.dart';

class Assigntask extends StatefulWidget {
  final List<Registration> users;

  const Assigntask({
    super.key,
    required this.users,
  });

  @override
  State<Assigntask> createState() => _AssigntaskState();
}

class _AssigntaskState extends State<Assigntask> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  String? _selectedUser;
  String? _selectedStatus = 'Pending';

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Assign Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Task Title'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedUser,
                decoration: const InputDecoration(labelText: 'Assign To'),
                items: widget.users.map((user) {
                  return DropdownMenuItem(
                    value: user.email,
                    child: Text(user.email),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedUser = value),
                validator: (value) => value == null ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: const InputDecoration(labelText: 'Status'),
                items: ['Pending'].map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedStatus = value),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, {
                      'title': _titleController.text,
                      'assignedTo': _selectedUser!,
                      'status': _selectedStatus!,
                    });
                  }
                },
                child: const Text("Assign Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}