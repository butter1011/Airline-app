import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewAirportCard extends ConsumerWidget {
  const ReviewAirportCard(
      {super.key,
      required this.singleAirport,
      required this.status,
      required this.airline});
  final Map<String, dynamic> singleAirport;
  final String airline;
  final String status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final airlineAirportNotifier = ref.read(airlineAirportProvider.notifier);
    final aviationInfoNotifier = ref.read(aviationInfoProvider.notifier);
    final flag = singleAirport["flag"];
    final country = singleAirport["country"];
    final airport = singleAirport["airport"] ?? "";
    final time = singleAirport['time'];
    final aviation = ref.watch(aviationInfoProvider);

    return Opacity(
      opacity: status == "Upcoming visit" ? 0.2 : 1,
      child: InkWell(
        onTap: () {
          final String airlineId = airlineAirportNotifier.getAirlineId(airline);
          aviationInfoNotifier.updateAirline(airlineId);
          final String airportId = airlineAirportNotifier.getAirportId(airport);
          aviationInfoNotifier.updateAirport(airportId);
          final aviation = ref.watch(aviationInfoProvider);
          print(
              "🎁🎁🎁This is airport card==============>airportId: ${aviation.airport} airlineId: ${aviation.airline}");
          Navigator.pushNamed(context, AppRoutes.questionfirstscreenforairport);
        },
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
                      country + ', ' + time,
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
                      airport,
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
        ),
      ),
    );
  }
}
