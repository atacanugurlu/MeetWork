import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'MWDatabase.db'),
        onCreate: (db, version) async {
      await db.execute("CREATE TABLE cardInfo ("
          "name TEXT PRIMARY KEY,"
          "title TEXT,"
          "company TEXT,"
          "phone TEXT,"
          "email TEXT,"
          "website TEXT,"
          "linkedin TEXT,"
          ")");
    });
  }
}
