import 'package:flutter/foundation.dart';

import '../models/Book.dart';
import '../services/book_service.dart';

class BookServiceProvider with ChangeNotifier {
  List<Book> _books = [];

  int pageIndex = 1;

  List<Book> get books => _books;

  void changePage(int index) {
    pageIndex = index + 10;
    notifyListeners();
  }

  Future<void> getBooks(String query, int startIndex) async {
    try {
      final List<Book> books = await BookService().getBooks(query, startIndex);

      if (startIndex == 1) {
        _books = books;
      } else {
        _books.addAll(books);
      }

      notifyListeners();
    } catch (e) {
      throw Exception(
          'Kitapları getirirken bir hata meydana geldi ${e.toString()}');
    }
  }
}
