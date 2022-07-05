import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fypflutter/GlobalState/global_state.dart';
import 'package:fypflutter/sharePreferences/share_preferences.dart';
import 'package:intl/intl.dart';

class HistoryHeartBeat extends StatefulWidget {
  const HistoryHeartBeat({Key? key}) : super(key: key);

  @override
  State<HistoryHeartBeat> createState() => _HistoryHeartBeatState();
}

class _HistoryHeartBeatState extends State<HistoryHeartBeat> {


  List? data;


  @override
  void initState() {    
    super.initState();
    fetchHistoryBPM();
  }

  fetchHistoryBPM()async{
   data =  await SavedPreference.getBPM();
   
   setState(() {
     
   });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History Heart Beats'),),
    
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').doc(GlobalState.userDetails!.uid).collection('history').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.data != null || snapshot.hasData ){
            QuerySnapshot data = snapshot.data!;
          return 
          data.docs.isEmpty ? const Center(child: Text('NO HISTORY!')) :
          
          ListView.builder(
            itemCount: data.docs.length,
            itemBuilder: (context,i){
              var item = data.docs[i];
            return ListTile(title: Text('${item.get('bpm')}'),
              leading: CircleAvatar(child: Text('${i+1}'),),
              trailing: const Icon(Icons.favorite,color: Colors.red,),
              subtitle: Text('${item.get('time')}'),
            );
          });
          }


          return Center(child: CircularProgressIndicator.adaptive(),);
        }
      ),
    );
  }
}