import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/flashcard.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('flashcards.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE flashcards(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question TEXT,
        answer TEXT
      )
    ''');
  }

  Future<int> insertFlashcard(Flashcard flashcard) async {
    final db = await instance.database;

    return await db.insert('flashcards', flashcard.toMap());
  }

  Future<List<Flashcard>> getFlashcards() async {
    final db = await instance.database;

    final result = await db.query('flashcards');

    print(result);

    return result.map((json) => Flashcard.fromMap(json)).toList();
  }

  Future<int> updateFlashcard(Flashcard flashcard) async {
    final db = await instance.database;

    return db.update(
      'flashcards',
      flashcard.toMap(),
      where: 'id = ?',
      whereArgs: [flashcard.id],
    );
  }

  Future<int> deleteFlashcard(int id) async {
    final db = await instance.database;

    return await db.delete('flashcards', where: 'id = ?', whereArgs: [id]);
  }
}
