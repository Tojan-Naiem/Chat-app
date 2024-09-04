import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final authUser=FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
      stream: FirebaseFirestore
      .instance
      .collection('chat')
      .orderBy('createdAt',descending: true)
      .snapshots(),
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
            child: Text('Something went wrong'),
          );
        }
        final loadedMessages=snapshot.data!.docs;
        return ListView.builder(
          itemCount: loadedMessages.length,
          padding: const EdgeInsets.only(
            bottom: 20,
            left: 15,
            right: 15,
          ),
          reverse: true,
          scrollDirection: Axis.vertical,
          itemBuilder: ( context,  index) {
            final chatMessage=loadedMessages[index].data();
            final nextMessage=index+1<loadedMessages.length?loadedMessages[index].data():null;
            final currentdMessageUserId=chatMessage['userId'];
            final nextMessageUserId=nextMessage!=null?nextMessage['userId']:null;
            final bool nextUserIsTheSame=currentdMessageUserId==nextMessageUserId;
            
            if(nextUserIsTheSame){
              return MessageBubble.next(
                message: chatMessage['text'],
                 isMe: authUser.uid==currentdMessageUserId
                 );
            }
            else{
              return MessageBubble.first(
                userImage: chatMessage['image'],
                 username: chatMessage['name'],
                  message: chatMessage['text'],
                 isMe: authUser.uid==currentdMessageUserId
                   );
            }
            },
          
        );

      });
  }
}