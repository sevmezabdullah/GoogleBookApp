import 'package:flutter/foundation.dart';

import '../models/Book.dart';
import '../services/book_service.dart';

class BookServiceProvider with ChangeNotifier {
  List<Book> _books = [];

  List<Book> get books => _books;

  Future<void> getBooks(String query) async {
    try {
      final List<Book> books = await BookService().getBooks(query);
      _books = books;
      notifyListeners();
    } catch (e) {
      throw Exception('Kitapları getirirken bir hata meydana geldi $e');
    }
  }
}
