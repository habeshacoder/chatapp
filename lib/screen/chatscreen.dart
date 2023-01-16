import 'package:chatappudemy/chats/messages.dart';
import 'package:chatappudemy/chats/send_message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('chat page'),
        actions: [
          DropdownButton(
            
            icon: Icon(Icons.more_vert),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: const [
                      Icon(Icons.exit_to_app),
                      Text('logout'),
                    ],
                  ),
                ),
                value: 'logout',
              )
            ],
            onChanged: (value) {
              if (value == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Message(),
          ),
          SendMessage()
        ],
      ),
    );
  }
}
