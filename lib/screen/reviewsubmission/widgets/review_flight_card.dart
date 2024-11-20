import 'package:airline_app/utils/app_localizations.dart';
import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewFlightCard extends ConsumerWidget {
  const ReviewFlightCard({super.key, required this.singleFlight});
  final Map<String, dynamic> singleFlight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final airlineAirportState = ref.watch(airlineAirportProvider);
    // final airlineData = airlineAirportState.airlineData;
    final airlineAirportNotifier = ref.read(airlineAirportProvider.notifier);
    final aviationInfoNotifier = ref.read(aviationInfoProvider.notifier);
    // final aviation = ref.watch(aviationInfoProvider);
    final originCountry = singleFlight["from"]?["country"] ?? "";
    final originAirport = singleFlight["from"]?["airport"] ?? "";
    final originTime = singleFlight["from"]?["time"] ?? "Unknown Country";
    final originFlag = singleFlight["from"]?["flag"] ?? "";
    final destinationCountry = singleFlight["to"]?["country"] ?? "";
    final destinationAirport = singleFlight["to"]?["airport"] ?? "";
    final destinationTime = singleFlight["from"]?["time"] ?? " ";
    final destinationFlag = singleFlight["to"]?["flag"] ?? "";
    final flightNumber = singleFlight["flight number"] ?? "";
    final status = singleFlight['visit status'] ?? " ";
    final String classTravel = singleFlight["class of travel"] ?? "";
    final String airlineName = singleFlight["airline"] ?? "";

    return Container(
      decoration: AppStyles.cardDecoration,
      child: InkWell(
        onTap: () {
          // print("Flight Card Tapped");

          final String fromId =
              airlineAirportNotifier.getAirportId(originAirport);
          aviationInfoNotifier.updateFrom(fromId);
          final String toId =
              airlineAirportNotifier.getAirportId(destinationAirport);
          aviationInfoNotifier.updateTo(toId);
          aviationInfoNotifier.updateClassOfTravel(classTravel);

          final String airline =
              airlineAirportNotifier.getAirlineId(airlineName);
          aviationInfoNotifier.updateAirline(airline);
          final aviation = ref.watch(aviationInfoProvider);
          print(
              "👑👑👑This is arline card==============>fromId: ${aviation.from} toId: ${aviation.to} airlineId: ${aviation.airline} classTravel:${aviation.selectedClassOfTravel}");

          Navigator.pushNamed(context, AppRoutes.questionfirstscreenforairline);
        },
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
                    originAirport + "->" + destinationAirport,
                    style: AppStyles.textStyle_16_600
                        .copyWith(color: Colors.black),
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
                  Text(flightNumber, style: AppStyles.textStyle_14_500),
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
      ),
    );
  }
}
