import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fypflutter/GlobalState/global_state.dart';
import 'package:fypflutter/component/audio_message.dart';
import 'package:fypflutter/component/text_message.dart';
import 'package:fypflutter/component/image_messages.dart';
import 'package:fypflutter/constant/constant.dart';
import 'package:fypflutter/model/chatmessage.dart';

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.message,
    required this.time,
  }) : super(key: key);

  final ChatMessage message;
  final time;

    Widget messageContaint(ChatMessage message,time) {
      print("CHECK IT :${message}");
      // print(message.messageType.name == 'text');
      switch (message.messageType) {
        case 'text':
          return TextMessage(message: message,time: time,);
        case 'audio':
          return AudioMessage(message: message);
        case 'image':
          return ImageMessage(message);
        default:
          return const SizedBox();
      }
      
    }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 0.75),
      child: 
      
          renderChatMessage(message, time),
      // Row(
      
      //   mainAxisAlignment:
      //       message.isSender  ? MainAxisAlignment.end : MainAxisAlignment.start,
      //   children: [
      //     // if (!message.isSender) ...[
      //     //   CircleAvatar(
      //     //     radius: 12,
      //     //     backgroundImage: AssetImage("assets/user_2.png"),
      //     //   ), 
      //     //   SizedBox(width: 0.75 / 2),
      //     // ],
      //     // messageContaint(message,time),
      //     // if (message.isSender) MessageStatusDot(status: message.messageStatus)
      //   ],
      // ),
    );
  }
  
    Widget renderChatMessage(ChatMessage message, time) {
    return Align(
      alignment: message.isSender
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(        
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: message.isSender ? 5 : 7,
        ),
        decoration: BoxDecoration(
          color:
              message.isSender ? Color(0xFFDCF8C6) : Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Color(0x22000000),
              offset: Offset(1, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
       child: messageContaint(message,time),
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus? status;

  const MessageStatusDot({Key? key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.not_sent:
          return kErrorColor;
        case MessageStatus.not_view:
          return Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1);
        case MessageStatus.viewed:
          return kPrimaryColor;
        default:
          return Colors.transparent;
      }
    }

    return Container(
      margin: EdgeInsets.only(left: kDefaultPadding / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(status!),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageStatus.not_sent ? Icons.close : Icons.done,
        size: 8,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
