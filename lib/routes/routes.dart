import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:news_app_task/article/view/article_screen.dart';
import 'package:news_app_task/home/view/home_screen.dart';
import 'package:news_app_task/main_screen/main_screen.dart';
import 'package:news_app_task/search/view/search_screen.dart';

class RoutePaths {
  static const mainScreen = '/';
  static const home = '/home';
  static const article = '/article';
  static const search = '/search';
}

class Routes {
  static final routes = <GetPage>[
    GetPage(name: RoutePaths.mainScreen, page: () => const MainScreen()),
    GetPage(name: RoutePaths.home, page: () => const HomeScreen()),
    GetPage(
        name: RoutePaths.article,
        page: () => const ArticleScreen(),
        curve: Curves.fastOutSlowIn,
        transition: Transition.leftToRight),
    GetPage(
      name: RoutePaths.search,
      page: () => const SearchScreen(),
      curve: Curves.fastOutSlowIn,
      transition: Transition.rightToLeft,
    )
  ];
}
