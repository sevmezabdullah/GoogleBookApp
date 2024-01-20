import 'package:flutter/material.dart';
import 'package:googlebookapp/providers/books_provider.dart';

import 'package:provider/provider.dart';

class Books extends StatefulWidget {
  const Books({Key? key}) : super(key: key);

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<BookServiceProvider>(context, listen: false)
        .getBooks('subject=adventure');
  }

  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<BookServiceProvider>(
      builder: (context, bookService, child) {
        print(bookService.books.length);
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Search by book name, author or ISBN',
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      bookService.getBooks(_controller.text);
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // number of items per row
                  childAspectRatio: 3 / 2, // item width to height ratio
                  crossAxisSpacing: 10, // horizontal spacing between items
                  mainAxisSpacing: 10, // vertical spacing between items
                ),
                itemCount: bookService.books.length,
                itemBuilder: (context, index) {
                  final book = bookService.books[index];
                  return Card(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Expanded(
                          child: Image.network(
                            book.volumeInfo?.imageLinks?.thumbnail ??
                                'https://via.placeholder.com/200',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          color: Colors.black.withOpacity(0.6),
                          child: Text(
                            book.volumeInfo?.title ?? '',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {
                              // Add to favorites
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
