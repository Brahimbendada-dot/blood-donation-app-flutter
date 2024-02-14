import 'package:blood/Component/Mybutton.dart';
import 'package:blood/Component/ShowLoading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  FirebaseAuth instance = FirebaseAuth.instance;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UserCredential? userCredential;
  bool _hideText = true;
  String? _Name;
  int? _Age;
  String? _Addresse;
  String? _Email;
  String? _Password;
  String? _phone;
  bool? Validate = false;
  String? _Image="https://m.economictimes.com/thumb/msid-83502809,width-1200,height-900,resizemode-4,imgsize-353228/blood-donation_istock.jpg";
  var _BloodGroupe;
    signUp()async{
    var formData = _formKey.currentState;
    if(formData!.validate()){
      formData.save();
      showLoading(context);
      try{
      // -------------------------Create Donor account
        userCredential = await instance.createUserWithEmailAndPassword(
            email: this._Email!, password: this._Password!) ;
        // ------------------------Creat Donor Collection
        CollectionReference DonorRef = await FirebaseFirestore.instance.collection("Donor");
        DonorRef.doc(FirebaseAuth.instance.currentUser!.uid).set({
          "Name" : this._Name,
          "Age" :this._Age,
          "Addresse":this._Addresse,
          "Email":this._Email,
          "Blood Groupe":this._BloodGroupe,
          "Phone":this._phone,
          "DateCreateAccount":DateTime.now(),
          "Image":this._Image,
          "Validate":this.Validate,
          "Token":" "
        });
        return userCredential;
      }on FirebaseException catch(e){
        if(e.code=="email-already-in-use"){
          var snackBar = SnackBar(content: Text("Email Already in use"),);
          // ignore: deprecated_member_use
          _scaffoldKey.currentState!.showSnackBar(snackBar);
        }
        if(e.code == "weak-password"){
          var snackBar = SnackBar(content: Text("weak password"),);
          // ignore: deprecated_member_use
          _scaffoldKey.currentState!.showSnackBar(snackBar);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFF4F4F4),
      body: Container(
          child: Stack(
            children: [
              Positioned(
                  right: -4,
                  top: -115,
                  child: Image.asset("assets/image/DropOfBlood1.png")
              ),
              Positioned(
                  left: -20,
                  bottom: 0,
                  child: Image.asset("assets/image/DropOfBlood2.png")
              ),
              Positioned(
                  top: 40,
                  left: 240,
                  child: Text("Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
              Positioned(
                  top: 130,
                  left: 20,
                  child: Text("Create a new account ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
              Positioned(
                  top: 230,
                  left: 10,
                  right: 10,
                  child:Form(
                    key:_formKey,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              child: Row(
                                children: [
                                  Container(
                                    width: 162,
                                    height: 60,
                                    child: TextFormField(
                                      onSaved: (val){
                                        this._Name = val;
                                      },
                                      validator: (val){
                                        if(val!.length<2){
                                          return "value is less then 2 letter";
                                        }
                                        else{
                                          if(val.length>20){
                                            return "value is grate then 20 letter";
                                          }
                                        }
                                      },
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "Enter Name",
                                        hintStyle: TextStyle(
                                            color: Color(0XFFB5B5B5)
                                        ),
                                        prefixIcon: Icon(Icons.person,color: Colors.black,),
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
                                  ),
                                  SizedBox(width: 15,),
                                  Container(
                                    width: 162,
                                    height: 60,
                                    child: TextFormField(
                                      onSaved: (val){
                                        this._Age = int.parse(val!);
                                      },
                                      validator: (val){
                                        if(val!.length>2){
                                          return "value is grate then 2 number";
                                        }
                                        if(val.length==0){
                                          return "Enter Age ";
                                        }
                                      },
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "Enter Age",
                                        hintStyle: TextStyle(
                                            color: Color(0XFFB5B5B5)
                                        ),
                                        prefixIcon: Icon(Icons.calendar_today,color: Colors.black,),
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
                                  ),
                                ],
                              )

                            ),
                            SizedBox(height: 5,),
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
                                  hintText: "Enter Addresse",
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
                            ),
                            SizedBox(height: 5,),
                            Container(
                              height: 60,
                              child: TextFormField(
                                onSaved: (val){
                                  this._Email = val;
                                },
                                validator: (val){
                                  if(val!.length<2){
                                    return "this value less then 2 letter";
                                  }
                                  else{
                                    if(val.length>30){
                                      return "this value is grate then 30 letter";
                                    }
                                  }
                                },
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Enter Email",
                                  hintStyle: TextStyle(
                                      color: Color(0XFFB5B5B5)
                                  ),
                                  prefixIcon: Icon(Icons.email,color: Colors.black,),
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
                            ),
                            SizedBox(height: 5,),
                            Container(
                              height: 60,
                              child: Center(
                                child: TextFormField(
                                  onSaved: (val){
                                    this._Password = val;
                                  },
                                  validator: (val){
                                    if(val!.length<5){
                                      return "value is less then 5 letter";
                                    }
                                    else{
                                      if(val.length>20){
                                        return "value is grate then 20 letter";
                                      }
                                    }
                                  },
                                  obscureText: _hideText,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "Enter Password",
                                    hintStyle: TextStyle(
                                        color: Color(0XFFB5B5B5)
                                    ),
                                    prefixIcon: Icon(Icons.lock,color: Colors.black,),
                                    suffixIcon: IconButton(
                                        onPressed: (){
                                          setState(() {
                                            _hideText = !_hideText;
                                          });
                                        },
                                        icon:Icon(Icons.remove_red_eye, color: Colors.black,)
                                    ),
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
                              ),
                            ),
                            SizedBox(height: 5,),
                            Container(
                              height: 60,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
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
                            SizedBox(height: 5,),
                            Container(
                              height: 60,
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                onSaved: (val){
                                  this._phone = val;
                                },
                                validator: (val){
                                  if(val!.length != 10){
                                    return 'is not number phone in algeria Country';
                                  }
                                },
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Enter Phone",
                                  hintStyle: TextStyle(
                                      color: Color(0XFFB5B5B5)
                                  ),
                                  prefixIcon: Icon(Icons.phone,color: Colors.black,),
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
                            ),
                            SizedBox(height: 20,),
                            MyButton(
                              color: Color(0xFFBD2733),
                              name: "Sign Up",
                              buttonClick: ()async{
                                userCredential = await signUp();
                                if(userCredential != null){
                                  Navigator.of(context).pushReplacementNamed("DonationApp");
                                }
                              },
                            ),
                            //SizedBox(height: ,),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Already have account ?"),
                                  TextButton(onPressed: (){
                                    Navigator.of(context).pushNamed("LogIn");
                                  },
                                      child: Text("Log in"))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ),
            ],
          )
      )
    );
  }
}
