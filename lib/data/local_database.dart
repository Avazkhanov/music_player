import 'package:flutter/material.dart';
import 'package:music_player/data/models/favorite_music_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();
  static Database? _database;

  LocalDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('favorite_music.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE favorite_music (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      music_id INTEGER NOT NULL
    )
    ''');
  }

  static Future<FavoriteMusicModel> create(
      FavoriteMusicModel favoriteMusic) async {
    final db = await instance.database;

    final id = await db.insert('favorite_music', favoriteMusic.toJson());
    debugPrint("============================================================CREATE=====================");
    return favoriteMusic.copyWith(id: id);
  }

 static Future<bool> readFavoriteMusic(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'favorite_music',
      columns: ['id', 'music_id'],
      where: 'music_id = ?',
      whereArgs: [id],
    );
    debugPrint('MAPS============================================================$maps');
    if (maps.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<FavoriteMusicModel>> readAllFavoriteMusic() async {
    final db = await instance.database;

    final result = await db.query('favorite_music');

    return result.map((json) => FavoriteMusicModel.fromJson(json)).toList();
  }

  static Future<int> update(FavoriteMusicModel favoriteMusic) async {
    final db = await instance.database;

    return db.update(
      'favorite_music',
      favoriteMusic.toJson(),
      where: 'id = ?',
      whereArgs: [favoriteMusic.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await instance.database;
    debugPrint("============================================================DELETE================================");
    return await db.delete(
      'favorite_music',
      where: 'music_id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
