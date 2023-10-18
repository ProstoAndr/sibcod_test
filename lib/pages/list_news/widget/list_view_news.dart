import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sibcode_test/model/news.dart';
import 'package:sibcode_test/route_names.dart';

Widget listViewNews(List<News> listNews) {
  return ListView.builder(
    itemCount: listNews.length,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () {
          context.goNamed(RouteNames.news, extra: listNews[index]);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                    top: 4,
                  ),
                  child: Text(
                    listNews[index].date,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: CachedNetworkImage(
                    imageUrl: listNews[index].image,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    // Ваш виджет заглушки
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error), // Ваш виджет ошибки
                  ),
                ),
                Text(
                  listNews[index].title,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
