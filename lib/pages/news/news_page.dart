import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sibcode_test/model/news.dart';
import 'package:sibcode_test/route_names.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(news.title),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.goNamed(RouteNames.listNews),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(news.date),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: CachedNetworkImage(
                  imageUrl: news.image,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  // Ваш виджет заглушки
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error), // Ваш виджет ошибки
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  news.title,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Text(news.description ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
