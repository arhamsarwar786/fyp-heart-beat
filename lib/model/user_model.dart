class UserModel {
  String? uid;
  String? email;
  String? fullname;
  String? profilepic;

  UserModel({this.uid, this.email, this.fullname, this.profilepic});

  // receiving data from server
  UserModel.fromMap(Map<String, dynamic> map) {
    uid:
    map["uid"];
    email:
    map["email"];
    fullname:
    map["fullName"];
    profilepic:
    map["profilepic"];
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullname': fullname,
      'profilepic': profilepic,
    };
  }
}
