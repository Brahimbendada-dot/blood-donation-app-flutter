import 'package:blood/Component/MyAppointement.dart';
import 'package:blood/view/Appointement/AddAnAppointement.dart';
import 'package:blood/view/Appointement/EditAppointement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DonationApp.dart';

class Appointement extends StatelessWidget {

  CollectionReference appointementRef = FirebaseFirestore.instance.collection("Appointement");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Color(0xFFBD2733),
        title: Text("Appointement"),
      ),
      body: Center(
        child: FutureBuilder(
          future: appointementRef.where("Donor id",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder:(context, index){
                    return MyAppointement(
                      validate: snapshot.data!.docs[index]['Validate Appointement'],
                      name: snapshot.data!.docs[index]['Name'],
                      adresse: snapshot.data!.docs[index]['Addresse'],
                      phone: snapshot.data!.docs[index]['Phone'],
                      bloodGroup: snapshot.data!.docs[index]['Blood Groupe'],
                      clickButton: (){},
                      date: '${snapshot.data!.docs[index]['Date Appointement']}',
                      urlImage: snapshot.data!.docs[index]['Image'],
                      Delete: () async {
                        await appointementRef.doc(snapshot.data!.docs[index].id).delete();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => DonationApp(3)
                          )
                        );
                      },
                      Edit: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context){
                              return EditAppointement(
                                BloodGroupe: snapshot.data!.docs[index]['Blood Groupe'],
                                Addresse: snapshot.data!.docs[index]['Addresse'],
                                date: '${snapshot.data!.docs[index]['Date Appointement']}',
                                id: snapshot.data!.docs[index].id,
                              );
                            }
                          )
                        );
                      },
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
         Navigator.of(context).push(
           MaterialPageRoute(
             builder: (context)=>AddAppointement()
           )
         );
        },
        backgroundColor: Color(0xFF058C42),
      ),
    );
  }
}
