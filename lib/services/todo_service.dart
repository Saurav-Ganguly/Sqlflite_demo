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

  // readCategoryById(int categoryId) async {
  //   return await _repository.readDataById('categories', categoryId);
  // }

  // updateCategory(Category category) async {
  //   return await _repository.updateCategory(
  //       'categories', category.categoryMap());
  // }

  // deleteCategory(int id) async {
  //   return await _repository.deleteCategory('categories', id);
  // }
}
