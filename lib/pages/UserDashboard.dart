import 'package:flutter/material.dart';

class Userdashboard extends StatefulWidget {
  final String userEmail;
  final List<Map> allTasks;
  final Function(Map) onTaskUpdated;

  const Userdashboard({
    super.key,
    required this.userEmail,
    required this.allTasks,
    required this.onTaskUpdated,
  });

  @override
  State<Userdashboard> createState() => _UserdashboardState();
}

class _UserdashboardState extends State<Userdashboard> {
  List<Map> get _userTasks {
    return widget.allTasks.where((task) =>
    task['assignedTo'] == widget.userEmail
    ).toList();
  }

  void _updateTaskStatus(int index, String newStatus) {
    setState(() {
      _userTasks[index]['status'] = newStatus;
      widget.onTaskUpdated(_userTasks[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${widget.userEmail.split('@')[0]}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => setState(() {
              Navigator.pop(context);
            }),
          ),
        ],
      ),
      body: _userTasks.isEmpty
          ? const Center(
        child: Text(
          "No tasks assigned yet",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: _userTasks.length,
        itemBuilder: (context, index) {
          final task = _userTasks[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                task['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text("Status: ${task['status']}\n"
                      "Title: ${task['title']}"),
                ],
              ),
          trailing: PopupMenuButton<String>(
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
            )
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'In Progress':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusBackground(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green.shade100;
      case 'In Progress':
        return Colors.orange.shade100;
      default:
        return Colors.grey.shade100;
    }
  }
}