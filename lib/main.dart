import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fypflutter/screens/home_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fypflutter/screens/login_screen.dart';

import 'GlobalState/global_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GlobalState.saveUserStateGlobally();   
  print('MAIN'); 
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // int thememode = 1;

  // void initState() {
  //   super.initState();
  // }

  // starting() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   if (pref.getInt("thememode") != null) {
  //     thememode = pref.getInt("thememode")!;
  //   } else {
  //     pref.setInt("thememode", thememode);
  //   }
  //   setState(() {});
  // }

  // toggletheme() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   if (pref.getInt("thememode") == 1) {
  //     pref.setInt("thememode", 0);
  //     thememode = 0;
  //   } else {
  //     pref.setInt("thememode", 1);
  //     thememode = 1;
  //   }
  //   setState(() {});
  // }


  ThemeData _darkTheme = ThemeData(
    accentColor: Colors.red,
    brightness: Brightness.dark,
    primaryColor: Colors.amber,
  );
  ThemeData _lightTheme = ThemeData(
      accentColor: Colors.red,
      brightness: Brightness.light,
      primaryColor: Colors.amber,
      buttonTheme: ButtonThemeData(
          buttonColor: Colors.amber, disabledColor: Colors.black));
  bool _light = true;

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: _light ? _lightTheme : _darkTheme,
      // darkTheme: _darkTheme,
      title: 'Real time patient monitoring system',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),

      home: FirebaseAuth.instance.currentUser != null ? HomeScreen() : const LoginScreen(),

      // themeMode: thememode == 1 ? ThemeMode.dark : ThemeMode.light,

      //  routes: <String, WidgetBuilder>{
      //         "/a" : (BuildContext context)=> const DashBoardPage( title: 'DashBoard Page'),
      // },
    );
  }
}
// flutter run --no-sound-null-safety