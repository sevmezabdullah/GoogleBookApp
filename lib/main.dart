import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googlebookapp/widgets/TabView.dart';

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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Books App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TabView());
  }
}
