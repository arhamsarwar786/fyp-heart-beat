import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fypflutter/GlobalState/global_state.dart';
import 'package:fypflutter/component/snackBar.dart';
import 'package:fypflutter/model/get_user_model.dart';
import 'package:fypflutter/screens/forgotpassword_screen.dart';
import 'package:fypflutter/screens/home_screen.dart';
import 'package:fypflutter/screens/signup_screen.dart';
import 'package:fypflutter/sharePreferences/share_preferences.dart';

import '../database/database.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  bool _isvalidate = true;

  savingUserIntoPreference() async {
      GetUserModel userDetails =
          await getUserDetails(FirebaseAuth.instance.currentUser!.uid);
      SavedPreference.saveUserDetails(jsonEncode(userDetails));    
      
    }
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
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
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Email',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(
          r'^.{6,}$',
        );
        {
          if (value!.isEmpty) {
            return ("password is required for login");
          }

          if (regex.hasMatch(value)) {
            
            return ("Please WAIT..... ,Sucessfully, Logged in ");
          }
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    

    final LoginButton = Material(
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
                .signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text)
                .then((value) {
                  // Saving User 
            savingUserIntoPreference();
                  snackBar(context, 'Logged in');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            }).onError((error, stackTrace) {
              snackBar(context, error.toString());
              print("Error${error.toString()}");
            });
          }
        },
        child: Text(
          'Login',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
    
      backgroundColor: Colors.white,
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
                      height: 200,
                      child: Image.asset('assets/background.png',
                          fit: BoxFit.contain),
                    ),
                    SizedBox(height: 45),
                    emailField,
                    SizedBox(height: 25),
                    passwordField,
                    SizedBox(height: 35),
                    LoginButton,
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.redAccent,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text(
                            "SignUp",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.redAccent,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// void signIn(String email, String password) async {
//   var context;
//   var _formKey;
//   if (_formKey.currentState!.validate()) {
//     try {
//       var _auth;
//       await _auth
//           .signInWithEmailAndPassword(email: email, password: password)
//           .then((uid) => {
//                 Fluttertoast.showToast(msg: "Login Successful"),
//                 Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(builder: (context) => HomeScreen())),
//               });
//     } on FirebaseAuthException catch (error) {
//       switch (error.code) {
//         case "invalid-email":
//           var errorMessage = "Your email address appears to be malformed.";

//           break;
//         case "wrong-password":
//           var errorMessage = "Your password is wrong.";
//           break;
//         case "user-not-found":
//           var errorMessage = "User with this email doesn't exist.";
//           break;
//         case "user-disabled":
//           var errorMessage = "User with this email has been disabled.";
//           break;
//         case "too-many-requests":
//           var errorMessage = "Too many requests";
//           break;
//         case "operation-not-allowed":
//           var errorMessage =
//               "Signing in with Email and Password is not enabled.";
//           break;
//         default:
//           var errorMessage = "An undefined Error happened.";
//       }
//       var errorMessage;
//       Fluttertoast.showToast(msg: errorMessage!);
//       print(error.code);
//     }
//   }
// }
