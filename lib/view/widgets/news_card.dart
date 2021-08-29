import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_const/flutter_const.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:newsapp/constant/objects.dart';
import 'package:newsapp/locator.dart';
import 'package:newsapp/meta/config.dart';
import 'package:newsapp/meta/icon.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/routes/move.dart';
import 'package:newsapp/firebase/firestore.dart';
import 'package:newsapp/routes/route_name.dart';
import 'package:newsapp/view/screens/dynamic/comment_screen.dart';
import 'package:newsapp/view/widgets/shimmer.dart';
import 'package:provider/provider.dart';

class NewsViewWidget extends StatefulWidget {
  const NewsViewWidget({
    Key? key,
    required this.controller,
    required ArticleModel article,
  })  : _article = article,
        super(key: key);

  final PageController controller;
  final ArticleModel _article;

  @override
  _NewsViewWidgetState createState() => _NewsViewWidgetState();
}

class _NewsViewWidgetState extends State<NewsViewWidget> {
  bool lines = true;
  bool speak = true;
  final _flutterTts = FlutterTts();

  @override
  void initState() {
    _flutterTts.setLanguage('en');
    _flutterTts.setSpeechRate(0.4);
    _flutterTts.setVolume(1);
    super.initState();
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return Column(
      children: [
        Expanded(
          child: PageView(
            scrollDirection: Axis.horizontal,
            controller: widget.controller,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: CachedNetworkImage(
                          imageUrl: BASE_IMAGE_PATH + widget._article.thumnail!,
                          fit: BoxFit.fill,
                          errorWidget: (context, url, error) => ShimmerImageWidget(),
                          progressIndicatorBuilder: (context, url, downloadProgress) => ShimmerImageWidget(),
                        ),
                      ),
                    ),
                    fcVSizedBox1,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        widget._article.title!,
                        style: textStyle.bodyBText(context),
                      ),
                    ),
                    fcVSizedBox1,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () => setState(() => lines = !lines),
                        child: Text(
                          widget._article.description!,
                          style: textStyle.smallText(context),
                          maxLines: lines ? 12 : 50,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    fcVSizedBox2,
                  ],
                ),
              )
            ],
          ),
        ),
        Hero(
          tag: "BottomAppBar",
          child: BottomAppBar(
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      fcHSizedBox,
                      IconButton(
                        onPressed: () {
                          final snackBar = SnackBar(
                            content: const Text('Yay! A SnackBar!'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );

                          final snackBar1 = SnackBar(
                            content: const Text('Yay! Bookmarked Created'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );

                          if (_user == null) {
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          } else {
                            locator<FirebaseService>()
                                .sendBookmarked(
                                  userID: _user.uid,
                                  userName: _user.displayName!,
                                  articleModel: widget._article,
                                )
                                .whenComplete(() => ScaffoldMessenger.of(context).showSnackBar(snackBar1));
                          }
                        },
                        icon: Icon(MyIcons.favorites),
                      ),
                      fcHSizedBox1,
                      IconButton(
                        onPressed: () {
                          speak = !speak;
                          if (speak) {
                            _flutterTts.stop();
                          } else {
                            _flutterTts.speak(widget._article.description!);
                          }
                        },
                        icon: Icon(MyIcons.play_button),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      moveTo(context, screen: MyCommentScreen(articleModel: widget._article), name: ScreenName.COMMENT_SCREEN);
                    },
                    icon: Icon(MyIcons.chat),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
