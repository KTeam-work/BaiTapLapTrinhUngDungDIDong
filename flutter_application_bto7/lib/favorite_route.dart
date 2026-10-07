import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteRoute {
  final int? id;
  final String title;
  final String startAddress;
  final String endAddress;
  final double startLat;
  final double startLng;
  final double endLat;
  final double endLng;
  final String profile; // driving, bike, foot
  final String distance;
  final String duration;

  FavoriteRoute({
    this.id,
    required this.title,
    required this.startAddress,
    required this.endAddress,
    required this.startLat,
    required this.startLng,
    required this.endLat,
    required this.endLng,
    required this.profile,
    required this.distance,
    required this.duration,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'startAddress': startAddress,
      'endAddress': endAddress,
      'startLat': startLat,
      'startLng': startLng,
      'endLat': endLat,
      'endLng': endLng,
      'profile': profile,
      'distance': distance,
      'duration': duration,
    };
  }

  factory FavoriteRoute.fromMap(Map<String, dynamic> map) {
    return FavoriteRoute(
      id: map['id'],
      title: map['title'],
      startAddress: map['startAddress'],
      endAddress: map['endAddress'],
      startLat: map['startLat'],
      startLng: map['startLng'],
      endLat: map['endLat'],
      endLng: map['endLng'],
      profile: map['profile'],
      distance: map['distance'],
      duration: map['duration'],
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('favorite_routes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorite_routes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        startAddress TEXT NOT NULL,
        endAddress TEXT NOT NULL,
        startLat REAL NOT NULL,
        startLng REAL NOT NULL,
        endLat REAL NOT NULL,
        endLng REAL NOT NULL,
        profile TEXT NOT NULL,
        distance TEXT NOT NULL,
        duration TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertRoute(FavoriteRoute route) async {
    final db = await instance.database;
    return await db.insert('favorite_routes', route.toMap());
  }

  Future<List<FavoriteRoute>> getAllRoutes() async {
    final db = await instance.database;
    final result = await db.query('favorite_routes', orderBy: 'id DESC');
    return result.map((json) => FavoriteRoute.fromMap(json)).toList();
  }

  Future<int> deleteRoute(int id) async {
    final db = await instance.database;
    return await db.delete(
      'favorite_routes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}