import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_app_task/enums/common_enums.dart';

class NewsArticleCard extends StatelessWidget {
  const NewsArticleCard(
      {super.key,
      this.imageUrl,
      required this.source,
      required this.title,
      this.onPressed,
      this.saveCallback,
      required this.cardType});
  final String? imageUrl;
  final String source;
  final String title;
  final VoidCallback? onPressed;
  final VoidCallback? saveCallback;
  final CardType cardType;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Material(
        child: Ink(
          padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Column(
            children: [
              imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                        child: Text("No Image"),
                      ),
                    )
                  : const Offstage(),
              imageUrl != null ? const Gap(10) : const Offstage(),
              Row(
                children: [Flexible(child: Text(title))],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    source,
                    style: const TextStyle(
                        color: Colors.grey, fontStyle: FontStyle.italic),
                  ),
                  IconButton(
                      onPressed: saveCallback,
                      icon: CardType.save == cardType
                          ? const Icon(Icons.save_alt_rounded)
                          : const Icon(Icons.delete))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
