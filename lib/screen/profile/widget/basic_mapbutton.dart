import 'package:flutter/material.dart';

class BasicMapbutton extends StatelessWidget {
  final double mywidth;
  final double myheight;
  // final Color myColor;
  final String iconpath;
  final String btntext;

  const BasicMapbutton(
      {super.key,
      required this.mywidth,
      required this.myheight,
      // required this.myColor,
      required this.iconpath,
      required this.btntext});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mywidth,
      height: myheight,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        color: Colors.white,
        borderRadius: BorderRadius.circular(27),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            // Center(
            //   child:
            Text(
              '$btntext',
              style: const TextStyle(
                  fontFamily: 'Clash Grotesk',
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            // ),
            Image.asset(
              '$iconpath',
              width: 16,
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
