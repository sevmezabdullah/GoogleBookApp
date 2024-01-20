import 'package:flutter/material.dart';
import 'package:googlebookapp/providers/favorite_books_provider.dart';
import 'package:provider/provider.dart';

class BookMarks extends StatefulWidget {
  const BookMarks({Key? key}) : super(key: key);

  @override
  State<BookMarks> createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FavoriteBooksProvider>(context, listen: false).loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteBooksProvider>(
      builder: (context, favoriteBooksProvider, child) {
        var favoriteBooks = favoriteBooksProvider.favorites;
        print(favoriteBooks);
        return ListView.builder(
          itemCount: favoriteBooks.length,
          itemBuilder: (context, index) {
            var book = favoriteBooks[index];

            return ListTile(
              title: Text(book.title),
              leading: Image.network(book.imageLink),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  print(book.id);

                  Provider.of<FavoriteBooksProvider>(context, listen: false)
                      .remove(book);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Removed from favorites"),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              ),
              // Diğer özellikleri burada da listeleyebilirsiniz.
            );
          },
        );
      },
    );
  }
}
