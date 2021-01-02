import 'package:chat_app/widgets/individual_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/individual_message.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapShot) {
        if (futureSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
              .orderBy('sentTime', descending: true)
              .snapshots(),
          builder: (ctx, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              reverse: true,
              itemCount: snapShot.data.documents.length,
              itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(10),
                child: IndividualMessage(
                  snapShot.data.documents[index]['text'],
                  snapShot.data.documents[index]['userId'] ==
                      futureSnapShot.data.uid,
                  snapShot.data.documents[index]['username'],
                  key: ValueKey(
                    snapShot.data.documents[index].documentID,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
