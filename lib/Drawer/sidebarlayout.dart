import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fypflutter/GlobalState/global_state.dart';
import 'package:fypflutter/model/get_user_model.dart';
import 'package:fypflutter/model/user_model.dart';
import 'package:fypflutter/pages/Body_temperaturepage.dart';
import 'package:fypflutter/pages/blood_pressurepage.dart';
import 'package:fypflutter/pages/dashboardpage.dart';
import 'package:fypflutter/pages/edit_profilepage.dart';
import 'package:fypflutter/pages/heart_ratepage.dart';
import 'package:fypflutter/pages/messagespage.dart';
import 'package:fypflutter/pages/settings.dart';
import 'package:fypflutter/pages/user_managementpage.dart';
import 'package:fypflutter/screens/heart_beat.dart/history_heart_beat.dart';
import 'package:fypflutter/screens/home_screen.dart';
import 'package:fypflutter/screens/login_screen.dart';
import 'package:fypflutter/sharePreferences/share_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/database.dart';
import '../screens/heart_beat.dart/heart_beat_screen.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  // get newUser => null;
  // get User => null;
  GetUserModel? user;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    if (GlobalState.userDetails == null) {
      GlobalState.saveUserStateGlobally();
    } else {
      user = GlobalState.userDetails;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          user == null
              ? const UserAccountsDrawerHeader(
                  accountName: Text(''),
                  accountEmail: Text(''),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: CircularProgressIndicator.adaptive(),
                  ),
                )
              : UserAccountsDrawerHeader(
                  accountName: Text('${user!.fname} ${user!.lname}'),
                  accountEmail: Text('${user!.email}'),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(user!.isDoctor! ? 'D' :'P'),
                  ),
                ),
          ListTile(
            title: Text("DashBoard",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            leading: Icon(
              Icons.home,
              color: Colors.redAccent,
              size: 30,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DashBoardPage(title: "Dashboard")));
            },
          ),
          ListTile(
            title: Text("Messages",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            leading: Icon(
              Icons.email,
              color: Colors.redAccent,
              size: 30,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => WelcomeScreen()));
            },
          ),
          ListTile(
            title: Text("Heart Rate",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            leading: Icon(
              Icons.health_and_safety_outlined,
              color: Colors.redAccent,
              size: 30,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => HeartBeatScreen()));
            },
          ),
          ListTile(
            title: Text("Body Temperature",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            leading: Icon(
              Icons.health_and_safety_outlined,
              color: Colors.redAccent,
              size: 30,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      BodyTemperature(title: "BodyTemperature")));
            },
          ),

          ListTile(
            title: Text("History Heart Beat",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            leading: Icon(
              Icons.history,
              color: Colors.redAccent,
              size: 30,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => HistoryHeartBeat()));
            },
          ),
          Divider(
            height: 50,
            thickness: 0.5,
            color: Colors.redAccent,
            indent: 32,
            endIndent: 32,
          ),
          ListTile(
            title: Text("Settings",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            leading: Icon(
              Icons.settings,
              color: Colors.redAccent,
              size: 30,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => SettingsPage(
                  title: "settimgs",
                ),
              ));
            },
          ),
          ListTile(
            title: Text("Edit Profile",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            leading: Icon(
              Icons.edit,
              color: Colors.redAccent,
              size: 30,
            ),
            onTap: () {
              Navigator.of(context).pop();

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => EditProfilePage(
                        title: "EditProfile",
                      )));
            },
          ),

          ListTile(
            title: Text("LogOut",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            leading: Icon(
              Icons.logout,
              color: Colors.redAccent,
              size: 30,
            ),
            onTap: () async{
              SavedPreference.clearPreference();
              GlobalState.userDetails = null;
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen(),  ), ((route) => false ));
            },
          ),
        ],
      ),
    );
  }
}
