import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class SentMessageBox extends StatelessWidget {
  const SentMessageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppStyles.mainColor,
              border: Border.all(width: 2, color: Colors.black),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              boxShadow: const [
                BoxShadow(color: Colors.black, offset: Offset(2, 2))
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Some messsage aboput City break",
                  style: AppStyles.textStyle_15_500,
                  textAlign: TextAlign.left,
                ),
                Align(
                  alignment:
                      Alignment.centerRight, // Aligns the text to the right
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Text(
                      "10:05 PM",
                      style: AppStyles.textStyle_15_500
                          .copyWith(color: const Color(0xff22762C)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          bottom: 12,
          right: 8,
          child: Icon(
            Icons.check,
            color: Color(0xff22762C),
          ),
        ),
      ],
    );
  }
}
