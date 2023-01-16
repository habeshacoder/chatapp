import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendMessage extends StatefulWidget {
  const SendMessage({super.key});

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  @override
  Widget build(BuildContext context) {
    var controllermessage = TextEditingController();
    var activateButton = ' ';
    void sendMessage() async {
      FocusScope.of(context).unfocus();
      final currentUserId = await FirebaseAuth.instance.currentUser!.uid;
      final userNameDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .get();

      FirebaseFirestore.instance.collection('chat').add(
        {
          'text': controllermessage.text.trim(),
          'createAt': Timestamp.now(),
          'userid': currentUserId,
          'userName': userNameDoc['username'],
          'userImage': userNameDoc['image_url'],
        },
      );
    }

    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controllermessage,
              decoration: InputDecoration(labelText: 'write message'),
            ),
          ),
          IconButton(
              icon: Icon(Icons.send),
              color: Colors.red,
              onPressed: () {
                sendMessage();
              })
        ],
      ),
    );
  }
}
