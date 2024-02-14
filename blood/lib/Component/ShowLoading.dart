

import 'package:flutter/material.dart';

showLoading(context){
  return showDialog(
      context: context,
      builder: (context){
        return  AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Please Wait"),
          content: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 4,
                color: Color(0xFFBD2733),
                backgroundColor: Colors.white,
              ),
            ),
          ),
        );
      }
  );
}