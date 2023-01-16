import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.isMe, this.userName, this.imageurl);
  final imageurl;
  final message;
  final isMe;
  final String userName;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: 140,
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: !isMe
                    ? BorderRadius.circular(7)
                    : BorderRadius.circular(13),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.6,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                children: [
                  Text(userName),
                  Text(message),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageurl),
          ),
        ),
      ],
    );
  }
}
