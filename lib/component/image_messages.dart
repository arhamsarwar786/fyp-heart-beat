import 'package:flutter/material.dart';
import 'package:fypflutter/constant/constant.dart';
import 'package:fypflutter/model/chatmessage.dart';
import 'package:fypflutter/screens/chat/open_image.dart';

class ImageMessage extends StatelessWidget {
    final ChatMessage? chat;

    ImageMessage(this.chat);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45, // 45% of total width
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> OpenImage(chat!.url) ));
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(chat!.url,fit: BoxFit.fill,),
            ),
           
          ],
        ),
      ),
    );
  }
}
