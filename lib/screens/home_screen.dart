import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fypflutter/Drawer/sidebarlayout.dart';
import 'package:fypflutter/GlobalState/global_state.dart';

import 'package:fypflutter/model/user_model.dart';
import 'package:fypflutter/screens/login_screen.dart';
import 'package:fypflutter/sharePreferences/share_preferences.dart';

class HomeScreen extends StatefulWidget {
  // const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {    
    super.initState();
    GlobalState.saveUserStateGlobally();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        title: Text(
          'Real Time Patient Monitoring System',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              color: Colors.white70),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      drawer: SideBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                child: Image.asset(
                  'assets/welcome.png',
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                  "This study develops a remote monitoring diagnostic framework to detect underlying heart conditions in real-time which helps avoiding potential heart diseases and rehabilitation of the patients recovering from cardiac diseases.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
              SizedBox(height: 15),
              ActionChip(
                  label: Text("Logout"),
                  onPressed: () {
                    SavedPreference.clearPreference();
                    GlobalState.userDetails = null;
                    
                    logout(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
