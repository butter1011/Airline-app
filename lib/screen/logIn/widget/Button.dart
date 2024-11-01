import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double mywidth;
  final Color myColor;
  final String travelname;
  final double myheight;

  const Button(
      {super.key,
      required this.mywidth,
      required this.myheight,
      required this.myColor,
      required this.travelname});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mywidth,
      height: myheight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            '$travelname',
            style: TextStyle(
                fontFamily: 'Clash Grotesk',
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(),
        color: myColor,
        borderRadius: BorderRadius.circular(27),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(2, 2),
          )
        ],
      ),
    );
  }
}
