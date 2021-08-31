import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bloc/articles/articles_bloc.dart';
import 'package:newsapp/bloc/categories/categories_bloc.dart';
import 'package:newsapp/meta/theme.dart';
import 'package:newsapp/repository/article_repo.dart';
import 'package:newsapp/repository/categories_repo.dart';
import 'package:newsapp/services/auth.dart';
import 'package:newsapp/view/screens/dynamic/home_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoriesBloc>(create: (_) => CategoriesBloc(categoriesRepository: CategoryService())),
        BlocProvider<ArticlesBloc>(create: (_) => ArticlesBloc(articleRepository: ArticleService())),
      ],
      child: MultiProvider(
        providers: [
          StreamProvider<User?>.value(initialData: null, value: AuthService().user),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeData,
          themeMode: ThemeMode.dark,
          home: MyHomeScreen(),
        ),
      ),
    );
  }
}
