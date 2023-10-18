import 'package:sibcode_test/model/news.dart';

sealed class ListNewsState {}

class Initial extends ListNewsState {}

class Loading extends ListNewsState {}

class Empty extends ListNewsState {}

class Error extends ListNewsState {
  List<News> listNews;
  String error;

  Error({required this.error, required this.listNews});
}

class Content extends ListNewsState {
  List<News> listNews;

  Content({required this.listNews});
}