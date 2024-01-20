class Book {
  final String title;
  final String author;
  final String description;

  Book({required this.title, required this.author, required this.description});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['volumeInfo']['title'],
      author: (json['volumeInfo']['authors'] as List).join(', '),
      description: json['volumeInfo']['description'],
    );
  }
}
