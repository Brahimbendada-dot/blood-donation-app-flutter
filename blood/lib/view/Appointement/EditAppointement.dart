import 'package:blood/Component/Mybutton.dart';
import 'package:blood/Component/ShowLoading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../DonationApp.dart';

class EditAppointement extends StatefulWidget {



  String? Addresse;
  String? date;
  String? id;
  var BloodGroupe;
  EditAppointement({
    required this.date,
    required this.Addresse,
    required this.BloodGroupe,
    required this.id,
  });

  @override
  _EditAppointementState createState() => _EditAppointementState();
}

class _EditAppointementState extends State<EditAppointement> {
  CollectionReference appointemetRef = FirebaseFirestore.instance.collection("Appointement");
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController dateController = new TextEditingController();
  editAppointement()async{
    var formData = _formKey.currentState;
    if(formData!.validate()){
      formData.save();
      showLoading(context);
      await appointemetRef.doc(widget.id).update({
        "Addresse":widget.Addresse,
        "Blood Groupe" : widget.BloodGroupe,
        "Date Appointement":dateController.text.toString()
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>DonationApp(3)));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  Color(0XFFF4F4F4),
        body: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
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
                                initialValue: widget.Addresse,
                                onSaved: (val){
                                  widget.Addresse = val;
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
                                hint: Text("${widget.BloodGroupe}"),
                                items: ["A+","A-","B+","B-","AB+","AB-","O+","O-"]
                                    .map((e) => DropdownMenuItem(child: Text("${e}",style: TextStyle(color: Color(0XFFBD2733)),),value: e,)).toList(),
                                onChanged: (val){
                                  setState(() {
                                    widget.BloodGroupe = val.toString();
                                  });
                                },
                                value: widget.BloodGroupe,
                              ),
                            ),
                            SizedBox(height: 40,),
                            MyButton(
                              color: Color(0xFF058C42),
                              name: "Edit Appointement",
                              buttonClick: ()async{
                                await editAppointement();
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
              ],
            ),
          ),
        )
    );
  }
}
