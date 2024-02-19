import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  String? name;
  Color? color;
  late Function() buttonClick;

  MyButton({
    required this.name,
    required this.buttonClick,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 40,
      child: ElevatedButton(
        onPressed: buttonClick,
        child: Text(
          name!,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
