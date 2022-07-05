import 'package:flutter/material.dart';

class UserManagementPage extends StatelessWidget  {
  const UserManagementPage({ Key? key, required this.title }) : super(key: key);
   final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("User Management",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 28),),


       ),
       body: Center(child: 
       Text("UserM<anagement Page")
       ,),


    );
  }
}