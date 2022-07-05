import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fypflutter/model/chatmessage.dart';

import '../../database/database.dart';

class OpenImage extends StatelessWidget {
  final image;
  OpenImage(this.image);

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      
        body: Stack(
          children: [
            InteractiveViewer(
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.network(
                  image,
                  // File(image.path),
                  fit: BoxFit.cover,
                ),
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
