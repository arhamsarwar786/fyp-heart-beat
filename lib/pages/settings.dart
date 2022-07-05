import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _light = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Enter Name",
              ),
            ),
            RaisedButton(child: Text("Click me"), onPressed: () {}),
            Switch(
                value: _light,
                onChanged: (state) {
                  setState(() {
                    _light = state;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
