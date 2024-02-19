import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

// ignore: must_be_immutable
class MySecondDonate extends StatelessWidget {
  String? name;
  String? addresse;
  String? phone;
  String? date;
  Color? color;

  MySecondDonate({
    required this.name,
    required this.phone,
    required this.addresse,
    required this.date,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
        width: 170,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: this.color,
        ),
        child: Column(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: Colors.white,
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      "assets/image/DropBlood.png",
                      width: 50,
                      height: 50,
                    ),
                    Positioned(
                        top: 24,
                        left: 15,
                        child: Text(
                          "AB+",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        )),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      this.name!,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.grey, size: 16),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          this.phone!,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: Colors.grey,
                          size: 16,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          this.addresse!,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                          size: 16,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          this.date!,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                      width: 80,
                      height: 28,
                      child: ElevatedButton(
                        onPressed: () async {
                          await FlutterPhoneDirectCaller.callNumber(
                              this.phone!);
                          print("Called");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Call",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Icon(
                              Icons.phone,
                              size: 18,
                              color: Color(0xFF6CDC2D),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }
}
