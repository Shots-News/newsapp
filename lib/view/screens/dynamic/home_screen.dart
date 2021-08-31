import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bloc/articles/articles_bloc.dart';
import 'package:newsapp/constant/objects.dart';
import 'package:newsapp/meta/config.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/view/widgets/drawer.dart';
import 'package:newsapp/view/widgets/news_card.dart';
import 'package:provider/provider.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  void initState() {
    super.initState();
    loadArticals();
  }

  loadArticals() {
    context.read<ArticlesBloc>().add(ArticlesEvent.fetchArticles);
  }

  @override
  Widget build(BuildContext context) {
    /// [FirebaseCrashlytics]
    // FirebaseCrashlytics.instance.crash();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appName,
          style: textStyle.h6BText(context),
        ),
      ),
      drawer: DrawerWidget(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: BlocBuilder<ArticlesBloc, ArticlesState>(
          builder: (BuildContext context, ArticlesState state) {
            if (state is ArticlesError) {
              final error = state.error;
              String message = '${error.message}\nTap to Retry.';
              return Text(
                message,
                style: TextStyle(color: Colors.redAccent),
              );
            } else if (state is ArticlesLoaded) {
              List<ArticleModel> _list = state.articles;
              return _list.length == 0 ? _progressBuilder() : _pageViewBuilder(_list);
            } else if (state is ArticlesLoading) {
              List<ArticleModel> _list = state.articles!;
              return _list.length == 0 ? _progressBuilder() : _pageViewBuilder(_list);
            } else if (state is ArticlesInitial) {
              return _progressBuilder();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  _progressBuilder() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// For Bloc
  _pageViewBuilder(List<ArticleModel> articals) {
    return PageView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: articals.length,
      scrollDirection: Axis.vertical,
      scrollBehavior: ScrollBehavior(),
      controller: PageController(keepPage: false),
      itemBuilder: (BuildContext context, int index) {
        PageController controller = PageController();

        return NewsViewWidget(controller: controller, article: articals[index]);
      },
    );
  }
}
