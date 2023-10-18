import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sibcode_test/model/news.dart';
import 'package:sibcode_test/pages/authorization/authorization_page.dart';
import 'package:sibcode_test/pages/list_news/list_news_page.dart';
import 'package:sibcode_test/pages/news/news_page.dart';
import 'package:sibcode_test/pages/profile/profile_page.dart';
import 'package:sibcode_test/route_names.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        name: RouteNames.authorization,
        path: '/',
        builder: (context, state) => AuthorizationPage(),
        routes: [
          GoRoute(
            name: RouteNames.listNews,
            path: 'listNews',
            builder: (context, state) => ListNews(),
          ),
          GoRoute(
            name: RouteNames.profile,
            path: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
            name: RouteNames.news,
            path: 'news',
            builder: (context, state) => NewsPage(
              news: state.extra as News,
            ),
          ),
        ],
      ),
    ],
  );
}
