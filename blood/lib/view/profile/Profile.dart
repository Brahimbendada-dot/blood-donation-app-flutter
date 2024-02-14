import 'package:blood/Component/myButtonProfile.dart';
import 'package:blood/Component/myTextProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _Name=" ";
  String _Email=" ";
  String? _Image;
  FirebaseAuth instance = FirebaseAuth.instance;
  DocumentReference data = FirebaseFirestore.instance.collection("Donor")
  .doc(FirebaseAuth.instance.currentUser!.uid);
  void initState(){
    instance.authStateChanges().listen((User? user) async {
      if(user != null){
        try{
          await data.get().then((value) {
            setState(() {
              this._Name = value.data()!['Name'];
              this._Email = value.data()!["Email"];
              this._Image = value.data()!["Image"];
            });
          });
        } catch(e){
          print(e);
        }
      }
      else{
        Navigator.of(context).pushReplacementNamed("LogIn");
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0XFFB80D22),
      body: Stack(
        children: [
          Positioned(
            top: 80,
            child: Container(
              padding: EdgeInsets.all(10),
              width: screenWidth,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Color(0XFFF4F4F4),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                            color: Color(0XFFB80D22),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage("${this._Image}"),
                            )
                        ),
                      ),
                      SizedBox(width: 12,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(this._Name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(this._Email,
                            style: TextStyle(
                              fontSize: 14,
                                color: Color(0XFFB5B5B5),
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12,),
                  MyTextProfile("PROFILE"),
                  MyButtonProfile(
                    icon: Icon(Icons.person_outline,color: Colors.black,size: 28,),
                    title: "Profile Details",
                    subTitle: "View & Edit details",
                    buttonClick: (){
                      Navigator.of(context).pushNamed("ProfileDetails");
                    },
                  ),
                  MyTextProfile("HISTORY"),
                  MyButtonProfile(
                    icon: Icon(Icons.history,color: Colors.black,size: 28,),
                    title: "History of Donation",
                    subTitle: "History of all donation",
                    buttonClick: (){
                      Navigator.of(context).pushNamed("History");
                    },
                  ),
                  MyTextProfile("SETTINGS"),
                  MyButtonProfile(
                    icon: Icon(Icons.notifications_active_outlined,color: Colors.black,size: 28,),
                    title: "Push notification",
                    subTitle: "on",
                    buttonClick: (){},
                  ),
                  MyButtonProfile(
                    icon: Icon(Icons.lock_outlined,color: Colors.black,size: 28,),
                    title: "Privacy policy",
                    subTitle: "Privacy policy",
                    buttonClick: (){},
                  ),
                  MyTextProfile("LOG OUT"),
                  MyButtonProfile(
                    icon: Icon(Icons.logout,color: Colors.black,size: 28,),
                    title: "Log out",
                    subTitle: "Deconnexion",
                    buttonClick: (){
                      print("Log Out");
                      instance.signOut();
                    },
                  ),


                ],
              ),
            ),
          ),
          Positioned(
            top: 45,
            left: MediaQuery.of(context).size.width*0.5-20,
            child: Text("Profile",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)
          )
        ],
      )
    );
  }
}
