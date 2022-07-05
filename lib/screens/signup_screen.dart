import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fypflutter/component/snackBar.dart';
import 'package:fypflutter/model/user_model.dart';
import 'package:fypflutter/pages/edit_profilepage.dart';
import 'package:fypflutter/screens/home_screen.dart';
import 'package:fypflutter/screens/login_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../database/database.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameEditingControler = new TextEditingController();
  TextEditingController secondNameEditingControler =
      new TextEditingController();
  TextEditingController emailEditingControler = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController conformpassword = new TextEditingController();
  bool _isvalidate = true;
  bool isDoctor = false;
  get errorMessage => null;
  @override
  Widget build(BuildContext context) {
    final firstnameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingControler,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        RegExp regex = new RegExp(
          r'^.{3,}$',
        );
        {
          if (value!.isEmpty) {
            return ("first name cannot be empty");
          }

          if (!regex.hasMatch(value)) {
            return ("Please enter valid name(Min. 3 character");
          }
        }
      },
      onSaved: (value) {
        firstNameEditingControler.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'First Name',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final secondnameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingControler,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        RegExp regex = new RegExp(
          r'^.{3,}$',
        );
        {
          if (value!.isEmpty) {
            return ("second name cannot be empty");
          }

          return null;
        }
      },
      onSaved: (value) {
        secondNameEditingControler.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Second Name',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingControler,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        ;
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("plase enter valid Email");
        }
        return null;
      },
      onSaved: (value) {
        emailEditingControler.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Email',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final passwodField = TextFormField(
      autofocus: false,
      controller: password,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(
          r'^.{6,}$',
        );
        {
          if (value!.isEmpty) {
            return ("password is required for login");
          }

          if (!regex.hasMatch(value)) {
            return ("Please enter valid password(Min. 6 character");
          }
        }
      },
      onSaved: (value) {
        password.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final conformpasswordField = TextFormField(
      autofocus: false,
      controller: conformpassword,
      obscureText: true,
      validator: (value) {
        var confirmPasswordEditingController;
        var passwordEditingController;
        if (password.text != conformpassword.text) {
          return "Password don't match";
        }
        return null;
      },
      onSaved: (value) {
        conformpassword.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Conform Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final doctorOrNot = Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: Text(
                'Type : ',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 30),
              child: Row(
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: Checkbox(
                      // focusColor: Colors.white,
                      value: isDoctor,
                      onChanged: (val) {
                        setState(() {
                          isDoctor = val!;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Doctor',
                      style: TextStyle(
                          // color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Checkbox(
                    value: !isDoctor,
                    onChanged: (val) {
                      setState(() {
                        isDoctor = !val!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Patient',
                    style: TextStyle(
                        // color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ));


    var selectImage = // Image Picker
        Container(
      alignment: Alignment.center,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: imagePickedPath ==
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
            ? BoxDecoration(
                border: Border.all(color: Colors.red, width: 1.0),
                color: Colors.black38,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage("$imagePickedPath"), fit: BoxFit.cover))
            : BoxDecoration(
                border: Border.all(color: Colors.red, width: 1.0),
                color: Colors.black38,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: FileImage(File("$imagePickedPath")),
                    fit: BoxFit.cover)),
        child: Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: () {
              showMyDialogue(context);
            },
            child: ImageIcon(
              AssetImage("assets/camera.png"),
              color: Colors.red,
              size: 20.0,
            ),
          ),
        ),
      ),
    );




    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          _formKey.currentState!.validate();
          if (_isvalidate) {
            FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: emailEditingControler.text, password: password.text)
                .then((value) {
              print("Successfully created new account");
              savingUserDetails(
                  firstNameEditingControler.text,
                  secondNameEditingControler.text,
                  emailEditingControler.text,
                  isDoctor,
                  imagePickedPath ==  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png" ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png": imagePickedPath,
                   imagePickedPath ==  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png" ? 'network' : 'asset'

                     );
              
              snackBar(context, "Successfully created new account");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            }).onError((error, stackTrace) {
              snackBar(context, error.toString());
              print("Error${error.toString()}");
            });
          }
        },
        child: Text(
          'Sign Up',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Welcom To Real Time Patient Monitoring System',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              color: Colors.white70),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 180,
                      child: Image.asset('assets/welcome.png',
                          fit: BoxFit.contain),
                    ),
                    selectImage,
                    SizedBox(height: 10),
                    firstnameField,
                    SizedBox(height: 10),
                    secondnameField,
                    SizedBox(height: 10),
                    emailField,
                    SizedBox(height: 10),
                    passwodField,
                    SizedBox(height: 10),
                    conformpasswordField,
                    SizedBox(height: 10),
                    doctorOrNot,
                    signupButton,
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  
          dynamic imagePickedPath =
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png";
    final picker = ImagePicker();

  

    /// Method for sending a selected or taken photo to the DialogBox
    Future selectOrTakePhoto({
      @required context,
      @required imageSource,
    }) async {
      picker
          .pickImage(source: imageSource, imageQuality: 10)
          .then((value) async {
        // isImageUploaded = true;
        setState(() {
        imagePickedPath = value!.path;
        print(value.path);
        });        
        Navigator.pop(context);
      });
    }



    ///  Upload An IMage
    showMyDialogue(context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: ListView(
                shrinkWrap: true,
                children: [
                  SimpleDialogOption(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text('Camera'),
                      ),
                      onPressed: () {
                        selectOrTakePhoto(
                          context: context,
                          imageSource: ImageSource.camera,
                        );
                      }),
                  Divider(
                    height: 5,
                  ),
                  SimpleDialogOption(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text('Gallery'),
                      ),
                      onPressed: () {
                        selectOrTakePhoto(
                          context: context,
                          imageSource: ImageSource.gallery,
                        );
                      }),
                ],
              ),
            );
          });
    }


//   void signUp(String email, String password) async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         await _auth
//             .createUserWithEmailAndPassword(email: email, password: password)
//             .then((value) => {postDetailsToFirestore()})
//             .catchError((e) {
//           Fluttertoast.showToast(msg: e!.message);
//         });
//         // ignore: nullable_type_in_catch_clause
//       } on FirebaseAuthException catch (error) {
//         switch (error.code) {
//           case "invalid-email":
//             var errorMessage = "Your email address appears to be malformed.";
//             break;
//           case "wrong-password":
//             var errorMessage = "Your password is wrong.";
//             break;
//           case "user-not-found":
//             var errorMessage = "User with this email doesn't exist.";
//             break;
//           case "user-disabled":
//             var errorMessage = "User with this email has been disabled.";
//             break;
//           case "too-many-requests":
//             var errorMessage = "Too many requests";
//             break;
//           case "operation-not-allowed":
//             var errorMessage =
//                 "Signing in with Email and Password is not enabled.";
//             break;
//           default:
//             var errorMessage = "An undefined Error happened.";
//         }
//         Fluttertoast.showToast(msg: errorMessage!);
//         print(error.code);
//       }
//     }
//   }

//   postDetailsToFirestore() async {
//     // calling our firestore
//     // calling our user model
//     // sedning these values

//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     var currentUser;
//     User? user = _auth.currentUser;

//     UserModel userModel = UserModel();

//     // writing all the values
//     userModel.email = user!.email;
//     userModel.uid = user.uid;
//     var firstNameEditingController;
//     userModel.firstName = firstNameEditingController.text;
//     var secondNameEditingController;
//     userModel.secondName = secondNameEditingController.text;

//     await firebaseFirestore
//         .collection("users")
//         .doc(user.uid)
//         .set(userModel.toMap());
//     Fluttertoast.showToast(msg: "Account created successfully :) ");

//     Navigator.pushAndRemoveUntil(
//         (context),
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//         (route) => false);
//   }
// }

// class _auth {
//   static User? currentUser;

//   static createUserWithEmailAndPassword(
//       {String? email, required String password}) {}
}
