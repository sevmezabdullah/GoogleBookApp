import 'package:dio/dio.dart';
import 'package:googlebookapp/models/Book.dart';

class BookService {
  Dio _dio;

  List<Book> books = [];

  BookService() : _dio = Dio() {
    _dio = Dio();
  }

  Future<List<Book>> getBooks(String query) async {
    try {
      Response response = await _dio.get(
        'https://www.googleapis.com/books/v1/volumes',
        queryParameters: {
          'q': query,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> items = response.data['items'];
        return items.map((item) => Book.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      throw Exception('Failed to load books: $e');
    }
  }
}
