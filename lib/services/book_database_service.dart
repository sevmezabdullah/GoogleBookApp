import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/Book.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  _initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'book.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
    CREATE TABLE favorite_books (
    id TEXT PRIMARY KEY,
    title TEXT,
    authors TEXT,
    description TEXT,
    imageLink TEXT
  )
''');
    });
  }

  Future<void> addBookToFavorites(Book book) async {
    final db = await database;
    await db.insert(
      'favorite_books',
      {
        "id": book.id,
        "title": book.volumeInfo?.title ?? '',
        "authors": book.volumeInfo?.authors?.join(', ') ?? '',
        "description": book.volumeInfo?.description ?? '',
        "imageLink": book.volumeInfo?.imageLinks?.thumbnail ?? ''
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Book>> getFavoriteBooks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorite_books');

    print(maps);
    return List.generate(maps.length, (i) {
      return Book.fromJson(maps[i]);
    });
  }

  Future<void> removeBookFromFavorites(Book book) async {
    final db = await database;
    await db.delete(
      'favorite_books',
      where: "id = ?",
      whereArgs: [book.id],
    );
  }
}
