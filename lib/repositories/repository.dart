import 'package:sqflite/sqflite.dart';
import 'package:sqllite_demo/repositories/database_connection.dart';

class Repository {
  late DatabaseConnection _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database> get database async {
    //if _database has value then return _database
    //else return _databaseConnection.setDatabase()
    return _database ?? await _databaseConnection.setDatabase();
  }

  inserData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  readDataById(table, id) async {
    var connection = await database;
    return await connection.query(table, where: 'id=?', whereArgs: [id]);
  }

  updateCategory(table, data) async {
    var connection = await database;
    return await connection
        .update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  deleteCategory(table, id) async {
    var connection = await database;
    return await connection.rawDelete('DELETE FROM $table WHERE id = $id');
  }
}
