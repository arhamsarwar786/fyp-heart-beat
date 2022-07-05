import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fypflutter/model/get_user_model.dart';
import 'package:fypflutter/sharePreferences/share_preferences.dart';

import '../database/database.dart';

class GlobalState {
  static GetUserModel? userDetails;

  static saveUserStateGlobally() async {
    if (userDetails == null) {
      print('find ${FirebaseAuth.instance.currentUser}');
      if (FirebaseAuth.instance.currentUser != null) {
        userDetails =
            await getUserDetails(FirebaseAuth.instance.currentUser!.uid);
        SavedPreference.saveUserDetails(jsonEncode(userDetails));
      }
    } else {
      userDetails = SavedPreference.getUserDetails();
    }
  }
}
