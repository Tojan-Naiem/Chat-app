import 'package:chat_app/widgets/chat-messages.dart';
import 'package:chat_app/widgets/new-message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          IconButton(
            onPressed: (){
              FirebaseAuth.instance.signOut();
            }, 
            icon: Icon(Icons.exit_to_app,color: Theme.of(context).colorScheme.primary,)
            )
        ],
      ),
      body: Center(
        child:Column(
          children: [
            Expanded(
              child: ChatMessages(),
              ),
              NewMessage(),
          ],
        )
      ),
    );
  }
}