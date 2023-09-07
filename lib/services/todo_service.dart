import 'package:sqllite_demo/modals/todo.dart';
import 'package:sqllite_demo/repositories/repository.dart';

class TodoService {
  late Repository _repository;

  TodoService() {
    _repository = Repository();
  }

  saveTodo(Todos todo) async {
    return await _repository.insertData('todos', todo.todoMap());
  }

  readTodos() async {
    return await _repository.readData('todos');
  }

  readTodoByCategory(categoryValue) async {
    return await _repository.readDataByColumn(
        'todos', 'category', categoryValue);
  }

  checkTodo(id, value) async {
    return await _repository.updateDataOfColumnById(
        'todos', 'isFinished', value, id);
  }
}
