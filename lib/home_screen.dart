import 'package:flutter/material.dart';
import 'package:sqllite_demo/helpers/drawar_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoList Sqflite'),
      ),
      drawer: const DrawerNavigation(),
      body: const Center(
        child: Text('MyApp'),
      ),
    );
  }
}
