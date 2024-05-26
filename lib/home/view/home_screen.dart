import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:news_app_task/box.dart';
import 'package:news_app_task/home/controller/home_controller.dart';
import 'package:news_app_task/home/view/tab/all_news_tab.dart';
import 'package:news_app_task/home/view/tab/election_tab.dart';
import 'package:news_app_task/home/view/tab/entertainment_tab.dart';
import 'package:news_app_task/home/view/tab/sports_tab.dart';
import 'package:news_app_task/home/view/tab/stock_market_tab.dart';
import 'package:news_app_task/home/view/tab/top_headline_tab.dart';
import 'package:news_app_task/routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Scaffold(
      drawer: Drawer(
        shape: const ContinuousRectangleBorder(),
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            const Gap(50.0),
            ListTile(
              visualDensity: VisualDensity.compact,
              title: const Text("Dark mode"),
              trailing: Obx(() => Switch(
                    value: homeController.isDarkTheme.value,
                    onChanged: (value) =>
                        homeController.toggleThemeBrightness(value),
                  )),
            ),
            const Divider(),
            ListTile(
              visualDensity: VisualDensity.compact,
              title: const Text("Delete all saved"),
              onTap: () async {
                await boxArticle.clear();
              },
            ),
            const Divider(),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("News App"),
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(RoutePaths.search),
              icon: const Icon(Icons.search))
        ],
        bottom: TabBar(
            controller: homeController.tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            tabs: homeController.homeTab.map((e) => Tab(text: e)).toList()),
      ),
      body: TabBarView(
        controller: homeController.tabController,
        children: const [
          AllNewsTab(),
          TopHeadlineTab(),
          SportTab(),
          EntertainmentTab(),
          ElectionTab(),
          StockMarketTab(),
        ],
      ),
    );
  }
}
