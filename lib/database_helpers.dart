import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

// database table and column names
final String tableHappinessRecords = 'happiness_records';
final String columnId = '_id';
final String columnDateTime = 'date_time';
final String columnBlue = 'perceptie';
final String columnGreen = 'acceptatie';
final String columnYellow = 'visie';
final String columnRed = 'actie';
final String columnSituationDescr = 'situation';

// data model class
class HappinessRecord {
  int id;
  int date;
  double blueValue;
  double greenValue;
  double yellowValue;
  double redValue;
  String situation;

  HappinessRecord(this.date, this.blueValue, this.greenValue, this.yellowValue,
      this.redValue, this.situation);

  // convenience constructor to create a Happiness object
  HappinessRecord.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    date = map[columnDateTime];
    blueValue = map[columnBlue];
    greenValue = map[columnGreen];
    yellowValue = map[columnYellow];
    redValue = map[columnRed];
    situation = map[columnSituationDescr];
  }

  // convenience method to create a Map from this Happiness object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnDateTime: date,
      columnBlue: blueValue,
      columnGreen: greenValue,
      columnYellow: yellowValue,
      columnRed: redValue,
      columnSituationDescr: situation
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
  static final _databaseName = "HappinessMeterDB.db";

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
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute("DROP TABLE IF EXISTS $tableHappinessRecords");
    _onCreate(db, newVersion);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableHappinessRecords (
                $columnId INTEGER PRIMARY KEY,
                $columnDateTime INTEGER NOT NULL,
                $columnBlue DOUBLE NOT NULL,
                $columnGreen DOUBLE NOT NULL,
                $columnYellow DOUBLE NOT NULL,
                $columnRed DOUBLE NOT NULL,
                $columnSituationDescr TEXT
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(HappinessRecord record) async {
    Database db = await database;
    int id = await db.insert(tableHappinessRecords, record.toMap());
    debugPrint('inserted id: $id');
    return id;
  }

  Future<List<HappinessRecord>> getAllHappinessRecords() async {
    Database db = await database;
    String sql =
        "SELECT * FROM $tableHappinessRecords ORDER BY $columnDateTime DESC";

    var result = await db.rawQuery(sql);
    if (result.length == 0) return null;

    List<HappinessRecord> list = result.map((item) {
      return HappinessRecord.fromMap(item);
    }).toList();

    print(result);
    return list;
  }

  Future<HappinessRecord> queryHappinessRecord(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableHappinessRecords,
        columns: [
          columnId,
          columnDateTime,
          columnBlue,
          columnGreen,
          columnYellow,
          columnRed,
          columnSituationDescr
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return HappinessRecord.fromMap(maps.first);
    }
    return null;
  }

  Future<void> deleteRecord(id) async {
    Database db = await database;
    db.delete(tableHappinessRecords, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    Database db = await database;
    db.delete(tableHappinessRecords);
  }
}
