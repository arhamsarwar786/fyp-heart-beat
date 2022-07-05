import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fypflutter/screens/chat/video_calling.dart';

import 'message_body.dart';

class MessagesScreen extends StatelessWidget {
  final String name,image,uid;
  MessagesScreen(this.name,this.image,this.uid);
  @override
  Widget build(BuildContext context) {
    // print(user!.get('duid')+user!.get('puid'));
    return Scaffold(
      appBar: buildAppBar(context,name),
      body: MessageBody(uid),
    );
  }

  AppBar buildAppBar(context,String user) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          CircleAvatar(
            backgroundImage: NetworkImage(image),
          ),
          SizedBox(width: 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.local_phone),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> VideoCalling() ));
          },
        ),
        SizedBox(width: 0.75 / 2),
      ],
    );
  }
}
