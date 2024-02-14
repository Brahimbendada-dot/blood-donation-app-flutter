import 'package:flutter/cupertino.dart';

class MyTextProfile extends StatelessWidget {

  String? text;
  MyTextProfile(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(text!,
      style: TextStyle(
          color:Color(0XFFB5B5B5),
          fontSize: 16,
          fontWeight: FontWeight.bold
      ),
    );
  }
}
