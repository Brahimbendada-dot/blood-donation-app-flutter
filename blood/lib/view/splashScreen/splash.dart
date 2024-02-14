import 'package:flutter/material.dart';

import '../DonationApp.dart';

class SplashScreen extends StatefulWidget {



  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState(){
    _NavigatetHome();
  }

  _NavigatetHome()async{

    await Future.delayed(Duration(seconds: 3),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DonationApp(0)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width:MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Blood Donation App",
              style: TextStyle(
                color:Color(0xFFBD2733),
                fontSize: 30,
                fontWeight: FontWeight.bold,

              ),
            ),
            Image.asset("assets/image/splash.png",width: 200,height: 200,),
          ],
        ),
      ),
    );
  }
}
