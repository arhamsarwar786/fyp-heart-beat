import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fypflutter/model/chatmessage.dart';
import 'package:fypflutter/model/get_user_model.dart';

import '../GlobalState/global_state.dart';

Future<void> savingUserDetails(fname, lname, email, isDoctor, image,type) async {
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
 
  users.doc(FirebaseAuth.instance.currentUser!.uid).set({
    'fname': fname,
    'lname': lname,
    'email': email,
    'isDoctor': isDoctor,
    'uid': FirebaseAuth.instance.currentUser!.uid,
    'profileImage': type == 'network' ? image : await uploadImageFireStorage(email, image)
  }).then((value) {
    // ignore: invalid_return_type_for_catch_error
  }).catchError((Error) => print("Failed"));
}

uploadImageFireStorage(name, image) async {
  var storage = FirebaseStorage.instance;
  // print(image);
  TaskSnapshot snapshot =
      await storage.ref().child("profileImage$name").putFile(File(image));

  if (snapshot.state == TaskState.success) {
    var downloadUrl = await snapshot.ref.getDownloadURL();    
    return downloadUrl;
  }
}

Future<void> creatingUserChat(fname, lname, email, isDoctor, uid,profileImage) async {
  CollectionReference users = FirebaseFirestore.instance.collection("chats");
  users
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('persons')
      .doc(uid)
      .set({
    'fname': fname,
    'lname': lname,
    'email': email,
    'isDoctor': isDoctor,
    'puid': FirebaseAuth.instance.currentUser!.uid,
    'duid': uid,
    'profileImage':profileImage
  });

  users
      .doc(uid)
      .collection('persons')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set({
    'fname': GlobalState.userDetails!.fname,
    'lname': GlobalState.userDetails!.lname,
    'email': GlobalState.userDetails!.email,
    'isDoctor': GlobalState.userDetails!.isDoctor,
    'puid': FirebaseAuth.instance.currentUser!.uid,
    'duid': uid,
    'profileImage':GlobalState.userDetails!.profileImage
  });
}

Future<GetUserModel> getUserDetails(uid) async {
  DocumentSnapshot user =
      await FirebaseFirestore.instance.collection("Users").doc(uid).get();
  // print(user.data());
  return GetUserModel.fromJson({
    "fname": user.get('fname'),
    "lname": user.get('lname'),
    "email": user.get('email'),
    "isDoctor": user.get('isDoctor'),
    "uid": user.get('uid'),
    "profileImage":user.get('profileImage')
  });
}

List usersList = [];
fetchUserDB() {
  FirebaseFirestore.instance.collection("Users").snapshots().listen((user) {
    user.docs.forEach((item) {
      // print(item.data());
      usersList.add(GetUserModel.fromJson({
        "fname": item.get('fname'),
        "lname": item.get('lname'),
        "email": item.get('email'),
      }));
    });
  });
  //  print(usersList);
  return usersList;
}



savingHistoryDB(item){
  FirebaseFirestore.instance.collection('Users').doc(GlobalState.userDetails!.uid).collection('history').add(item);
}

////////////////////////////// CHAT /////////////////////////////
///
///
///
sendMessage(String uid, ChatMessage chat) {
  FirebaseFirestore.instance
      .collection('chats')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('persons')
      .doc(uid)
      .collection('messages')
      .add({
    'chat': {
      'text': chat.text,
      'messageType': chat.messageType,
      'url': chat.url,
      'messageStatus': chat.messageStatus,
      'isSender': true,
      'isDoctor': GlobalState.userDetails!.isDoctor,
    },
    'time': DateTime.now(),
  });

  FirebaseFirestore.instance
      .collection('chats')
      .doc(uid)
      .collection('persons')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('messages')
      .add({
    'chat': {
      'text': chat.text,
      'messageType': chat.messageType,
      'url': chat.url,
      'messageStatus': chat.messageStatus,
      'isSender': false,
      'isDoctor': false,
    },
    'time': DateTime.now(),
  });
  print("SEND SUCESSFULLY!");
}
