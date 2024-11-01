import 'package:flutter/material.dart';

class BasicBlackButton extends StatelessWidget {
  final double mywidth;
  final double myheight;
  final Color myColor;

  final String btntext;

  const BasicBlackButton(
      {super.key,
      required this.mywidth,
      required this.myheight,
      required this.myColor,
      required this.btntext});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mywidth,
      height: myheight,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child:
            // Center(
            //   child:
            Center(
          child: Text(
            btntext,
            style: const TextStyle(
                fontFamily: 'Clash Grotesk',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ),
        // ),
      ),
    );
  }
}
