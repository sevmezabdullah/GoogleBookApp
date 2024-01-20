import 'package:flutter/foundation.dart';
import 'package:googlebookapp/models/Book.dart';
import 'package:googlebookapp/services/book_database_service.dart';

class FavoriteBooksProvider extends ChangeNotifier {
  List<Book> _favorites = [];

  List<Book> get favorites => _favorites;
  final DatabaseService _databaseService = DatabaseService();

  void add(Book book) {
    _favorites.add(book);
    _databaseService.addBookToFavorites(book);
    notifyListeners();
  }

  void remove(Book book) {
    _favorites.remove(book);
    _databaseService.removeBookFromFavorites(book);
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    _favorites = await _databaseService.getFavoriteBooks();
    notifyListeners();
  }
}
