import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IndividualMessage extends StatelessWidget {
  String _message = '';
  bool _isMe;
  final Key key;
  String _username;
  IndividualMessage(this._message, this._isMe, this._username, {this.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: _isMe ? Radius.circular(10) : Radius.zero,
              bottomRight: _isMe ? Radius.zero : Radius.circular(10),
            ),
            color: _isMe ? Colors.green : Theme.of(context).primaryColor,
          ),
          width: 200,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment:
                // _isMe ? CrossAxisAlignment.end :
                CrossAxisAlignment.start,
            children: [
              // FutureBuilder(
              //   future: Firestore.instance
              //       .collection('users')
              //       .document(_userID)
              //       .get(),
              //   builder: (ctx, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return Text('fetching data..');
              //     }
              //     return Text(
              //       snapshot.data['username'],
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           color: _isMe
              //               ? Colors.black
              //               : Theme.of(context)
              //                   .accentTextTheme
              //                   .headline1
              //                   .color),
              //     );
              //   },
              // ),
              Text(
                _username,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _isMe
                        ? Colors.black
                        : Theme.of(context).accentTextTheme.headline1.color),
              ),
              Text(
                _message,
                style: TextStyle(
                    color: _isMe
                        ? Colors.black
                        : Theme.of(context).accentTextTheme.headline1.color),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
