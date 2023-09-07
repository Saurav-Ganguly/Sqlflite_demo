import 'package:flutter/material.dart';
import 'package:sqllite_demo/categories_screen.dart';
import 'package:sqllite_demo/home_screen.dart';
import 'package:sqllite_demo/services/category_service.dart';
import 'package:sqllite_demo/todo_by_category.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({super.key});

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> _categories = [];

  getAllCategories() async {
    final categoryService = CategoryService();
    final categories = await categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        _categories.add(InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TodoByCategory(
                  categoryValue: category['name'],
                ),
              ),
            );
          },
          child: ListTile(
            //leading: const Icon(Icons.category),
            title: Text(category['name']),
          ),
        ));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://picsum.photos/200/300?grayscale',
                ),
              ),
              accountName: Text("Saurav Ganguly"),
              accountEmail: Text('hisauravganguly@gmail.com'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.view_list),
              title: const Text('Categories'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CategoriesScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            Column(
              children: _categories,
            ),
          ],
        ),
      ),
    );
  }
}
