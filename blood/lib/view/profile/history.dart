import 'package:blood/Component/myDonate.dart';
import 'package:blood/Component/myDonateHistory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  CollectionReference donRef = FirebaseFirestore.instance.collection("Don");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF4F4F4),
      appBar: AppBar(
        backgroundColor:Color(0xFFBD2733),
        title: Text("History",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      body:  FutureBuilder(
        future: donRef.where('Donor id', isEqualTo: FirebaseAuth.instance.currentUser!.uid ).get(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder:(context, index){
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction)async{
                      await FirebaseFirestore.instance.collection("Don").doc(snapshot.data!.docs[index].id).delete();
                    },
                    child: MyDonateHistory(
                      name: snapshot.data!.docs[index]['Name'],
                      adresse: snapshot.data!.docs[index]['Addresse'],
                      phone: snapshot.data!.docs[index]['Phone'],
                      bloodGroup: snapshot.data!.docs[index]['Blood Groupe'],
                      clickButton: (){},
                      date: '${snapshot.data!.docs[index]['Date Add'].toDate()}',
                      urlImage: snapshot.data!.docs[index]['Image'],
                    ),
                  );
                }
            );
          }
          return Center(child: CircularProgressIndicator(
            color: Color(0xFFBD2733),
          ));
        },

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,size: 30,color: Colors.white,),
        onPressed: (){
          Navigator.of(context).pushNamed("AddDonation");
        },
        backgroundColor: Color(0xFF058C42),
      ),
    );
  }
}
