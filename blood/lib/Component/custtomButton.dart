import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CusttomButton extends StatelessWidget {
  const CusttomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(horizontal: 100,vertical:0),
        color: Color(0xFFBD2733),
        onPressed: (){},
        child: Text("Continue",
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
    );
  }
}
