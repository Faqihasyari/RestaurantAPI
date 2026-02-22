import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = 'restaurant.db';
  static const _databaseVersion = 1;

  static const tableFavorite = 'favorites';

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnCity = 'city';
  static const columnPictureId = 'pictureId';
  static const columnRating = 'rating';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableFavorite (
        $columnId TEXT PRIMARY KEY,
        $columnName TEXT,
        $columnCity TEXT,
        $columnPictureId TEXT,
        $columnRating REAL
      )
    ''');
  }

  Future<void> insertFavorite(Map<String, dynamic> restaurant) async {
    final db = await database;
    await db.insert(
      tableFavorite,
      restaurant,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    return await db.query(tableFavorite);
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;
    await db.delete(tableFavorite, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<bool> isFavorite(String id) async {
    final db = await database;
    final result = await db.query(
      tableFavorite,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }
}
