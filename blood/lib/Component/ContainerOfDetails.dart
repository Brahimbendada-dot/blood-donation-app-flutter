import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerDataDetails extends StatelessWidget {

  Icon? icon;
  String? title;
  String? subTitle;
  ContainerDataDetails({
    required this.icon,
    required this.title,
    required this.subTitle,
});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8,right: 8),
      margin: EdgeInsets.only(left: 8,right: 8),
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
         this.icon!,
          SizedBox(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(this.title!,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height:3),
              Text(this.subTitle!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0XFFB5B5B5),
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}
