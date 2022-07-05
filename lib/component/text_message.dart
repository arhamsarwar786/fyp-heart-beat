import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fypflutter/constant/constant.dart';
import 'package:fypflutter/model/chatmessage.dart';
import 'package:intl/intl.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    this.message,
    this.time,
  }) : super(key: key);

  final ChatMessage? message;
  final time;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            message!.text,
            textAlign:TextAlign.start,
            overflow: TextOverflow.visible,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 5,
            
          ),          
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                // '$time',
                DateFormat('jm').format(time.toDate()),
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
      
      ],
    );
  }
}
