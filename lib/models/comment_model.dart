class CommentModel {
  final int? newsId;
  final String? newsName;
  final String? userId;
  final String? userName;
  final String? messageBody;
  final int? createdAt;

  CommentModel({
    this.newsId,
    this.newsName,
    this.userId,
    this.userName,
    this.messageBody,
    this.createdAt,
  });

  CommentModel.fromData(Map data)
      : newsId = data['newsId'],
        newsName = data['newsName'],
        userId = data['senderId'],
        userName = data['senderName'],
        messageBody = data['messageBody'],
        createdAt = data['createdAt'];

  static CommentModel? fromMap(Map? map) {
    if (map == null) return null;

    return CommentModel(
      newsId: map['newsId'],
      newsName: map['newsName'],
      userId: map['senderId'],
      userName: map['senderName'],
      messageBody: map['messageBody'],
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'newsId': newsId,
      'newsName': newsName,
      'senderId': userId,
      'senderName': userName,
      'messageBody': messageBody,
      'createdAt': createdAt,
    };
  }
}
