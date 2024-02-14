import 'package:blood/view/Appointement/AddAnAppointement.dart';
import 'package:blood/view/Authentification/Log_in.dart';
import 'package:blood/view/Authentification/Sign_in.dart';
import 'package:blood/view/DonationApp.dart';
import 'package:blood/view/addition/addDonation.dart';
import 'package:blood/view/addition/addRequest.dart';
import 'package:blood/view/home/Home.dart';
import 'package:blood/view/profile/history.dart';
import 'package:blood/view/Request/needs.dart';
import 'package:blood/view/profile/Profile.dart';
import 'package:blood/view/profile/profileDetails.dart';
import 'package:blood/view/splashScreen/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Donation());
}
class Donation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        "SignUp":(context)=> SignIn(),
        "LogIn":(context)=> LogIn(),
        "Profile":(context)=>Profile(),
        "DonationApp":(context)=>DonationApp(0),
        "Donors":(context)=>Home(),
        "Nedds":(context)=>Needs(),
        "ProfileDetails":(context)=>ProfileDetails(),
        "AddDonation":(context)=>AddDonation(),
        "AddAppointement":(context)=>AddAppointement(),
        "AddRequest":(context)=>AddRequest(),
        "History":(context)=>History(),
      },
    );
  }
}

