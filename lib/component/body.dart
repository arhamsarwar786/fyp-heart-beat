import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fypflutter/component/field_outline_button.dart';
import 'package:fypflutter/component/messagescreen.dart';
import 'package:fypflutter/constant/constant.dart';
import 'package:fypflutter/model/chat.dart';

import 'chat_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   padding: EdgeInsets.fromLTRB(
        //       kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
        //   color: kPrimaryColor,
        //   child: Row(
        //     children: [
        //       FillOutlineButton(press: () {}, text: "Recent Message"),
        //       SizedBox(width: kDefaultPadding),
        //       FillOutlineButton(
        //         press: () {},
        //         text: "Active",
        //         isFilled: false,
        //       ),
        //     ],
        //   ),
        // ),
        Expanded(
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("chats").doc(FirebaseAuth.instance.currentUser!.uid).collection('persons').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.hasData || snapshot.data != null) {
                QuerySnapshot data = snapshot.data!;
                  return data.docs.isEmpty ? const  Center(child: Text('No Chats with Doctors'),):   ListView.builder(
                  itemCount: data.docs.length,
                  itemBuilder: (context, index) => ChatCard(
                    chat:  Chat(
                            name: '${data.docs[index].get('fname')} ${data.docs[index].get('lname')}',
                            lastMessage: "",
                            image: data.docs[index].get('profileImage'),
                            time: "",
                            isActive: false,
                          ),
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessagesScreen(data.docs[index].get('fname'),data.docs[index].get('profileImage'),data.docs[index].id),
                      ),
                    ),
                  ),
                );
                }
                return const Center(child: CircularProgressIndicator(),);
              }),
        ),
      ],
    );
  }
}
