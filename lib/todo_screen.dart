import 'package:flutter/material.dart';
import 'package:sqllite_demo/home_screen.dart';
import 'package:sqllite_demo/modals/todo.dart';
import 'package:sqllite_demo/services/category_service.dart';
import 'package:intl/intl.dart';
import 'package:sqllite_demo/services/todo_service.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  String? _selectedCategory;
  final List<DropdownMenuItem> _categories = [];

  getCategories() async {
    final categoryService = CategoryService();
    final categories = await categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        _categories.add(
          DropdownMenuItem(
            value: category['name'],
            child: Text(category['name']),
          ),
        );
      });
    });
  }

  _pickDate(BuildContext context) async {
    final today = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    setState(() {
      if (selectedDate != null) {
        final pickedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
        _dateController.text = pickedDate;
      }
    });
  }

  _showNewSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Todos'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 20,
        ),
        child: Column(children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: "Enter title of the todo",
              label: Text("Todo Title"),
            ),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              hintText: "Enter description of the todo",
              label: Text("Todo Description"),
            ),
          ),
          TextField(
            controller: _dateController,
            decoration: InputDecoration(
              prefixIcon: InkWell(
                onTap: () {
                  _pickDate(context);
                },
                child: const Icon(Icons.calendar_month),
              ),
              hintText: "Enter description of the todo",
              label: const Text("Pick a date"),
            ),
          ),
          DropdownButtonFormField(
            value: _selectedCategory,
            items: _categories,
            hint: const Text('Category'),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              final todoService = TodoService();
              if (_titleController.text.isNotEmpty &&
                  _descriptionController.text.isNotEmpty &&
                  _selectedCategory != null &&
                  _dateController.text.isNotEmpty) {
                final newTodo = Todos(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  category: _selectedCategory!,
                  todoDate: _dateController.text,
                  isFinished: 0,
                );
                final result = await todoService.saveTodo(newTodo);
                if (result > 0) {
                  _showNewSnackBar(context, "Created Todo!");
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                }
              } else {
                _showNewSnackBar(context, "Please enter all the fields");
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }
}
