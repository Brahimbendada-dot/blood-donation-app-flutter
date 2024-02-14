import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'Appointement/Appointement.dart';
import 'Request/needs.dart';
import 'addition/Add.dart';
import 'home/Home.dart';
import 'profile/Profile.dart';

class DonationApp extends StatefulWidget {
  int _index = 0;
  DonationApp(this._index);
  @override
  _DonationAppState createState() => _DonationAppState();
}

class _DonationAppState extends State<DonationApp> {

  static final List<Widget> Page = <Widget>[
    Home(),
    Add(),
    Needs(),
    Appointement(),
    Profile(),
  ];
  void changeIndex(index){
    setState(() {
      widget._index = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Page[widget._index],
      bottomNavigationBar: Container(
        color: Color(0XFFB80D22),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: GNav(
            selectedIndex: widget._index,
            backgroundColor: Color(0XFFB80D22),
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Color(0XFFF46677),
            padding: EdgeInsets.all(10),
            onTabChange: (index){
              changeIndex(index);
            },
            tabs: const [
            GButton(icon: Icons.home, text: "Home",),
            GButton(icon: Icons.add, text: "Add",),
            GButton(icon: Icons.favorite, text: "Request",),
            GButton(icon: Icons.calendar_today_outlined, text: "Appointement",),
            GButton(icon: Icons.person,text: "profile"),
           ],
          ),
        ),
      ),
    );
  }
}
