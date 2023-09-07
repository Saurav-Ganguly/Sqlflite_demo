import 'package:flutter/material.dart';
import 'package:sqllite_demo/helpers/drawar_navigation.dart';
import 'package:sqllite_demo/services/todo_service.dart';
import 'package:sqllite_demo/todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _todos = [];

  _getAllTodos() async {
    _todos.clear();
    final todoService = TodoService();
    final todos = await todoService.readTodos();
    todos.forEach((todo) {
      setState(() {
        _todos.add(todo);
      });
    });
  }

  _checkTodo(id, value) async {
    final todoService = TodoService();
    final result = todoService.checkTodo(id, value);
    _getAllTodos();
  }

  @override
  void initState() {
    super.initState();
    _getAllTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoList Sqflite'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TodoScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      drawer: const DrawerNavigation(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _todos.length,
          itemBuilder: (context, index) {
            final todo = _todos[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 5),
              elevation: 5,
              child: ListTile(
                leading: Checkbox(
                  value: todo['isFinished'] == 1 ? true : false,
                  onChanged: (bool? value) {
                    if (value == true) {
                      _checkTodo(todo['id'], 1);
                    } else {
                      _checkTodo(todo['id'], 0);
                    }
                  },
                ),
                title: Text(todo['title']),
                subtitle: Text("Category: ${todo['category']}"),
                trailing: Text(todo['todoDate']),
              ),
            );
          },
        ),
      ),
    );
  }
}
