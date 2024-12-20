import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tomatin/data/models/detection_history.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'detection_history.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE detection_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        plantName TEXT,
        status TEXT,
        imagePath TEXT,
        detectionDate TEXT
        isInCollection INTEGER DEFAULT 0
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        ALTER TABLE detection_history ADD COLUMN isInCollection INTEGER DEFAULT 0
      ''');
    }
  }

  Future<int> insertDetectionHistory(DetectionHistory history) async {
    Database db = await database;
    return await db.insert('detection_history', history.toMap());
  }

  Future<List<DetectionHistory>> getDetectionHistory() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('detection_history');
    return List.generate(maps.length, (i) {
      return DetectionHistory.fromMap(maps[i]);
    });
  }

  Future<List<DetectionHistory>> getCollection() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'detection_history',
      where: 'isInCollection = ?',
      whereArgs: [1],
    );
    return List.generate(maps.length, (i) {
      return DetectionHistory.fromMap(maps[i]);
    });
  }
}
