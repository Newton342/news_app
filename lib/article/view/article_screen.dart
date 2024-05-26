import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  String imageUrl = Get.parameters["imageUrl"] ?? "";
  String content = Get.parameters['content'] ?? "";
  String description = Get.parameters['description'] ?? "";
  String publishedAt = Get.parameters['publishedAt'] ?? "";
  String source = Get.parameters['source'] ?? "";
  String title = Get.parameters['title'] ?? "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              const Gap(10.0),
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text("No Image"),
                ),
              ),
              const Gap(10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(source,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic)),
                  Text(publishedAt,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic))
                ],
              ),
              const Gap(10.0),
              Row(
                children: [
                  Flexible(
                      child: Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ))
                ],
              ),
              const Gap(10.0),
              Text(content,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
