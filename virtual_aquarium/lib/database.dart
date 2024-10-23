import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AquariumDatabase{
  //create database to store settings
  static final AquariumDatabase instance = AquariumDatabase._init();
  static Database? _database;

  AquariumDatabase._init();

  //getter for database
  Future<Database> get database async {
    //if database exists then return 
    if (_database != null) return _database!;
    //else create database
    _database = await _initDB('aquarium.db');
    return _database!;
  }

  //init db
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }
  //create db
  Future _createDB(Database db, int version) async {
    //create table for fish
    const fishTable = '''
    CREATE TABLE fish(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      color INTEGER NOT NULL,
      speed REAL NOT NULL
    )
    ''';

    //store settings for speed
    const settingsTable = '''
    CREATE TABLE settings(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      speed REAL NOT NULL
    )
    ''';
    
    await db.execute(fishTable);
    await db.execute(settingsTable);
  }
  //save fish
  Future<void> saveFish(int color, double speed) async {
    final db = await instance.database;
    final fish = {'color': color, 'speed': speed};
    await db.insert('fish', fish);
  }
  //insert fish
  Future<List<Map<String, dynamic>>> getFishList() async {
    final db = await instance.database;
    return await db.query('fish');
  }
  //save speed
  Future<void> saveSpeed(double speed) async {
    final db = await instance.database;
    await db.delete('settings');
    await db.insert('settings', {'speed': speed});
  }
  //load speed
  Future<double?> getSpeed() async {
    final db = await instance.database;
    final result = await db.query('settings', limit: 1);
    if (result.isNotEmpty) {
      return result.first['speed'] as double;
    }
    return null;
  }
  //clear fish
  Future<int> clearFish() async {
    final db = await instance.database;
    return await db.delete('fish');
  }
  //close db
  Future close() async {
    final db = await instance.database;
    db.close();
  }




}