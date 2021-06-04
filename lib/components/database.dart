import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:meetwork/screens/sub_screens/business_screens/business_card_class.dart';

class DatabaseHelper {
  static Database _database;

  String _cardsTable = "cards";
  String _columnID = "cardID";
  String _columnName = "name";
  String _columnTitle = "title";
  String _columnCompany = "company";
  String _columnPhone = "phone";
  String _columnEmail = "email";
  String _columnWebsite = "website";
  String _columnLinkedin = "linkedin";

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    String dbPath = join(await getDatabasesPath(), "cards.db");
    var cardsDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return cardsDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table $_cardsTable($_columnID integer primary key, $_columnName text, $_columnTitle text, $_columnCompany text, $_columnPhone text, $_columnEmail text, $_columnWebsite text, $_columnLinkedin text)");
  }

  Future<List<BusinessCardInfo>> getAllCards() async {
    Database db = await this.database;
    var result = await db.query("$_cardsTable");
    return List.generate(result.length, (i) {
      return BusinessCardInfo.fromMap(result[i]);
    });
  }

  Future<int> insert(BusinessCardInfo card) async {
    Database db = await this.database;
    var result = await db.insert("$_cardsTable", card.toMap());
    return result;
  }

  Future<int> update(BusinessCardInfo card) async {
    Database db = await this.database;
    var result = await db.update("$_cardsTable", card.toMap(),
        where: "id=?", whereArgs: [card.cardID]);
    return result;
  }

  Future<int> delete(int cardID) async {
    Database db = await this.database;
    var result =
        await db.rawDelete("delete from $_cardsTable where id=$cardID");
    return result;
  }
}
