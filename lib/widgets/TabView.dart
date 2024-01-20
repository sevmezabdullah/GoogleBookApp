import 'package:flutter/material.dart';

class TabView extends StatelessWidget {
  const TabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
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
              Center(child: Text('Books')),
              Center(child: Text('Bookmarks')),
            ],
          ),
        ));
  }
}
