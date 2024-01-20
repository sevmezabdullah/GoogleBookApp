import 'package:flutter/material.dart';
import 'package:googlebookapp/providers/favorite_books_provider.dart';
import 'package:provider/provider.dart';

import '../../models/Book.dart';

class BookDetailPage extends StatefulWidget {
  final Book book;

  const BookDetailPage({Key? key, required this.book}) : super(key: key);

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.volumeInfo?.title ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (widget.book.volumeInfo?.imageLinks?.thumbnail != null)
                Image.network(widget.book.volumeInfo!.imageLinks!.thumbnail!),
              Text(
                'Author: ${widget.book.volumeInfo?.authors?.join(', ') ?? 'Unknown'}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(color: Colors.black),
              Text(
                'Description: ${widget.book.volumeInfo?.description ?? 'No description available'}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Consumer<FavoriteBooksProvider>(
        builder: (context, favoriteBookService, child) => FloatingActionButton(
          child: const Icon(Icons.favorite),
          onPressed: () {
            // Add to favorites

            // Provider.of<FavoriteBooksProvider>(context, listen: false).add(book);
            favoriteBookService.add(widget.book);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Added to favorites'),
              ),
            );
          },
        ),
      ),
    );
  }
}
