import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sibcode_test/model/news.dart';

const String key = 'news_list';

Future<void> saveNewsList(List<News> newsList) async {
  final prefs = await SharedPreferences.getInstance();

  final cachedImageUrls = <String, String>{};
  for (final news in newsList) {
    final imageUrl = news.image;

    cachedImageUrls[news.id] = imageUrl;
  }

  final newsJsonList = newsList.map((news) => news.toJson()).toList();
  final newsJsonString = json.encode(newsJsonList);

  await prefs.setString(key, newsJsonString);
  await prefs.setString('cached_images', json.encode(cachedImageUrls));
}

Future<List<News>?> getNewsList() async {
  final prefs = await SharedPreferences.getInstance();
  final newsJsonString = prefs.getString(key);
  final cachedImageUrlsJson = prefs.getString('cached_images');

  if (newsJsonString != null) {
    final List<dynamic> newsJsonList = json.decode(newsJsonString);
    final Map<String, String> cachedImageUrls = cachedImageUrlsJson != null
        ? Map<String, String>.from(json.decode(cachedImageUrlsJson))
        : {};

    final List<News> newsList = newsJsonList.map((json) {
      final id = json['id'] as String;
      final imageUrl = cachedImageUrls[id];

      json['image'] = imageUrl;
      return News.fromJson(json);
    }).toList();

    return newsList;
  } else {
    return null;
  }
}
