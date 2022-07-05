import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fypflutter/model/chatmessage.dart';

import '../../database/database.dart';

class ViewImage extends StatelessWidget {
  final image,uid;
  ViewImage(this.image, this.uid);

  Future sndPictureFireStorage(context) async {
    if (image != null) {
      Random random = new Random();
      int ran1 = random.nextInt(100000);      
      TaskSnapshot reference = await FirebaseStorage.instance
          .ref()
          .child("chat${uid + ran1.toString()}")
          .putFile(File(image.path));
      // UploadTask uploadTask = reference.putFile(File(selectedImage));

      if (reference.state == TaskState.success) {
        var downloadUrl = await reference.ref.getDownloadURL();
        savingImage(context, downloadUrl);
        print(downloadUrl);
        Navigator.pop(context);
      }
    }
  }

  savingImage(context, downloadUrl) {
    try {
      if (downloadUrl != null) {
        ChatMessage chat = ChatMessage(
          text: '',
          messageType: 'image',
          messageStatus: 'not_view',
          url:downloadUrl,
          isSender: true,
          isDoctor: true,
          // time: DateTime.now(),
        );
        sendMessage(uid, chat);

       
      
       
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            sndPictureFireStorage(context);            
            
          },
          child: Icon(Icons.send),
          backgroundColor: Colors.red,
        ),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.file(
                File(image.path),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
