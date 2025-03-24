import 'package:flutter/material.dart';
import 'package:project/widgets/Button.dart';
import 'package:project/pages/AssignTask.dart';
import 'package:project/pages/login.dart';
import 'package:project/pages/signup.dart';
import 'package:project/models/Registration.dart';

class Admindashboard extends StatefulWidget {
  final List<Registration> registeredUsers;
  final List<Map> allTasks;
  final Function(Registration) onUserRegistered;
  final Function(Map) onTaskAdded;
  final Function(Map) onTaskUpdated;

  const Admindashboard({
    super.key,
    required this.registeredUsers,
    required this.allTasks,
    required this.onUserRegistered,
    required this.onTaskAdded,
    required this.onTaskUpdated,
  });

  @override
  State<Admindashboard> createState() => _AdmindashboardState();
}

class _AdmindashboardState extends State<Admindashboard> {
  void _assignTask() async {
    final newTask = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => Assigntask(
          users: widget.registeredUsers,
        ),
      ),
    );

    if (newTask != null) {
      widget.onTaskAdded(newTask);
      setState(() {});
    }
  }

  void _createUser() async {
    final newUser = await Navigator.push<Registration>(
      context,
      MaterialPageRoute(
        builder: (context) => Signup(
          userRegistration: widget.onUserRegistered,
        ),
      ),
    );

    if (newUser != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User created successfully"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _updateTaskStatus(int index, String newStatus) {
    setState(() {
      widget.allTasks[index]['status'] = newStatus;
      widget.onTaskUpdated(widget.allTasks[index]);
    });
  }

  void _viewUsers() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Registered Users"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.registeredUsers.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(widget.registeredUsers[index].email),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    widget.registeredUsers.removeAt(index);
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Login(
          registeredUsers: widget.registeredUsers,
          allTasks: widget.allTasks,
          onUserRegistered: widget.onUserRegistered,
          onTaskAdded: widget.onTaskAdded,
          onTaskUpdated: widget.onTaskUpdated,
        ),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: [
                Button(
                  text: "Create User",
                  onPressed: _createUser,
                  icon: Icons.person_add,
                ),
                Button(
                  text: "Assign Task",
                  onPressed: _assignTask,
                  icon: Icons.add_task,
                ),
                Button(
                  text: "View Users",
                  onPressed: _viewUsers,
                  icon: Icons.people,
                ),
              ],
            ),
          ),
          Expanded(
            child: widget.allTasks.isEmpty
                ? const Center(child: Text("No tasks assigned yet"))
                : ListView.builder(
              itemCount: widget.allTasks.length,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0),
                child: ListTile(
                  title: Text(widget.allTasks[index]['title']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Assigned to: ${widget.allTasks[index]['assignedTo']}"),
                      Text("Status: ${widget.allTasks[index]['status']}"),
                      Text("Created: ${widget.allTasks[index]['createdAt']?.split(' ')[0] ?? ''}"),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PopupMenuButton<String>(
                        onSelected: (value) => _updateTaskStatus(index, value),
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'Pending',
                            child: Text('Mark as Pending'),
                          ),
                          const PopupMenuItem(
                            value: 'In Progress',
                            child: Text('Mark as In Progress'),
                          ),
                          const PopupMenuItem(
                            value: 'Completed',
                            child: Text('Mark as Completed'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}