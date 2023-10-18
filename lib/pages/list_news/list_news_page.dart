import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sibcode_test/pages/list_news/cubit/list_news_state.dart';
import 'package:sibcode_test/pages/list_news/widget/list_view_news.dart';
import 'package:sibcode_test/route_names.dart';
import 'package:sibcode_test/services/news_repository.dart';

import 'cubit/list_news_cubit.dart';

class ListNews extends StatelessWidget {
  ListNews({super.key});

  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => ListNewsCubit(NewsRepository()),
        child: ListNewsContent(
          scaffoldKey: _scaffoldKey,
        ),
      ),
    );
  }
}

class ListNewsContent extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey;

  const ListNewsContent({super.key, required this.scaffoldKey});

  @override
  State<ListNewsContent> createState() => _ListNewsState();
}

class _ListNewsState extends State<ListNewsContent> {
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListNewsCubit>(context).loading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Media'),
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            context.goNamed(RouteNames.profile);
          },
        ),
      ),
      body: BlocBuilder<ListNewsCubit, ListNewsState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is Empty) {
            return const Center(
              child: Text('Пустой список'),
            );
          }
          if (state is Error) {
            WidgetsBinding.instance.addPostFrameCallback((_) =>
                _showMessage(state.error));
            return listViewNews(state.listNews);
          }
          if (state is Content) {
            return listViewNews(state.listNews);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
          content: Text(
            message,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18
            ),
          ),
        )
    );
  }
}