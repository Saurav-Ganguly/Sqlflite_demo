import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  setDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'db_todolist_sqflite');
    final database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);

    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    //creating the categories table
    await database.execute(
        'CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT, description TEXT)');

    //creating the todos table
    await database.execute(
        'CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT, category TEXT, todoDate TEXT, isFinished INTEGER)');
  }
}
