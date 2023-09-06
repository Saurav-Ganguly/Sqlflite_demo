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
    await database.execute(
        'CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT, description TEXT)');
  }
}
