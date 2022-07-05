import 'dart:math';

class patientModel {
  String? uid;
  String? firstname;
  String? age;
  String? gender;
  String? email;
  String? phonenumber;
  patientModel(
      {this.uid,
      this.firstname,
      this.age,
      this.gender,
      this.email,
      this.phonenumber});

  // receiving data from server
  patientModelfromMap(Map<String, dynamic> map) {
    uid:
    map["uid"];
    firstname:
    map["firstname"];
    age:
    map["age"];
    gender:
    map["gender"];
    email:
    map["gender"];
    phonenumber:
    map["phonenumber"];
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstname': firstname,
      'age': age,
      'gender': gender,
      'email': email,
      'phonenumber': phonenumber,
    };
  }
}
