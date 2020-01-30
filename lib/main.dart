import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoListState();
}

class Todo {
  final String label;
  bool isDone;
  Todo(this.label, this.isDone);
}

class TodoListState extends State<TodoList> {
  final List<Todo> todos = List<Todo>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TODO')),
      body: todos.length > 0
          ? ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) => Row(
                children: <Widget>[
                  Checkbox(
                      value: todos[index].isDone,
                      onChanged: (value) => _toggleTodoItem(value, index)),
                  Text(
                    todos[index].label,
                    style: TextStyle(
                        decoration: todos[index].isDone
                            ? TextDecoration.lineThrough
                            : null),
                  ),
                ],
              ),
            )
          : Padding(
              child: Text(
                  'There is nothing here yet. Start by adding some TODOs.'),
              padding: EdgeInsets.all(16.0),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _promptDialog(context),
      ),
    );
  }

  _promptDialog(BuildContext context) {
    String _todoLabel = '';
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter TODO item'),
            content: TextField(
                onChanged: (value) => _todoLabel = value,
                decoration: InputDecoration(hintText: 'Add new TODO item')),
            actions: <Widget>[
              FlatButton(
                child: new Text('CANCEL'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: new Text('ADD'),
                onPressed: () {
                  setState(() => todos.add(Todo(_todoLabel, false)));
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  _toggleTodoItem(bool value, int index) =>
      setState(() => todos[index].isDone = value);
}
