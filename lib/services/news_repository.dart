import 'package:sibcode_test/model/news.dart';
import 'package:sibcode_test/services/news_api_provider.dart';

class NewsRepository {
  final NewsApiProvider _newsProvider = NewsApiProvider();
  Future<List<News>> getAllNews() => _newsProvider.getNews();
}