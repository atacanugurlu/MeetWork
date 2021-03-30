import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:meetwork/business_card_data.dart';

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
      await db.execute('''
        CREATE TABLE businessCardsTable (
          name TEXT PRIMARY KEY,
          title TEXT,
          company TEXT,
          phone TEXT,
          email TEXT,
          website TEXT,
          linkedin TEXT,
          )
          ''');
    }, version: 1);
  }

  newBusinessCard(BusinessCardInfo newBusinessCard) async {
    final db = await database;
    var res = await db.rawInsert('''
      INSERT INTO businessCardsTable (
        name,
        title,
        company,
        phone,
        email,
        website,
        linkedin
        ) VALUES (?, ?, ?, ?, ?, ?, ?)
    ''', [
      newBusinessCard.name,
      newBusinessCard.title,
      newBusinessCard.company,
      newBusinessCard.phone,
      newBusinessCard.email,
      newBusinessCard.website,
      newBusinessCard.linkedin
    ]);
    return res;
  }

  Future<dynamic> getCard() async {
    final db = await database;
    var res = await db.query("businessCardsTable");
    if (res.length == 0) {
      return null;
    } else {
      var resMap = res[0];
      return resMap.isNotEmpty ? resMap : Null;
    }
  }
}
