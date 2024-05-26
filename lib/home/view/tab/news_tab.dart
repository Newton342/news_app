import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_task/home/controller/home_controller.dart';

//######################### Unused screen remove it#######################
class NewsTab extends StatelessWidget {
  const NewsTab({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (HomeController controller) {
      return RefreshIndicator(
        onRefresh: () async {},
        child: Center(
          child: ElevatedButton(
              onPressed: () {
                // controller.getData();
              },
              child: Text(title)),
        ),
      );
    });
  }
}
