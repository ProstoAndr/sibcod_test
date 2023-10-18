import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sibcode_test/model/news.dart';
import 'package:sibcode_test/pages/list_news/cubit/list_news_state.dart';
import 'package:sibcode_test/services/news_repository.dart';
import 'package:sibcode_test/storage/shared_preferences_news.dart';

class ListNewsCubit extends Cubit<ListNewsState> implements StateStreamable<ListNewsState> {
  final NewsRepository newsRepository;
  ListNewsCubit(this.newsRepository) : super(Initial());

  void loading() async {
    try {
      emit(Loading());
      final List<News> listNews = await newsRepository.getAllNews();
      if (listNews.isEmpty) {
        emit(Empty());
      } else {
        saveNewsList(listNews);
        emit(Content(listNews: listNews));
      }
    } catch (error) {
      final downloadedListNews = await getNewsList();
      String trimmedError = error.toString().split('.').first;

      if (downloadedListNews != null) {
        emit(Error(error: trimmedError, listNews: downloadedListNews));
      } else {
        emit(Error(error: trimmedError, listNews: []));
      }
    }
  }
}