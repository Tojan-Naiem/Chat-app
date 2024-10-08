import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController=TextEditingController();
  void dispose(){
    super.dispose();
    _messageController.dispose();
  }
  _sendMessage() async{
    String _enterdText=_messageController.text;

    if(_enterdText.trim().isEmpty)return;

    _messageController.clear();
    FocusScope.of(context).unfocus();

    final User user=FirebaseAuth.instance.currentUser!;
     final userData= await FirebaseFirestore.instance
    .collection('users')
    .doc(user.uid)
    .get();
      await FirebaseFirestore.instance
    .collection('chat')
    .add({
  'text': _enterdText,
  'createdAt': Timestamp.now(),
  'userId':user.uid,
  'username':userData.data()!['name'],
  'image': userData.data()!['image'],
});
    

  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      
      padding: const EdgeInsets.only(left: 15,right: 1,bottom: 10),
      child: Row(
        children: [ 
          Expanded(
            child: TextField(
              
              controller: _messageController,
              decoration: const InputDecoration(
                
                labelText:'Send a message...'
              ),
              autocorrect: true,
              enableSuggestions: true,
              textCapitalization: TextCapitalization.sentences,
            ),
            ),
          IconButton(
            onPressed: _sendMessage
            , icon: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.primary,
              ),
              )
        ],
      ),
    );
  }
}