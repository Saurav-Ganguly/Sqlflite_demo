import 'package:flutter/material.dart';
import 'package:sqllite_demo/home_screen.dart';
import 'package:sqllite_demo/modals/category.dart';
import 'package:sqllite_demo/services/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _categoryService = CategoryService();
  final _categoryNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<Category> _categoryList = [];

  getAllCategories() async {
    var categories = await _categoryService.readCategories();

    for (final category in categories) {
      Category newCategory = Category(
        id: category['id'],
        name: category['name'],
        description: category['description'],
      );
      setState(() {
        _categoryList.add(newCategory);
      });
    }
  }

  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Categories Form'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _categoryNameController,
                    decoration: const InputDecoration(
                      hintText: 'title',
                      labelText: 'Category',
                    ),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'enter a description',
                      labelText: 'Description',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                    Colors.red,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                    Colors.blue,
                  ),
                ),
                onPressed: () async {
                  final category = _categoryNameController.text;
                  final description = _descriptionController.text;

                  if (category.isNotEmpty && description.isNotEmpty) {
                    final newCategory =
                        Category(name: category, description: description);

                    final categoryService = CategoryService();
                    categoryService.saveCategory(newCategory);

                    final result =
                        await _categoryService.saveCategory(newCategory);

                    Navigator.pop(context);
                  } else {
                    const snackBar = SnackBar(
                      content: Text('Please enter the data'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showFormDialog(context);
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            leading: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.arrow_back,
              ),
            ),
            title: const Text('Categories'),
          ),
          body: ListView.builder(
            itemCount: _categoryList.length,
            itemBuilder: ((context, index) {
              final categoryItem = _categoryList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: ListTile(
                      leading: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {},
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(categoryItem.name),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                      subtitle: Text(
                        categoryItem.description,
                      ),
                    ),
                  ),
                ),
              );
            }),
          )),
    );
  }
}
