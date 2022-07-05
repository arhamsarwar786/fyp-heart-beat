import 'package:flutter/material.dart';
import 'package:fypflutter/component/dialog.dart';
import 'package:fypflutter/component/snackBar.dart';
import 'package:fypflutter/constant/constant.dart';
import 'package:fypflutter/model/chatmessage.dart';
import 'package:image_picker/image_picker.dart';
import '../database/database.dart';

class ChatInputField extends StatelessWidget {
  final String uid;
  ChatInputField(this.uid);
  
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 0.75,
        vertical: 0.75 / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Icon(Icons.mic, color: kPrimaryColor),
            SizedBox(width: kDefaultPadding),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.64),
                    ),
                    SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: TextField(
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        dialoge(context,uid);
                      },
                      icon: Icon(
                        Icons.attach_file,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.64),
                      ),
                    ),
                    SizedBox(width: kDefaultPadding / 4),
                    IconButton(
                      onPressed: () {
                        if (textController.text.isNotEmpty) {
                          ChatMessage chat = ChatMessage(
                            text: textController.text,
                            messageType: 'text',
                            url:'',
                            messageStatus: 'not_view',
                            isSender: true,
                            isDoctor: true,
                            // time: DateTime.now(),
                          );                         
                          sendMessage(uid, chat);
                          textController.clear();
                        }else{
                          snackBar(context, 'Please, Write Something!');
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.64),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



}
