import 'package:cloud_firestore/cloud_firestore.dart';

class CommentRepository {
  // Singleton boilerplate
  CommentRepository._();

  // Instance
  final CollectionReference _ref = FirebaseFirestore.instance.collection('comments');

  static CommentRepository _instance = CommentRepository._();
  static CommentRepository get instance => _instance;

  Stream<QuerySnapshot> getPosts(int newsID) {
    return _ref
        // .where('newsId', isEqualTo: newsID)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots();
  }

  Stream<QuerySnapshot> getPostsPage(DocumentSnapshot lastDoc, {required int newsID}) {
    return _ref
        // .where('newsId', isEqualTo: newsID)
        .orderBy('createdAt', descending: true)
        .startAfterDocument(lastDoc)
        .limit(50)
        .snapshots();
  }
}
