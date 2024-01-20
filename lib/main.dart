import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googlebookapp/providers/books_provider.dart';
import 'package:googlebookapp/widgets/TabView.dart';
import 'package:provider/provider.dart';

import 'providers/favorite_books_provider.dart';

void main() {
  runApp(const BooksApp());
}

class BooksApp extends StatelessWidget {
  const BooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoriteBooksProvider()),
        ChangeNotifierProvider(create: (context) => BookServiceProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Books App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TabView(),
      ),
    );
  }
}
