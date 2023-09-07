import 'package:flutter/material.dart';
import 'package:sqllite_demo/home_screen.dart';
import 'package:sqllite_demo/services/todo_service.dart';

class TodoByCategory extends StatefulWidget {
  final String categoryValue;
  const TodoByCategory({super.key, required this.categoryValue});

  @override
  State<TodoByCategory> createState() => _TodoByCategoryState();
}

class _TodoByCategoryState extends State<TodoByCategory> {
  final _todos = [];

  _getTodosByCategory(String categoryValue) async {
    _todos.clear();
    final todoService = TodoService();
    final todos = await todoService.readTodoByCategory(categoryValue);
    //print(todos);
    todos.forEach(
      (todo) {
        setState(() {
          _todos.add(
            todo,
          );
        });
      },
    );
  }

  _checkTodo(id, value) async {
    final todoService = TodoService();
    final result = todoService.checkTodo(id, value);
    _getTodosByCategory(widget.categoryValue);
  }

  @override
  void initState() {
    super.initState();
    _getTodosByCategory(widget.categoryValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryValue),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen())),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  final todo = _todos[index];
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(todo['title']),
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
                      trailing: Text(todo['todoDate']),
                    ),
                  );
                },
              ),
            ))
          ],
        ));
  }
}
