import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ReviewFlightCard extends StatelessWidget {
  const ReviewFlightCard({super.key, required this.singleFlight});
  final Map<String, dynamic> singleFlight;

  @override
  Widget build(BuildContext context) {
    final originCountry = singleFlight["origin"]?["country"] ?? "";
    final originCity = singleFlight["origin"]?["city"] ?? "";
    final originTime = singleFlight["origin"]?["time"] ?? "Unknown Country";
    final originFlag = singleFlight["origin"]?["flag"] ?? "";
    final destinationCountry = singleFlight["destination"]?["country"] ?? "";
    final destinationCity = singleFlight["destination"]?["city"] ?? "";
    final destinationTime = singleFlight["origin"]?["time"] ?? " ";
    final destinationFlag = singleFlight["destination"]?["flag"] ?? "";
    final status = singleFlight['visit status'] ?? " ";

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
                    Image.asset(originFlag),
                    // originFlag.isNotEmpty ? Image.asset(originFlag) : Text(""),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      originCountry + ", " + originTime,
                      style: AppStyles.textStyle_13_600,
                    )
                  ],
                ),
                Row(
                  children: [
                    if (destinationFlag.isNotEmpty)
                      Image.asset(destinationFlag),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      destinationCountry + ", " + destinationTime,
                      style: AppStyles.textStyle_13_600,
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
                  originCity + "->" + destinationCity,
                  style:
                      AppStyles.textStyle_16_600.copyWith(color: Colors.black),
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
                Text("UO 2923", style: AppStyles.textStyle_14_500),
                Text("WizAir 2923", style: AppStyles.textStyle_14_500),
              ],
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
                      style: AppStyles.textStyle_14_500
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
