import 'dart:async';
import 'package:core/utils/encrypt.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:movie/data/models/movie_table.dart';
import 'package:tv/data/models/tv_table.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _movieTblWatchlist = 'movieWatchlist';
  static const String _tvTblWatchlist = 'tvWatchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      password: encrypt('Your secure password...'),
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_movieTblWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE  $_tvTblWatchlist (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  // movie
  Future<int> insertMovieWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_movieTblWatchlist, movie.toJson());
  }

  Future<int> removeMovieWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _movieTblWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _movieTblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_movieTblWatchlist);

    return results;
  }

  // tv Show
  Future<int> insertTvWatchlist(TvTable tv) async {
    final db = await database;
    return await db!.insert(_tvTblWatchlist, tv.toJson());
  }

  Future<int> removeTvWatchlist(TvTable tv) async {
    final db = await database;
    return await db!.delete(
      _tvTblWatchlist,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await database;
    final result = await db!.query(
      _tvTblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTv() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db!.query(_tvTblWatchlist);

    return result;
  }
}
