import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_task/adapter/article.dart';
import 'package:news_app_task/adapter/source.dart';
import 'package:news_app_task/box.dart';
import 'package:news_app_task/enums/common_enums.dart';
import 'package:news_app_task/routes/routes.dart';
import 'package:news_app_task/search/controller/serach_controller.dart';
import 'package:news_app_task/widgets/news_article_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchCtrl = Get.put(SearchScreenController());
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(hintText: "Search News"),
          onSubmitted: (value) => searchCtrl.serachNews(value),
        ),
      ),
      body: GetBuilder<SearchScreenController>(
        builder: (SearchScreenController controller) {
          return controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.searchedData.isEmpty
                  ? const Center(
                      child: Text("No data"),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      itemBuilder: (context, index) {
                        final data = controller.searchedData[index];
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
                                  "key_search$index",
                                  Article(
                                      title: data.title,
                                      source: Source(name: data.source?.name),
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
                      itemCount: controller.searchedData.length);
        },
      ),
    );
  }
}
