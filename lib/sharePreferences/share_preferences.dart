import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SavedPreference {
  
  static saveUserDetails(String userDetail) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('userDetail', userDetail);
  }

  static getUserDetails() async {
    var data;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString('userDetail');
    print(user);
    if (user != null) {
      data =  jsonDecode(user);
    }
    // print(data;
    return data;
  }

  static clearPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  ////////////////////  SAVING BPM HISTORY  /////////////////////////
  ///
  ///

  static saveBPM(record) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var data =await getBPM();
    if (data == null) {
      List allRecords = [];
      allRecords.add(record);
      pref.setString('bpmHistory', jsonEncode(allRecords));
    } else {
      data.add(record);
      pref.setString('bpmHistory', jsonEncode(data));
    }
  }

  static getBPM() async {
    var data;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var record = pref.getString('bpmHistory');
    if (record != null) {
      data = jsonDecode(record);
    }
    return data;
  }
}
