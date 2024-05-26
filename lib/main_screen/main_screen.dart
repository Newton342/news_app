import 'package:flutter/material.dart';
import 'package:news_app_task/home/view/home_screen.dart';
import 'package:news_app_task/saved_article/view/saved_article_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  Widget _buildWidget(int i) {
    switch (i) {
      case 0:
        return const HomeScreen();
      case 1:
        return const SavedArticleScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: IndexedStack(
      //   index: _selectedIndex,
      //   children: const [HomeScreen(), SavedArticleScreen()],
      // ),
      body: _buildWidget(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_outlined),
            label: 'Saved atricles',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (value) => setState(() => _selectedIndex = value),
      ),
    );
  }
}
