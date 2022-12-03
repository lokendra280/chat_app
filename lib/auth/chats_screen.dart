import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats/fA5lwc3GvDgINstCFHgJ/messages')
              .snapshots(),
          builder: (ctx, stremSnapshot) {
            if (stremSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final document = stremSnapshot.data!.docs;
            return ListView.builder(
              itemCount: document.length,
              itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(8.0),
                child: Text(document[index]['text']),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/fA5lwc3GvDgINstCFHgJ/messages')
              .add({
            'text': 'This was added by clicking button',
          });
        },
      ),
    );
  }
}