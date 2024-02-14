import 'package:blood/Component/myDonate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Needs extends StatelessWidget {

  CollectionReference requestRef = FirebaseFirestore.instance.collection("Request");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Color(0xFFBD2733),
        title: Text("All of Needs"),
      ),
      body: Center(
        child: FutureBuilder(
          future: requestRef.get(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder:(context, index){
                    return MyDonate(
                      name: snapshot.data!.docs[index]['Name'],
                      adresse: snapshot.data!.docs[index]['Addresse'],
                      phone: snapshot.data!.docs[index]['Phone'],
                      bloodGroup: snapshot.data!.docs[index]['Blood Groupe'],
                      clickButton: (){},
                      date: '${snapshot.data!.docs[index]['Date Add'].toDate()}',
                      urlImage: snapshot.data!.docs[index]['Image'],
                    );
                  }
              );
            }
            return Center(child: CircularProgressIndicator(
              color: Color(0xFFBD2733),
            ));
          },

        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,size: 30,color: Colors.white,),
        onPressed: (){
          Navigator.of(context).pushNamed("AddRequest");
        },
        backgroundColor: Color(0xFFBD2733),
      ),
    );
  }
}
