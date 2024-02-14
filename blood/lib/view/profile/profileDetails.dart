import 'package:blood/Component/ContainerOfDetails.dart';
import 'package:blood/Component/Mybutton.dart';
import 'package:blood/view/profile/EditProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileDetails extends StatefulWidget {

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  String _Name="User Name";
  int _Age= 0;
  String _Addresse="Addresse";
  String _Email="Email@example.com";
  String _phone="0000000000";
  var _BloodGroupe="Blood Groupe";
  String? _Image=" ";

  FirebaseAuth instance = FirebaseAuth.instance;
  DocumentReference DonorRef = FirebaseFirestore.instance.collection("Donor")
      .doc(FirebaseAuth.instance.currentUser!.uid);

  void initState(){
    instance.authStateChanges().listen((User? user) async {
      if(user != null){
        try{
          await DonorRef.get().then((value) {
            setState(() {
              this._Name = value.data()!['Name'];
              this._Age = value.data()!['Age'];
              this._Email = value.data()!['Email'];
              this._Addresse = value.data()!['Addresse'];
              this._phone = value.data()!['Phone'];
              this._BloodGroupe = value.data()!['Blood Groupe'];
              this._Image = value.data()!['Image'];
            });
          });
        } catch(e){
          print(e);
        }

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0XFFF4F4F4),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 220,
                decoration: BoxDecoration(
                    color: Color(0XFFBD2733),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(150),
                    bottomLeft: Radius.circular(150),
                  ),
                ),
                child: Center(
                  child:  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("${this._Image}"),
                            fit: BoxFit.cover
                        ),
                        border: Border.all(
                          width: 4,
                          color: Colors.white,
                        ),
                        color:  Color(0XFFF4F4F4),
                        shape: BoxShape.circle
                    ),
                  ),
                  )
                ),
              SizedBox(height: 20,),
              ContainerDataDetails(
                icon: Icon(Icons.person,color: Colors.black,size: 25,),
                title: "Name",
                subTitle: this._Name,
              ),
              SizedBox(height: 7,),
              ContainerDataDetails(
                icon: Icon(Icons.email,color: Colors.black,size: 25,),
                title: 'Email',
                subTitle: this._Email,
              ),
              SizedBox(height: 7,),
              ContainerDataDetails(
                icon: Icon(Icons.calendar_today,color: Colors.black,size: 25,),
                title: 'Age',
                subTitle:  '${this._Age}',
              ),
              SizedBox(height: 7,),
              ContainerDataDetails(
                icon: Icon(Icons.phone,color: Colors.black,size: 25,),
                title: 'Phone',
                subTitle: this._phone,
              ),
              SizedBox(height: 7,),
              ContainerDataDetails(
                icon: Icon(Icons.location_on_sharp,color: Colors.black,size: 25,),
                title: 'Addresse',
                subTitle:  this._Addresse,
              ),
              SizedBox(height: 7,),
              ContainerDataDetails(
                icon: Icon(Icons.group_add,color: Colors.black,size: 25,),
                title: 'Blood Groupe',
                subTitle:  this._BloodGroupe,
              ),
              SizedBox(height: 15,),
              MyButton(
                color: Color(0xFFBD2733),
                name: "Edit Profile",
                buttonClick: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context){
                        return EditProfile(
                            Name: this._Name,
                            Age: this._Age,
                            Addresse:this._Addresse,
                            phone: this._phone,
                            Image: this._Image,
                            BloodGroupe: this._BloodGroupe);
                      }
                    )
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
