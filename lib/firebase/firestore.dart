import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/bookmark_model.dart';
import 'package:newsapp/models/comment_model.dart';

class FirebaseService {
  final CollectionReference _ref = FirebaseFirestore.instance.collection('comments');

  final CollectionReference _ref1 = FirebaseFirestore.instance.collection('bookmarked');

  Stream<QuerySnapshot> get readComments => _ref.snapshots();

  Stream<QuerySnapshot> get readBookmarked => _ref1.snapshots();

  Future _createComment(CommentModel commentModel) async {
    try {
      await _ref.doc().set(commentModel.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future _createBookmarked(BookmarkModel bookmarkModel) async {
    try {
      await _ref1.doc().update(bookmarkModel.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future sendComment({
    required String messageBody,
    required int newsId,
    required String senderId,
    required String senderName,
    required String newsName,
  }) async {
    final CommentModel _comment = CommentModel(
      messageBody: messageBody,
      newsId: newsId,
      newsName: newsName,
      userId: senderId,
      userName: senderName,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    await _createComment(_comment);
  }

  Future sendBookmarked({
    required String userID,
    required String userName,
    required ArticleModel articleModel,
  }) async {
    final BookmarkModel _bookmark = BookmarkModel(
      userId: userID,
      userName: userName,
      articles: [articleModel],
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    await _createBookmarked(_bookmark);
  }
}
