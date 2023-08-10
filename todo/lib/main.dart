import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
runApp(MyApp());
}

class Task {
String title;
bool isCompleted;

Task(this.title, this.isCompleted);
}

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'To-Do App',
theme: ThemeData(primarySwatch: Colors.pink),
home: TodoListScreen(),
);
}
}

class TodoListScreen extends StatefulWidget {
@override
_TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
List<Task> tasks = [];
TextEditingController _taskController = TextEditingController();

void addTask() {
String taskTitle = _taskController.text;
if (taskTitle.isNotEmpty) {
setState(() {
tasks.add(Task(taskTitle, false));
_taskController.clear();
});
}
}

void editTask(int index) {
String newTitle = _taskController.text;
if (newTitle.isNotEmpty) {
setState(() {
tasks[index].title = newTitle;
_taskController.clear();
});
Navigator.pop(context); // Close the dialog
}
}

void deleteTask(int index) {
setState(() {
tasks.removeAt(index);
});
}

Future<void> _showEditTaskDialog(int index) async {
_taskController.text = tasks[index].title;
await showDialog(
context: context,
builder: (BuildContext context) {
return AlertDialog(
title: Text('Edit Task'),
content: TextField(
autofocus: true,
controller: _taskController,
),
actions: [
TextButton(
onPressed: () {
Navigator.pop(context); // Close the dialog
},
child: Text('Cancel'),
),
TextButton(
onPressed: () {
editTask(index);
},
child: Text('Save'),
),
],
);
},
);
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('To-Do App'),
),
body: ListView.builder(
itemCount: tasks.length,
itemBuilder: (context, index) {
return ListTile(
title: Text(tasks[index].title),
trailing: Checkbox(
value: tasks[index].isCompleted,
onChanged: (_) {
setState(() {
tasks[index].isCompleted = !tasks[index].isCompleted;
});
},
),
onTap: () {
_showEditTaskDialog(index);
},
onLongPress: () {
deleteTask(index);
},
);
},
),
floatingActionButton: FloatingActionButton(
onPressed: () {
showDialog(
context: context,
builder: (BuildContext context) {
return AlertDialog(
title: Text('Add Task'),
content: TextField(
autofocus: true,
controller: _taskController,
),
actions: [
TextButton(
onPressed: () {
Navigator.pop(context); // Close the dialog
},
child: Text('Cancel'),
),
TextButton(
onPressed: () {
addTask();
Navigator.pop(context); // Close the dialog
},
child: Text('Add'),
),
],
);
},
);
},
child: Icon(Icons.add),
),
);
}

@override
void dispose() {
_taskController.dispose();
super.dispose();
}
}