import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_task/adapter/article.dart';
import 'package:news_app_task/adapter/source.dart';
import 'package:news_app_task/box.dart';
import 'package:news_app_task/data/getbuilder_ids.dart';
import 'package:news_app_task/enums/common_enums.dart';
import 'package:news_app_task/home/controller/home_controller.dart';
import 'package:news_app_task/routes/routes.dart';
import 'package:news_app_task/widgets/news_article_card.dart';

class EntertainmentTab extends StatelessWidget {
  const EntertainmentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: GetBuilderId.entertainment,
        builder: (HomeController controller) {
          return controller.isLoadingEntertainment
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.entertainmentData.isEmpty
                  ? const Center(
                      child: Text("No data"),
                    )
                  : NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollEndNotification &&
                            notification.metrics.extentAfter == 0) {
                          controller.entertainmentPagination();
                        }
                        return false;
                      },
                      child: ListView.separated(
                          key: const PageStorageKey(GetBuilderId.entertainment),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          itemBuilder: (context, index) {
                            final data = controller.entertainmentData[index];
                            return NewsArticleCard(
                                cardType: CardType.save,
                                onPressed: () => Get.toNamed(RoutePaths.article,
                                        parameters: {
                                          "title": data.title ?? "",
                                          "source": data.source?.name ?? "",
                                          "imageUrl": data.urlToImage ?? "",
                                          "content": data.content ?? "",
                                          "description": data.description ?? "",
                                          "publishedAt": data.publishedAt ?? ""
                                        }),
                                saveCallback: () {
                                  boxArticle.put(
                                      "key_entertainment$index",
                                      Article(
                                          title: data.title,
                                          source:
                                              Source(name: data.source?.name),
                                          urlToImage: data.urlToImage,
                                          content: data.content,
                                          description: data.description,
                                          publishedAt: data.publishedAt));
                                },
                                imageUrl: data.urlToImage,
                                source: data.source?.name ?? "",
                                title: data.title ?? "");
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: controller.entertainmentData.length),
                    );
        });
  }
}
