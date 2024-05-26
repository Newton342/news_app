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

class TopHeadlineTab extends StatelessWidget {
  const TopHeadlineTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: const [GetBuilderId.topHeadline],
        builder: (HomeController controller) {
          return controller.isLoadingTopHeadline
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.topHeadLineData.isNotEmpty
                  ? NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollEndNotification &&
                            notification.metrics.extentAfter == 0) {
                          controller.topHeadlinePagination();
                        }
                        return false;
                      },
                      child: ListView.separated(
                        key: const PageStorageKey(GetBuilderId.topHeadline),
                        itemBuilder: (context, index) {
                          final data = controller.topHeadLineData[index];
                          return NewsArticleCard(
                            cardType: CardType.save,
                            onPressed: () =>
                                Get.toNamed(RoutePaths.article, parameters: {
                              "title": data.title ?? "",
                              "source": data.source?.name ?? "",
                              "imageUrl": data.urlToImage ?? "",
                              "content": data.content ?? "",
                              "description": data.description ?? "",
                              "publishedAt": data.publishedAt ?? ""
                            }),
                            saveCallback: () {
                              boxArticle.put(
                                  "key_top_headline$index",
                                  Article(
                                      title: data.title,
                                      source: Source(name: data.source?.name),
                                      urlToImage: data.urlToImage,
                                      content: data.content,
                                      description: data.description,
                                      publishedAt: data.publishedAt));
                            },
                            source: data.source?.name ?? "",
                            title: data.title ?? "",
                            imageUrl: data.urlToImage,
                          );
                        },
                        itemCount: controller.topHeadLineData.length,
                        separatorBuilder: (context, index) => const Divider(),
                      ),
                    )
                  : const Center(
                      child: Text("No news"),
                    );
        });
  }
}
