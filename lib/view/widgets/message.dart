import 'dart:math';

import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_const/flutter_const.dart';
import 'package:newsapp/constant/objects.dart';
import 'package:newsapp/models/comment_model.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({
    Key? key,
    required this.messages,
    required this.newsID,
    this.userId,
  }) : super(key: key);

  final List<CommentModel> messages;
  final String? userId;
  final int? newsID;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 20),
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (ctx, idx) {
          bool isSent = messages[idx].userId == userId;

          if (messages[idx].newsId == newsID) {
            return ChatBubble(
              isSent: isSent,
              message: messages[idx].messageBody!,
              name: messages[idx].userName!,
            );
          }
          return Container();
        },
      ),
    );
  }
}

class ChatBubble extends StatefulWidget {
  const ChatBubble({
    Key? key,
    required this.isSent,
    required this.message,
    required this.name,
  }) : super(key: key);

  final bool isSent;
  final String message;
  final String name;

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  List colors = [Colors.red, Colors.green, Colors.yellow];
  Random random = new Random();

  int index = 0;

  void changeIndex() {
    setState(() => index = random.nextInt(3));
  }

  @override
  Widget build(BuildContext context) {
    return Bubble(
      margin: widget.isSent ? BubbleEdges.only(top: 10, right: 20) : BubbleEdges.only(top: 10, left: 20),
      padding: BubbleEdges.symmetric(horizontal: 15, vertical: 10),
      elevation: 5,
      nipRadius: 5,
      nipWidth: 30,
      nipHeight: 10,
      alignment: widget.isSent ? Alignment.topRight : Alignment.topLeft,
      nip: widget.isSent ? BubbleNip.rightBottom : BubbleNip.leftTop,
      color: widget.isSent ? Colors.blue : Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.name,
            style: textStyle.bodyBText(context)!.copyWith(color: colors[index]),
          ),
          fcVSizedBox,
          Text(
            widget.message,
            style: TextStyle(color: widget.isSent ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}
