import 'package:sqllite_demo/modals/category.dart';
import 'package:sqllite_demo/repositories/repository.dart';

class CategoryService {
  late Repository _repository;

  CategoryService() {
    _repository = Repository();
  }

  saveCategory(Category category) async {
    return await _repository.inserData('categories', category.categoryMap());
  }

  readCategories() async {
    return await _repository.readData('categories');
  }

  readCategoryById(int categoryId) async {
    return await _repository.readDataById('categories', categoryId);
  }

  updateCategory(Category category) async {
    return await _repository.updateCategory(
        'categories', category.categoryMap());
  }

  deleteCategory(int id) async {
    return await _repository.deleteCategory('categories', id);
  }
}
