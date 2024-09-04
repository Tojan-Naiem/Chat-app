import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').snapshots(),
      builder: (ctx,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if(!snapshot.hasData||snapshot.data!.docs.isEmpty){
          return const Center(
            child: Text('No messages found...'),
          );
        }
        if(snapshot.hasError){
          return const Center(
            child: Text('No messages found...'),
          );
        }

      });
  }
}