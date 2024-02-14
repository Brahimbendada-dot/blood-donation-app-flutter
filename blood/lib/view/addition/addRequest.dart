import 'package:blood/Component/Mybutton.dart';
import 'package:blood/Component/ShowLoading.dart';
import 'package:blood/view/DonationApp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddRequest extends StatefulWidget {

  @override
  _AddRequestState createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {


  String? _Quantity;
  String? _Name;
  String? _Addresse;
  String? _phone;
  String? _Email;
  int? _Age;
  String? _urlImage;
  var _BloodGroupe;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  FirebaseAuth instance = FirebaseAuth.instance;
  DocumentReference donorRef = FirebaseFirestore.instance.collection("Donor")
  .doc(FirebaseAuth.instance.currentUser!.uid);
  CollectionReference requestRef = FirebaseFirestore.instance.collection("Request");
  addRequest()async{
    var formData = _formKey.currentState;
    if(formData!.validate()){
      formData.save();
      showLoading(context);
      await requestRef.add({
        "Name":this._Name,
        "Quantity":this._Quantity,
        "Addresse":this._Addresse,
        "Phone":this._phone,
        "Blood Groupe":this._BloodGroupe,
        "Email":this._Email,
        "Age":this._Age,
        "Date Add":DateTime.now(),
        "Image":this._urlImage,
        "user id":FirebaseAuth.instance.currentUser!.uid,
      });
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>DonationApp(2)));
  }
  void initState(){
    instance.authStateChanges().listen((User? user) async {
      if(user != null){
        await donorRef.get().then((value) => {
          setState(() {
            this._urlImage = value.data()!["Image"];
            this._Name = value.data()!["Name"];
            this._Age = value.data()!["Age"];
            this._Email = value.data()!["Email"];
            this._phone= value.data()!["Phone"];
          })
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
        backgroundColor: Color(0XFFB80D22),
        body: Stack(
          children: [
            Positioned(
              top: 80,
              child: Container(
                child:  Form(
                  key:_formKey,
                  child: Container(
                    margin: EdgeInsets.only(left: 8,right: 8),
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 100,),
                          Container(
                            height: 60,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              onSaved: (val){
                                this._Quantity = val;
                              },
                              validator: (val){
                                if(val!.length<2){
                                  return "value is less then 2 letter";
                                }
                                else{
                                  if(val.length>4){
                                    return "value is grate then 4 letter";
                                  }
                                }
                              },
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "quantity en ml",
                                hintStyle: TextStyle(
                                    color: Color(0XFFB5B5B5)
                                ),
                                prefixIcon: Icon(Icons.add_circle,color: Colors.black,),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.white
                                    )
                                ),
                                focusedBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.white
                                    )
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 60,
                            child: TextFormField(
                              onSaved: (val){
                                this._Addresse = val;
                              },
                              validator: (val){
                                if(val!.length<5){
                                  return 'value is less then 5 letter';
                                }
                                else{
                                  if(val.length>35){
                                    return 'value is grate then 35 letter';
                                  }
                                }
                              },
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Addresse",
                                hintStyle: TextStyle(
                                    color: Color(0XFFB5B5B5)
                                ),
                                prefixIcon: Icon(Icons.location_on_sharp,color: Colors.black,),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.white
                                    )
                                ),
                                focusedBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.white
                                    )
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),

                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 60,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: DropdownButton(
                              isExpanded:true,
                              hint: Text("Blood Groupe"),
                              items: ["A+","A-","B+","B-","AB+","AB-","O+","O-"]
                                  .map((e) => DropdownMenuItem(child: Text("${e}",style: TextStyle(color: Color(0XFFBD2733)),),value: e,)).toList(),
                              onChanged: (val){
                                setState(() {
                                  this._BloodGroupe = val.toString();
                                });
                              },
                              value: this._BloodGroupe,
                            ),
                          ),
                          SizedBox(height: 40,),
                          MyButton(
                            color: Color(0XFFB80D22),
                            name: "Add Request",
                            buttonClick: ()async{
                              await addRequest();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Color(0XFFF4F4F4),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),

                ),
              ),
            ),
            Positioned(
                top: 45,
                left: MediaQuery.of(context).size.width*0.5-50,
                child: Text("Add Request",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)
            )
          ],
        )
    );
  }
}
