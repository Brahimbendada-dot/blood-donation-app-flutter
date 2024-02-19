import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class MyNeeds extends StatelessWidget {

  String bloodGroup ="";
  String name="";
  String phone="";
  String adresse="";
  String date="";
  String urlImage;
  Function() clickButton;
  MyNeeds({
    required this.name,
    required this.phone,
    required this.adresse,
    required this.date,
    required this.bloodGroup,
    required this.clickButton,
    required this.urlImage,
  }
      );
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 0,top: 0,right: 4,bottom: 4),
        margin: EdgeInsets.only(top: 5,bottom: 5),
        width: MediaQuery.of(context).size.width,
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextButton(
          onPressed: clickButton,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Positioned(
                    child: Image.asset("assets/image/DropBlood.png",width: 60,height: 60,),
                  ),
                  Positioned(
                      top: 30,
                      left: 18,
                      child: Text(this.bloodGroup,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ),
                ],
              ),
              // SizedBox(width: 5,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  Text(this.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.grey,size: 16),
                      SizedBox(width: 3,),
                      Text(this.phone,style: TextStyle(fontSize: 14,color: Colors.grey),),
                    ],
                  ),
                  SizedBox(height: 3,),
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded, color: Colors.grey,size: 16,),
                      SizedBox(width: 3,),
                      Text(this.adresse,style: TextStyle(fontSize: 14,color: Colors.grey),),
                    ],
                  ),
                  SizedBox(height: 3,),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.grey,size: 16,),
                      SizedBox(width: 3,),
                      Text(this.date,style: TextStyle(fontSize: 14,color: Colors.grey),),
                    ],
                  ),
                ],
              ),
              //SizedBox(width: 30,),
              Column(
                children: [
                  SizedBox(height: 7,),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color:  Color(0XFFF4F4F4),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(this.urlImage),
                        )
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    width: 100,
                    height: 28,
                    child: ElevatedButton(
                      
                      onPressed: () async {
                        await FlutterPhoneDirectCaller.callNumber(this.phone);
                        print("Called");
                      },
                      
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Call",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                            ),
                          ),
                          Icon(Icons.phone,size: 18, color: Color(0xFF6CDC2D),)
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}


//image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: NetworkImage("https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg"),
//                       )