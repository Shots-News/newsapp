import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:newsapp/models/comment_model.dart';
import 'package:newsapp/repository/comment_repo.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc({required int newsID})
      : _newsID = newsID,
        super(CommentsStateLoading());

  List<StreamSubscription> subscriptions = [];
  List<List<CommentModel>> comments = [];

  bool hasMoreData = true;
  DocumentSnapshot? lastDoc;
  final int _newsID;

  @override
  onChange(change) {
    super.onChange(change);
  }

  @override
  Future<void> close() async {
    subscriptions.forEach((s) => s.cancel());
    super.close();
  }

  @override
  Stream<CommentsState> mapEventToState(CommentsEvent event) async* {
    if (event is CommentsEventStart) {
      // Clean up our variables
      hasMoreData = true;
      lastDoc = null;
      subscriptions.forEach((sub) {
        sub.cancel();
      });
      comments.clear();
      subscriptions.clear();
      subscriptions.add(CommentRepository.instance.getPosts(_newsID).listen((event) {
        handleStreamEvent(0, event);
      }));
    }

    if (event is CommentsEventLoad) {
      // Flatten the posts list
      final elements = comments.expand((i) => i).toList();

      if (elements.isEmpty) {
        yield CommentsStateEmpty();
      } else {
        yield CommentsStateLoadSuccess(elements, hasMoreData);
      }
    }

    if (event is CommentsEventFetchMore) {
      if (lastDoc == null) {
        throw Exception("Last doc is not set");
      }
      final index = comments.length;
      subscriptions.add(CommentRepository.instance.getPostsPage(lastDoc!, newsID: _newsID).listen((event) {
        handleStreamEvent(index, event);
      }));
    }
  }

  handleStreamEvent(int index, QuerySnapshot snap) {
    // We request 15 docs at a time
    if (snap.docs.length < 50) {
      hasMoreData = false;
    }

    // If the snapshot is empty, there's nothing for us to do
    if (snap.docs.isEmpty) return;

    if (index == comments.length) {
      // Set the last document we pulled to use as a cursor
      lastDoc = snap.docs[snap.docs.length - 1];
    }
    // Turn the QuerySnapshot into a List of posts
    List<CommentModel> newList = [];
    snap.docs.forEach((doc) {
      // This is a good spot to filter your data if you're not able
      // to compose the query you want.
      newList.add(CommentModel.fromData(doc.data() as Map));
    });
    // Update the posts list
    if (comments.length <= index) {
      comments.add(newList);
    } else {
      comments[index].clear();
      comments[index] = newList;
    }
    add(CommentsEventLoad(comments));
  }
}
