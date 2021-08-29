import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_const/flutter_const.dart';
import 'package:newsapp/bloc/comments/comments_bloc.dart';
import 'package:newsapp/constant/objects.dart';
import 'package:newsapp/locator.dart';
import 'package:newsapp/meta/icon.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/firebase/firestore.dart';
import 'package:newsapp/view/widgets/message.dart';
import 'package:provider/provider.dart';

class MyCommentScreen extends StatefulWidget {
  const MyCommentScreen({Key? key, required ArticleModel articleModel})
      : _articleModel = articleModel,
        super(key: key);

  final ArticleModel _articleModel;

  @override
  _MyCommentScreenState createState() => _MyCommentScreenState();
}

class _MyCommentScreenState extends State<MyCommentScreen> {
  final TextEditingController _controller = TextEditingController();
  late CommentsBloc _commentsBloc = CommentsBloc(newsID: widget._articleModel.id!);

  @override
  void initState() {
    _commentsBloc.add(CommentsEventStart());
    super.initState();
  }

  @override
  void dispose() {
    _commentsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Comments",
            style: textStyle.h6BText(context),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              BlocBuilder<CommentsBloc, CommentsState>(
                bloc: _commentsBloc,
                builder: (BuildContext context, CommentsState state) {
                  if (state is CommentsStateLoading) {
                    return _progressBuilder();
                  } else if (state is CommentsStateLoadSuccess) {
                    return MessagesList(
                      messages: state.comments,
                      userId: _user != null ? _user.uid : '0',
                      newsID: widget._articleModel.id,
                    );
                  } else if (state is CommentsStateEmpty) {
                    return Center(
                      child: Text(
                        'No Comments',
                        style: textStyle.h6BText(context),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              _user == null
                  ? Container()
                  : BottomAppBar(
                      child: Container(
                        height: 50,
                        child: Row(
                          children: [
                            fcHSizedBox1,
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter Comment',
                                ),
                              ),
                            ),
                            fcHSizedBox1,
                            IconButton(
                              onPressed: () {
                                if (_controller.text.trim().isNotEmpty) {
                                  locator<FirebaseService>()
                                      .sendComment(
                                        messageBody: _controller.text.trim().toString(),
                                        newsId: widget._articleModel.id!,
                                        senderId: _user.uid,
                                        senderName: _user.displayName!,
                                        newsName: widget._articleModel.title!,
                                      )
                                      .whenComplete(
                                        () => setState(() => _controller.clear()),
                                      );
                                }
                              },
                              icon: Icon(MyIcons.play_button),
                            ),
                          ],
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  _progressBuilder() {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
