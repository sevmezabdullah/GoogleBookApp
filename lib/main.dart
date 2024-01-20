import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googlebookapp/widgets/TabView.dart';

void main() {
  runApp(BooksApp());
}

class BooksApp extends StatelessWidget {
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
