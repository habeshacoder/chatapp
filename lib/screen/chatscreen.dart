import 'package:group_chat/chats/messages.dart';
import 'package:group_chat/chats/send_message.dart';
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
        title: const Text('chat page'),
        actions: [
          DropdownButton(
            icon: const Icon(Icons.more_vert),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Container(
                  child: const Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      Text('logout'),
                    ],
                  ),
                ),
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
      body: const Column(
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
