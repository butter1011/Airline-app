import 'package:airline_app/utils/app_localizations.dart';
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

    return Opacity(
      opacity: status == "Upcoming visit" ? 0.2 : 1,
      child: Container(
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
                    AppLocalizations.of(context).translate('$country') +
                        ', ' +
                        time,
                    style: AppStyles.textStyle_13_600,
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
                    AppLocalizations.of(context).translate('$airport'),
                    style: AppStyles.textStyle_16_600
                        .copyWith(color: Colors.black),
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
                        AppLocalizations.of(context).translate('$status'),
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
      ),
    );
  }
}
