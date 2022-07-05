// ignore_for_file: use_key_in_widget_constructors

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fypflutter/model/patient_model.dart';
import 'package:fypflutter/pages/messagespage.dart';
import 'package:fypflutter/screens/home_screen.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final _formKey = GlobalKey<FormState>();

  final firstNameEditingControler = new TextEditingController();
  final ageEditingControler = new TextEditingController();
  final genderEditingControler = new TextEditingController();
  final emailEditingControler = new TextEditingController();
  final phoneEditingControler = new TextEditingController();

  Future<void> addPateint() async {
    CollectionReference users = FirebaseFirestore.instance.collection("Users");
    patientModel pModel = patientModel(
        firstname: firstNameEditingControler.text,
        age: ageEditingControler.text,
        gender: genderEditingControler.text,
        email: emailEditingControler.text,
        phonenumber: phoneEditingControler.text);
    return users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("PateintData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(pModel.toMap())
        .then((value) {
      print("added");
    }).catchError((Error) => print("Failed"));
  }

  @override
  Widget build(BuildContext context) {
    final firstnameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingControler,
      keyboardType: TextInputType.text,
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
    final ageField = TextFormField(
      autofocus: false,
      controller: ageEditingControler,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        ageEditingControler.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.app_registration),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Age',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final genderField = TextFormField(
      autofocus: false,
      controller: genderEditingControler,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        genderEditingControler.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Gender',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingControler,
      keyboardType: TextInputType.emailAddress,
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
    final phoneField = TextFormField(
      autofocus: false,
      controller: phoneEditingControler,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        phoneEditingControler.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Phone Number',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
          addPateint();
        },
        child: Text(
          'Save Data',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DashBoard',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, right: 35, left: 35),
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Add Patient Data",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          color: Colors.grey,
                          fontSize: 25),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Personal Information",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          color: Colors.grey,
                          fontSize: 18),
                    ),
                    SizedBox(height: 12),
                    firstnameField,
                    SizedBox(height: 12),
                    ageField,
                    SizedBox(height: 12),
                    genderField,
                    SizedBox(height: 12),
                    emailField,
                    SizedBox(height: 12),
                    phoneField,
                    SizedBox(height: 25),
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
}
