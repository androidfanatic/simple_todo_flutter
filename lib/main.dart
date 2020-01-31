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

class Todo {
  final String label;
  bool completed;
  Todo(this.label, this.completed);
}

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  final List<Todo> todos = List<Todo>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: todos.length > 0
            ? ListView.builder(
                itemCount: todos.length,
                itemBuilder: _buildRow,
              )
            : Text('There is nothing here yet. Start by adding some Todos'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _promptDialog(context),
      ),
    );
  }

  /// display a dialog that accepts text
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

  /// build a single row of the list
  Widget _buildRow(context, index) => Row(
        children: <Widget>[
          Checkbox(
              value: todos[index].completed,
              onChanged: (value) => _changeTodo(index, value)),
          Text(todos[index].label,
              style: TextStyle(
                  decoration: todos[index].completed
                      ? TextDecoration.lineThrough
                      : null))
        ],
      );

  /// toggle the completed state of a todo item
  _changeTodo(int index, bool value) =>
      setState(() => todos[index].completed = value);
}
