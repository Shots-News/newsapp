import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bloc/categories/categories_bloc.dart';
import 'package:newsapp/constant/objects.dart';
import 'package:newsapp/models/categories_model.dart';
import 'package:newsapp/routes/move.dart';
import 'package:newsapp/routes/route_name.dart';
import 'package:newsapp/view/screens/dynamic/categories_news_screen.dart';
import 'package:provider/provider.dart';

class MyCategoriesScreen extends StatefulWidget {
  const MyCategoriesScreen({Key? key}) : super(key: key);

  @override
  _MyCategoriesScreenState createState() => _MyCategoriesScreenState();
}

class _MyCategoriesScreenState extends State<MyCategoriesScreen> {
  @override
  void initState() {
    loadCategory();
    super.initState();
  }

  loadCategory() {
    context.read<CategoriesBloc>().add(CategoriesEvent.fetchCategories);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Categories"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (BuildContext context, CategoriesState state) {
              if (state is CategoriesError) {
                final error = state.error;
                String message = '${error.message}\nTap to Retry.';
                return Text(message);
              } else if (state is CategoriesLoaded) {
                List<CategoriesModel> _list = state.categories;
                return _list.length == 0 ? _progressBuilder() : _categoriesListBuilder(_list);
              } else if (state is CategoriesLoading) {
                List<CategoriesModel> _list = state.categories!;
                return _list.length == 0 ? _progressBuilder() : _categoriesListBuilder(_list);
              } else if (state is CategoriesInitial) {
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

  _categoriesListBuilder(List<CategoriesModel> _list) {
    return ListView.builder(
      itemCount: _list.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            onTap: () => moveTo(
              context,
              screen: MyCategoriesNewsScreen(name: _list[index].name!, id: _list[index].id!),
              name: ScreenName.CATEGORIES_NEWS_SCREEN,
            ),
            dense: true,
            title: Text(
              _list[index].name!,
              style: textStyle.bodyBText(context),
            ),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          ),
        );
      },
    );
  }
}
