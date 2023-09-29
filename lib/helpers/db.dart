import 'package:mycashbook/model/Account.dart';
import 'package:mycashbook/model/Cash.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late Database _database;
  static DatabaseHelper? _databaseHelper;
  static const String _tableName = 'cash';
  static const String _accountTable = 'account';
  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      ('$path/cashbook.db'),
      onCreate: (db, version) async {
        print("object");
        await db.execute(
          '''CREATE TABLE $_accountTable (
              id TEXT PRIMARY KEY,
              password TEXT
             );''',
        );
        await db.execute(
          '''CREATE TABLE $_tableName (
              id TEXT PRIMARY KEY,
              nominal INTEGER,
              keterangan TEXT,
              date TEXT,
              isAdd BOOLEAN
             );''',
        );
      },
      version: 2,
    );

    return db;
  }

  Future<void> insertCash(Cash cash) async {
    final Database db = await database;
    await db.insert(_tableName, cash.toMap());
  }

  Future<List<Cash>> getCash() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);
    return results.map((cash) => Cash.fromMap(cash)).toList();
  }

  Future<String> getTotalPemasukan() async {
    final Database db = await database;
    final result = await db
        .rawQuery("SELECT SUM(nominal) FROM $_tableName WHERE isAdd = 0");
    return result.isNotEmpty ? result[0]["SUM(nominal)"].toString() : "0";
  }

  Future<String> getTotalPengeluaran() async {
    final Database db = await database;
    final result = await db
        .rawQuery("SELECT SUM(nominal) FROM $_tableName WHERE isAdd = 1");

    return result.isNotEmpty ? result[0]["SUM(nominal)"].toString() : "0";
  }

  Future<bool> getPassword(String password) async {
    final Database db = await database;
    var result = await db.rawQuery(
        "SELECT password FROM account WHERE password =?", ['$password']);

    return result.isNotEmpty;
  }

  Future<List<Account>> getAllPassword() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_accountTable);
    return results.map((acc) => Account.fromMap(acc)).toList();
  }

  Future<void> updatePassword(String oldPass, String newPass) async {
    final db = await database;

    await db.rawUpdate(
        "UPDATE ${_accountTable} SET password = ? WHERE password = ?",
        [newPass, oldPass]);
  }

  Future<void> createPassword(Account acc) async {
    final Database db = await database;
    await db.insert(_accountTable, acc.toMap());
    List<Map<String, dynamic>> results = await db.query(_accountTable);
    print(results);
  }
}
