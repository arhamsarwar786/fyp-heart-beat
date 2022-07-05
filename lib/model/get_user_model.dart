// To parse this JSON data, do
//
//     final getUserModel = getUserModelFromJson(jsonString);

import 'dart:convert';

GetUserModel getUserModelFromJson(String str) => GetUserModel.fromJson(json.decode(str));

String getUserModelToJson(GetUserModel data) => json.encode(data.toJson());

class GetUserModel {
    GetUserModel({
        this.fname,
        this.lname,
        this.email,
        this.isDoctor,
        this.uid,
        this.profileImage
    });

    String? fname;
    String? lname;
    String? email;
    bool? isDoctor;
    String? uid;
    String? profileImage;

    factory GetUserModel.fromJson(Map<String, dynamic> json) => GetUserModel(
        fname: json["fname"],
        lname: json["lname"],
        email: json["email"],
        isDoctor: json["isDoctor"],
        uid: json["uid"],
        profileImage: json["profileImage"],
    );

    Map<String, dynamic> toJson() => {
        "fname": fname,
        "lname": lname,
        "email": email,
        "isDoctor":isDoctor,
        "uid":uid,
        "profileImage":profileImage
    };
}
