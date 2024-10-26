import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ReviewAirportCard extends StatelessWidget {
  const ReviewAirportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyles.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset("assets/icons/flag_Japan.png"),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Japan, 17:55",
                      style: AppStyles.flagTextStyle,
                    )
                  ],
                ),
                Row(
                  children: [
                    Image.asset("assets/icons/flag_Romania.png"),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Romania, 20:55",
                      style: AppStyles.flagTextStyle,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tokyo -> Bucharest",
                  style: AppStyles.mainTextStyle.copyWith(color: Colors.black),
                ),
                Icon(Icons.arrow_forward)
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("UO 2923", style: AppStyles.litteBlackTextStyle),
                Text("WizAir 2923", style: AppStyles.litteBlackTextStyle),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              height: 24,
              width: 102,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Text(
                  "Recent Flight",
                  style: AppStyles.litteBlackTextStyle
                      .copyWith(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
