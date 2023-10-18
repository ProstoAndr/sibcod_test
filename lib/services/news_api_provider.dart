import 'package:dio/dio.dart';
import 'package:sibcode_test/model/news.dart';

class NewsApiProvider {
  static const baseUrl = 'https://webstripe.ru/list.json';
  final Dio dio = Dio();

  Future<List<News>> getNews() async {
    final response = await dio.get(baseUrl);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = response.data;
      final List<dynamic> newsList = jsonResponse['news'];
      final List<News> news =
          newsList.map((json) => News.fromJson(json)).toList();
      return news;
    } else {
      throw Exception('Error fetching news');
    }
  }
}
