import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
final String tableHappinessRecords = 'happiness_records';
final String columnId = '_id';
final String columnPerceptie = 'perceptie';
final String columnAcceptatie = 'acceptatie';
final String columnVisie = 'visie';
final String columnActie = 'actie';

// data model class
class HappinessRecord {
  int id;
  String date;
  double perceptie;
  double acceptatie;
  double visie;
  double actie;

  HappinessRecord();

  // convenience constructor to create a Word object
  HappinessRecord.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    perceptie = map[columnPerceptie];
    acceptatie = map[columnAcceptatie];
    visie = map[columnVisie];
    actie = map[columnActie];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnPerceptie: perceptie,
      columnAcceptatie: acceptatie,
      columnVisie: visie,
      columnActie: actie
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

// singleton class to manage the database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";

  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableHappinessRecords (
                $columnId INTEGER PRIMARY KEY,
                $columnPerceptie DOUBLE NOT NULL,
                $columnAcceptatie DOUBLE NOT NULL,
                $columnVisie DOUBLE NOT NULL,
                $columnActie DOUBLE NOT NULL
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(HappinessRecord word) async {
    Database db = await database;
    int id = await db.insert(tableHappinessRecords, word.toMap());
    return id;
  }

  Future<HappinessRecord> queryWord(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableHappinessRecords,
        columns: [
          columnId,
          columnPerceptie,
          columnAcceptatie,
          columnVisie,
          columnActie
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return HappinessRecord.fromMap(maps.first);
    }
    return null;
  }

// TODO: queryAllWords()
// TODO: delete(int id)
// TODO: update(Word word)
}
