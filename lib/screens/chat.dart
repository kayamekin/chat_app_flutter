import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:udemy_firebase_course/widgets/chat_messages.dart';
import 'package:udemy_firebase_course/widgets/new_messages.dart';

final FirebaseAuth _firebase = FirebaseAuth.instance;

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  void _logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
        title: const Text("My Chat App"),
      ),
      body: const Column(
        children: [
          Expanded(child: ChatMessages()),
          NewMessage(),
        ],
      ),
    );
  }
}
