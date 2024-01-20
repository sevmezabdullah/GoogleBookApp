import 'package:flutter/material.dart';
import 'package:googlebookapp/features/bookmarks/bookmarks_view.dart';
import 'package:googlebookapp/features/books/books_view.dart';

class TabView extends StatelessWidget {
  const TabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Books App'),
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.book)),
                  Tab(icon: Icon(Icons.bookmark)),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                Books(),
                BookMarks(),
              ],
            ),
          ),
        ));
  }
}
