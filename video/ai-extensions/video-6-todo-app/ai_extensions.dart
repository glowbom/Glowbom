import 'package:flutter/material.dart';

// GlowbomScreen for To-Do List
class GlowbyScreen extends StatelessWidget {
  // Enabling the screen
  static const enabled = true;
  
  // Setting the title for the screen
  static const title = 'To-Do List';
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 360.0),
        child: TodoList(),
      ),
    );
  }
}

// To-Do List widget
class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  // Default tasks
  List<String> tasks = ['Workout', 'Meditate', 'Drink Water'];
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title for the To-Do List
        Text(
          'To-Do List',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20.0),
        // Task input field and button
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Add a new task...',
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // Add new task logic here
              },
            )
          ],
        ),
        SizedBox(height: 20.0),
        // Display tasks
        Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(tasks[index]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        // Mark task as complete logic here
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Remove task logic here
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
