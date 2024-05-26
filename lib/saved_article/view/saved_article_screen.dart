import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:news_app_task/adapter/article.dart';
import 'package:news_app_task/box.dart';
import 'package:news_app_task/enums/common_enums.dart';
import 'package:news_app_task/routes/routes.dart';
import 'package:news_app_task/widgets/news_article_card.dart';

class SavedArticleScreen extends StatefulWidget {
  const SavedArticleScreen({super.key});

  @override
  State<SavedArticleScreen> createState() => _SavedArticleScreenState();
}

class _SavedArticleScreenState extends State<SavedArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved articles"),
      ),
      body: boxArticle.isEmpty
          ? const Center(
              child: Text("No data"),
            )
          : ListView.separated(
              itemCount: boxArticle.length,
              itemBuilder: (context, index) {
                Article data = boxArticle.getAt(index);
                return NewsArticleCard(
                  cardType: CardType.delete,
                  saveCallback: () async {
                    await boxArticle.deleteAt(index);
                    setState(() {});
                  },
                  source: data.source?.name ?? "",
                  title: data.title ?? "",
                  imageUrl: data.urlToImage,
                  onPressed: () => Get.toNamed(RoutePaths.article, parameters: {
                    "title": data.title ?? "",
                    "source": data.source?.name ?? "",
                    "imageUrl": data.urlToImage ?? "",
                    "content": data.content ?? "",
                    "description": data.description ?? "",
                    "publishedAt": data.publishedAt ?? ""
                  }),
                );
              },
              separatorBuilder: (context, index) => const Gap(10)),
    );
  }
}
