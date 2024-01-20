import 'package:flutter/foundation.dart';

import '../models/Book.dart';
import '../services/book_service.dart';

class BookServiceProvider with ChangeNotifier {
  List<Book> _books = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Book> get books => _books;

  Future<void> getBooks(String query) async {
    try {
      _isLoading = true;
      notifyListeners();
      final List<Book> books = await BookService().getBooks(query);
      _books = books;
      notifyListeners();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      throw Exception('Kitapları getirirken bir hata meydana geldi $e');
    }
  }
}
