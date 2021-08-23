import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
    } on PlatformException catch (err) {
      print('PlatformException Send Comment: $err ${err.code} ${err.message}');

      /// [FirebaseCrashlytics]
      await FirebaseCrashlytics.instance
          .recordError(err, err.details, reason: '1. PlatformException Send Comment: ${err.message}', printDetails: true);
      await FirebaseCrashlytics.instance.recordError(err, err.details,
          reason: '2. PlatformException Send Comment: ${err.message}', fatal: true, printDetails: true);
    } catch (err) {
      await FirebaseCrashlytics.instance.log("Send Comment: ${err.toString()}");
      return err.toString();
    }
  }

  Future _createBookmarked(BookmarkModel bookmarkModel) async {
    try {
      await _ref1.doc().update(bookmarkModel.toJson());
    } on PlatformException catch (err) {
      print('PlatformException Send Bookmarked: $err ${err.code} ${err.message}');

      /// [FirebaseCrashlytics]
      await FirebaseCrashlytics.instance
          .recordError(err, err.details, reason: '1. PlatformException Send Comment: ${err.message}', printDetails: true);
      await FirebaseCrashlytics.instance.recordError(err, err.details,
          reason: '2. PlatformException Send Comment: ${err.message}', fatal: true, printDetails: true);
    } catch (err) {
      await FirebaseCrashlytics.instance.log("Send Bookmarked: ${err.toString()}");
      return err.toString();
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
