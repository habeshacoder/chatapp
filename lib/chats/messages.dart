import 'package:group_chat/chats/chatbubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.value(FirebaseAuth.instance.currentUser),
        builder: (context, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chat')
                .orderBy('createAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                reverse: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) => MessageBubble(
                  snapshot.data?.docs[index]['text'],
                  futureSnapshot.data!.uid ==
                      snapshot.data?.docs[index]['userid'],
                  snapshot.data?.docs[index]['userName'],
                  snapshot.data?.docs[index]['userImage'],
                ),
              );
            },
          );
        });
  }
}
