import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ReviewAirportCard extends StatelessWidget {
  const ReviewAirportCard({super.key, required this.singleAirport});
  final Map<String, dynamic> singleAirport;

  @override
  Widget build(BuildContext context) {
    final flag = singleAirport["flag"];
    final country = singleAirport["country"];
    final airport = singleAirport["airport"];
    final status = singleAirport["visit status"];
    final time = singleAirport['time'];

    // print(singleairport);
    return Container(
      decoration: AppStyles.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(flag),
                // originFlag.isNotEmpty ? Image.asset(originFlag) : Text(""),
                SizedBox(
                  width: 4,
                ),
                Text(
                  country + ', ' + time,
                  style: AppStyles.flagTextStyle,
                )
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  airport,
                  style: AppStyles.mainTextStyle.copyWith(color: Colors.black),
                ),
                Icon(Icons.arrow_forward)
              ],
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 18,
            ),
            IntrinsicWidth(
              child: Container(
                height: 24,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Center(
                    child: Text(
                      status,
                      style: AppStyles.litteBlackTextStyle
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
