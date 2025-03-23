import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();
  factory LocalDatabase() => _instance;
  static Database? _database;

  LocalDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'spacex_rockets.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    print('Creating database with version $version');
    await db.execute('''
    CREATE TABLE rockets(
      id TEXT PRIMARY KEY,
      name TEXT,
      type TEXT,
      active INTEGER,
      stages INTEGER,
      boosters INTEGER,
      cost_per_launch REAL,
      success_rate_pct REAL,
      first_flight TEXT,
      country TEXT,
      company TEXT,
      wikipedia TEXT,
      description TEXT,
      flickr_images TEXT,
      height TEXT,
      diameter TEXT,
      mass TEXT,
      first_stage TEXT,
      second_stage TEXT,
      engines TEXT,
      landing_legs TEXT,
      payload_weights TEXT
    )
  ''');
    print('Database created successfully');
  }

  Future<void> insertRocket(Map<String, dynamic> rocket) async {
    final db = await database;
    await db.insert('rockets', {
      'id': rocket['id'],
      'name': rocket['name'],
      'type': rocket['type'],
      'active': rocket['active'] ? 1 : 0,
      'stages': rocket['stages'],
      'boosters': rocket['boosters'],
      'cost_per_launch': rocket['cost_per_launch']?.toDouble(),
      'success_rate_pct': rocket['success_rate_pct']?.toDouble(),
      'first_flight': rocket['first_flight'],
      'country': rocket['country'],
      'company': rocket['company'],
      'wikipedia': rocket['wikipedia'],
      'description': rocket['description'],
      'flickr_images': jsonEncode(rocket['flickr_images']),
      'height': jsonEncode(rocket['height']),
      'diameter': jsonEncode(rocket['diameter']),
      'mass': jsonEncode(rocket['mass']),
      'first_stage': jsonEncode(rocket['first_stage']),
      'second_stage': jsonEncode(rocket['second_stage']),
      'engines': jsonEncode(rocket['engines']),
      'landing_legs': jsonEncode(rocket['landing_legs']),
      'payload_weights': jsonEncode(rocket['payload_weights']),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getRockets() async {
    final db = await database;
    return await db.query('rockets');
  }

  Future<Map<String, dynamic>?> getRocketById(String id) async {
    final db = await database;
    final result = await db.query('rockets', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }
}