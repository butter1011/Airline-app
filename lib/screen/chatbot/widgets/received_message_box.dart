import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ReceivedMessageBox extends StatelessWidget {
  const ReceivedMessageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: AppStyles.circleDecoration,
          child: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/icons/bot.png'),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                // height: 179,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 2, color: Colors.black),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    boxShadow: const [
                      BoxShadow(color: Colors.black, offset: Offset(2, 2))
                    ]),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hey, Sam here! Excited to help you fly. Im an obsessive with 3.5 million followers ell you where to go, what time of year to visit, what to do there...the list is endless. I'm on the edge of my seat, ask me anything.",
                        style: AppStyles.textStyle_15_500,
                      ),
                      Align(
                        alignment: Alignment
                            .centerRight, // Aligns the text to the right
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            "10:05 PM",
                            style: AppStyles.textStyle_15_500
                                .copyWith(color: const Color(0xff97A09C)),
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
                    color: Color(0xff97A09C),
                  ))
            ],
          ),
        )
      ],
    );
  }
}
