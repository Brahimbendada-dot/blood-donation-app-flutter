import 'package:blood/Component/Mybutton.dart';
import 'package:blood/Component/ShowLoading.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  FirebaseAuth instance = FirebaseAuth.instance;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UserCredential? userCredential;
  String? _Email;
  String? _Password;
  bool _hideText = true;
  Future<UserCredential?> logIn() async {
    var formData = _formKey.currentState;
    if (formData!.validate()) {
      formData.save();
      showLoading(context);
      try {
        userCredential = await instance.signInWithEmailAndPassword(
            email: this._Email!, password: this._Password!);
        return userCredential;
      } on FirebaseException catch (e) {
        // if(e.code == "user-not-found"){
        // var snackBar = SnackBar(content: Text("User not found"));
        // _scaffoldKey.currentState!.showSnackBar(snackBar);
        // }
        // if(e.code == "wrong-password"){
        // var snackBar = SnackBar(content: Text("Wrong password"),);
        // _scaffoldKey.currentState!.showSnackBar(snackBar);
        // }
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
                child: Image.asset("assets/image/DropOfBlood1.png")),
            Positioned(
                left: -20,
                bottom: 0,
                child: Image.asset("assets/image/DropOfBlood2.png")),
            Positioned(
                top: 40,
                right: 30,
                child: Text(
                  "Log in",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Positioned(
                top: 120,
                left: 40,
                child: Text(
                  "Welcome !",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Positioned(
                top: 300,
                left: 10,
                right: 10,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Enter Email",
                              hintStyle: TextStyle(color: Color(0XFFB5B5B5)),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.white)),
                            ),
                            onSaved: (val) {
                              this._Email = val;
                            },
                            validator: (val) {
                              if (val!.length < 4) {
                                return "value is less then 4 letter";
                              } else {
                                if (val.length > 30) {
                                  return "value is grate then 30 letter";
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          child: Center(
                            child: TextFormField(
                              onSaved: (val) {
                                this._Password = val;
                              },
                              validator: (val) {
                                if (val!.length < 5) {
                                  return "value is less then 5 letter";
                                } else {
                                  if (val.length > 20) {
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
                                hintStyle: TextStyle(color: Color(0XFFB5B5B5)),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _hideText = !_hideText;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.black,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("haven't acoun ? "),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed("SignUp");
                                  },
                                  child: Text("Sign up"))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        MyButton(
                          name: "Log In",
                          color: Color(0xFFBD2733),
                          buttonClick: () async {
                            userCredential = await logIn();
                            if (userCredential != null) {
                              Navigator.of(context)
                                  .pushReplacementNamed("DonationApp");
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        )));
  }
}
