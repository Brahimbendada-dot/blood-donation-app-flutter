
import 'package:blood/Component/Mybutton.dart';
import 'package:blood/Component/ShowLoading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAppointement extends StatefulWidget {

  _AddAppointementState createState() => _AddAppointementState();
}

class _AddAppointementState extends State<AddAppointement> {


  TextEditingController dateController = new TextEditingController();
  String? token;
  String? _Name;
  String? _Addresse;
  String? _Email;
  int? _Age;
  String? _phone;
  String? _urlImage;
  bool validate = false;
  var _BloodGroupe;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  CollectionReference appointementRef = FirebaseFirestore.instance.collection("Appointement");
  DocumentReference donorRef = FirebaseFirestore.instance.collection("Donor")
      .doc(FirebaseAuth.instance.currentUser!.uid);
  FirebaseAuth instance = FirebaseAuth.instance;
  void initState(){
    instance.authStateChanges().listen((User? user) async {
      if(user != null){
        await donorRef.get().then((value) => {
          setState(() {
            this.token = value.data()!["Token"];
            this._urlImage = value.data()!["Image"];
            this._Name = value.data()!["Name"];
            this._Email = value.data()!["Email"];
            this._Age = value.data()!["Age"];
            this._phone= value.data()!["Phone"];
          })
        });
        print(this.token);
      }
      else{
        Navigator.of(context).pushReplacementNamed("LogIn");
      }
    });
  }
  MakeAppointement()async{
    var formData = _formKey.currentState;
    if(formData!.validate()){
      formData.save();
      showLoading(context);
      await appointementRef.add({
        "Name":this._Name,
        "Date Appointement":dateController.text.toString(),
        "Addresse":this._Addresse,
        "Email":this._Email,
        "Phone":this._phone,
        "Blood Groupe":this._BloodGroupe,
        "Date Add":DateTime.now(),
        "Image":this._urlImage,
        "Donor id":FirebaseAuth.instance.currentUser!.uid,
        "Token":this.token,
        "Validate Appointement":this.validate
      });

    }
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
                              controller: dateController,
                              onTap: () async {
                                DateTime? dateTimePicker = await showDatePicker(
                                    context: (context),
                                    initialDate: DateTime.now(),
                                    firstDate:  DateTime.now(),
                                    lastDate: DateTime(2100),
                                  builder: (context,child){
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: Color(0XFFB80D22), // <-- SEE HERE
                                            onPrimary: Colors.white, // <-- SEE HERE
                                            onSurface: Colors.blueAccent, // <-- SEE HERE
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              primary: Colors.red, // button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                  }
                                );
                                if(dateTimePicker == null){
                                  var snackBar =  SnackBar(content: Text("Date Time not Selected"),);
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                                else{
                                  setState(() {
                                    String formatedDate = DateFormat('yyyy-MM-dd').format(dateTimePicker);
                                    dateController.text = formatedDate.toString();
                                  });
                                }
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
                                hintText: "Date",
                                hintStyle: TextStyle(
                                    color: Color(0XFFB5B5B5)
                                ),
                                prefixIcon: Icon(Icons.calendar_today_outlined,color: Colors.black,),
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
                            color: Color(0xFF058C42),
                            name: "Take An Appointement",
                            buttonClick: ()async{
                              await MakeAppointement();
                              Navigator.of(context).pushReplacementNamed("DonationApp");
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
                left: MediaQuery.of(context).size.width*0.5-90,
                child: Text("Take An Appointement",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)
            )
          ],
        )
    );
  }
}
