import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fypflutter/component/messagescreen.dart';
import 'package:fypflutter/model/get_user_model.dart';
import '../../database/database.dart';

class AddDoctor extends StatefulWidget {
  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  
  List<GetUserModel>? usersList;
   
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text('ADD DOCTORS'),),
      body: Column(
        children: [
          // Container(
          //   width: size.width,
          //   height: 50,
          //   margin: const EdgeInsets.all(10),
          //   child: Row(
          //     children: [
          //       Container(
          //         width: size.width * 0.80,
          //         child: TextField(
          //           decoration: InputDecoration(border: OutlineInputBorder()),
          //         ),
          //       ),
          //       IconButton(
          //           onPressed: () {
          //             fetchUserDB();
          //           },
          //           icon: Icon(Icons.search)),
          //     ],
          //   ),
          // ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Users").snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {

              if(snapshot.hasData || snapshot.data != null){
              QuerySnapshot data = snapshot.data!;
              
                return  Expanded(
                child:ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                         QueryDocumentSnapshot user =  data.docs[index];
                          return user.get('isDoctor') == false ? Container() : ListTile(
                            onTap: (){
                              creatingUserChat(user.get('fname'), user.get('lname'), user.get('email'),user.get('isDoctor'),user.id,user.get('profileImage'));
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> MessagesScreen(user.get('fname'),user.get('profileImage'),user.id) ));
                            },
                            leading: CircleAvatar(backgroundImage: NetworkImage(user.get('profileImage')),),
                            title: Text('${user.get('fname')} ${user.get('lname')}'),
                            subtitle: Text( user.get('email')),
                          );
                        },
                      ),
              );
              }
              return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
            }
          ),
        ],
      ),
    ));
  }
}
