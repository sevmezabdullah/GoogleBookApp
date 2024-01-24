import 'package:flutter/material.dart';
import 'package:googlebookapp/features/books/book_detail_view.dart';
import 'package:googlebookapp/providers/books_provider.dart';

import 'package:provider/provider.dart';

class Books extends StatefulWidget {
  const Books({Key? key}) : super(key: key);

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  final _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  int pageIndex = 1;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookServiceProvider>(context, listen: false).getBooks(
          'javascript',
          Provider.of<BookServiceProvider>(context, listen: false).pageIndex);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Provider.of<BookServiceProvider>(context, listen: false)
            .changePage(++pageIndex);
        loadMore();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    Provider.of<BookServiceProvider>(context, listen: false).getBooks(
        '${_controller.text}',
        Provider.of<BookServiceProvider>(context, listen: false).pageIndex);
  }

  void loadMore() {
    print(
        "index artırıldı ${Provider.of<BookServiceProvider>(context, listen: false).pageIndex}");
    Provider.of<BookServiceProvider>(context, listen: false).getBooks(
        '${_controller.text}',
        Provider.of<BookServiceProvider>(context, listen: false).pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookServiceProvider>(
      builder: (context, bookService, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                onChanged: (text) {
                  _onSearchChanged();
                },
                decoration: InputDecoration(
                  labelText: 'Search by book name',
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      bookService.getBooks('${_controller.text}', pageIndex);
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
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // number of items per row
                  childAspectRatio: 3 / 2, // item width to height ratio
                  crossAxisSpacing: 10, // horizontal spacing between items
                  mainAxisSpacing: 15, // vertical spacing between items
                ),
                itemCount: bookService.books.length,
                itemBuilder: (context, index) {
                  final book = bookService.books[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return BookDetailPage(book: book);
                          },
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              book.volumeInfo?.imageLinks?.thumbnail ??
                                  'https://via.placeholder.com/150',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              book.volumeInfo?.title ?? 'No title',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
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
