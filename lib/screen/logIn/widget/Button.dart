import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double mywidth;
  final Color mycolor;
  final String travelname;
  final double myheight;

  const Button(
      {Key? key,
      required this.mywidth,
      required this.myheight,
      required this.mycolor,
      required this.travelname})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: mycolor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black, offset: Offset(3, 3))],
      ),
      height: myheight,
      width: mywidth,
      color: mycolor,
    );
  }
}
