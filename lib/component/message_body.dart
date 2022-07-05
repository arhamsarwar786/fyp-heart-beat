import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fypflutter/component/chat_inputfield.dart';
import 'package:fypflutter/component/message.dart';
import 'package:fypflutter/constant/constant.dart';
import 'package:fypflutter/model/chatmessage.dart';

class MessageBody extends StatelessWidget {
  final String? uid;
  MessageBody(this.uid);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('persons')
                    .doc(uid)
                    .collection('messages')  
                    
                    .orderBy("time",descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData || snapshot.data != null) {
                    QuerySnapshot data = snapshot.data!;

                    print(data.docs.length);

                    return ListView.builder(
                      reverse: true,
                        itemCount: data.docs.length,
                        itemBuilder: (context, index) {
                          var chatInstance = data.docs[index].get('chat');

                          ChatMessage chat = ChatMessage(
                            text: chatInstance['text'],
                            messageType: chatInstance['messageType'],
                            messageStatus: chatInstance['messageStatus'],
                            url:chatInstance['url'],
                            isSender: chatInstance['isSender'],
                            isDoctor: chatInstance['isDoctor'],
                            // time: chatInstance['time'],
                          );                          
                          return Message(message: chat,time: data.docs[index].get('time'),);
                        });
                  
                  }
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }),
          ),
        ),
        ChatInputField(uid!),
      ],
    );
  }
}
