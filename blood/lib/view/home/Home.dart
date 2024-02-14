import 'package:blood/Component/myDonate.dart';
import 'package:blood/view/home/details_donate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String? token;
  FirebaseAuth instance = FirebaseAuth.instance;
  CollectionReference donRef = FirebaseFirestore.instance.collection("Don");
  void initState(){
    instance.authStateChanges().listen((User? user)async {
      if(user != null){
      await FirebaseMessaging.instance.getToken().then((token) =>{
        this.token = token
      });
      await FirebaseFirestore.instance.collection("Donor")
          .doc(FirebaseAuth.instance.currentUser!.uid).update({
        "Token":this.token,
      });
      }
      else{
        Navigator.of(context).pushReplacementNamed("LogIn");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFF4F4F4),
      appBar: AppBar(
        backgroundColor:Color(0xFFBD2733),
        title: Text("All of Donors",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      body:  FutureBuilder(
        future: donRef.get(),
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
                    date: '${snapshot.data!.docs[index]['Date Add'].toDate()}',
                    urlImage: snapshot.data!.docs[index]['Image'],
                    clickButton: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context){
                          return DetailsDonate(
                              name: snapshot.data!.docs[index]['Name'],
                              phone: snapshot.data!.docs[index]['Phone'],
                              adresse: snapshot.data!.docs[index]['Addresse'],
                              bloodGroupe: snapshot.data!.docs[index]['Blood Groupe'],
                              urlImage: snapshot.data!.docs[index]['Image'],
                              email: snapshot.data!.docs[index]['Email'],
                              age: snapshot.data!.docs[index]['Age'],
                              date: snapshot.data!.docs[index]['Date Add'].toDate().toString(),
                              quantity: snapshot.data!.docs[index]['Quantity'],);
                        })
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
