import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bloc/news/news_bloc.dart';
import 'package:newsapp/constant/objects.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/repository/article_repo.dart';
import 'package:newsapp/view/widgets/news_card.dart';

class MyCategoriesNewsScreen extends StatefulWidget {
  const MyCategoriesNewsScreen({Key? key, required String name, required int id})
      : _name = name,
        _id = id,
        super(key: key);

  final String _name;
  final int _id;

  @override
  _MyCategoriesNewsScreenState createState() => _MyCategoriesNewsScreenState();
}

class _MyCategoriesNewsScreenState extends State<MyCategoriesNewsScreen> {
  late NewsBloc _newsBloc = NewsBloc(articleRepository: ArticleService(), categoriesID: widget._id);

  @override
  void initState() {
    _newsBloc.add(NewsEvent.fetchNews);
    super.initState();
  }

  @override
  void dispose() {
    _newsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// [FirebaseCrashlytics]
    // FirebaseCrashlytics.instance.crash();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget._name,
            style: textStyle.h6BText(context),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: BlocBuilder<NewsBloc, NewsState>(
            bloc: _newsBloc,
            builder: (BuildContext context, NewsState state) {
              print(state);
              if (state is NewsError) {
                final error = state.error;
                String message = '${error.message}\nTap to Retry.';
                return Text(
                  message,
                  style: TextStyle(color: Colors.redAccent),
                );
              } else if (state is NewsLoaded) {
                List<ArticleModel> _list = state.articles;
                return _list.length == 0 ? _progressBuilder() : _pageViewBuilder(_list);
              } else if (state is NewsLoading) {
                List<ArticleModel> _list = state.articles!;
                return _list.length == 0 ? _progressBuilder() : _pageViewBuilder(_list);
              } else if (state is NewsInitial) {
                return _progressBuilder();
              } else {
                return _progressBuilder();
              }
            },
          ),
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
        print(articals);
        return NewsViewWidget(controller: controller, article: articals[index]);
      },
    );
  }
}
