import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButtonProfile extends StatelessWidget {

  String? title;
  String? subTitle;
  Icon? icon;
  Function() buttonClick;

  MyButtonProfile({this.icon,this.title,this.subTitle,required this.buttonClick});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5,bottom: 10),
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextButton(
        onPressed: buttonClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
                children:[
                  this.icon!,
                  SizedBox(width: 15,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(this.title!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 2,),
                      Text(this.subTitle!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0XFFB5B5B5),

                        ),
                      ),
                    ],
                  ),
                ]
            ),
            Icon(Icons.navigate_next_rounded,color: Colors.black,size: 40,)
          ],
        ),
      ),
    );
  }
}
