import 'package:airline_app/models/boarding_pass.dart';
import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/build_country_flag.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:country_codes/country_codes.dart';

class ReviewFlightCard extends ConsumerStatefulWidget {
  const ReviewFlightCard({super.key, required this.singleBoardingPass});
  final BoardingPass singleBoardingPass;

  @override
  ConsumerState<ReviewFlightCard> createState() => _ReviewFlightCardState();
}

class _ReviewFlightCardState extends ConsumerState<ReviewFlightCard> {
  @override
  Widget build(BuildContext context) {
    // final airlineAirportState = ref.watch(airlineAirportProvider);
    // final airlineData = airlineAirportState.airlineData;
    final airlineAirportNotifier = ref.read(airlineAirportProvider.notifier);
    final aviationInfoNotifier = ref.read(aviationInfoProvider.notifier);
    final airlineData = airlineAirportNotifier
        .getAirlineData(widget.singleBoardingPass.airlineCode);
    final departureAirportData = airlineAirportNotifier
        .getAirportData(widget.singleBoardingPass.departureAirportCode);
    final arrivalAirportData = airlineAirportNotifier
        .getAirportData(widget.singleBoardingPass.arrivalAirportCode);

    // final originCountry = widget.singleBoardingPass.departureCountry;
    final departureAirportCode = widget.singleBoardingPass.departureAirportCode;
    final departureCountryCode = departureAirportData['countryCode'];
    final originTime = widget.singleBoardingPass.departureTime;

    // final arrivalCountry = widget.singleBoardingPass.arrivalCountry;
    final arrivalAirport = widget.singleBoardingPass.arrivalAirportCode;
    final arrivalCountryCode = arrivalAirportData['countryCode'];
    final arrivalTime = widget.singleBoardingPass.arrivalTime;

    final flightNumber = widget.singleBoardingPass.flightNumber;
    final status = widget.singleBoardingPass.visitStatus;
    final String classTravel = widget.singleBoardingPass.classOfTravel;
    final String airlineName = airlineData["name"];

    final CountryDetails departureCountry =
        CountryCodes.detailsFromAlpha2(departureCountryCode);
    final CountryDetails arrivalCountry =
        CountryCodes.detailsFromAlpha2(arrivalCountryCode);

    return Container(
      decoration: AppStyles.cardDecoration,
      child: InkWell(
        onTap: () {
          // print("Flight Card Tapped");

          final String fromId = departureAirportData['_id'];
          aviationInfoNotifier.updateFrom(fromId);
          final String toId = arrivalAirportData['_id'];
          aviationInfoNotifier.updateTo(toId);
          aviationInfoNotifier.updateClassOfTravel(classTravel);

          final String airlineId = airlineData['_id'];
          aviationInfoNotifier.updateAirline(airlineId);
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
                      buildCountryFlag(departureCountryCode),
                      // departureCountryCode.isNotEmpty ? Image.asset(departureCountryCode) : Text(""),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "${departureCountry.name != null && departureCountry.name!.length > 11 ? '${departureCountry.name!.substring(0, 11)}..' : departureCountry.name ?? 'Unknown'}, $originTime",
                        style: AppStyles.textStyle_13_600,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      if (arrivalCountryCode.isNotEmpty)
                        buildCountryFlag(arrivalCountryCode),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "${arrivalCountry.name != null && arrivalCountry.name!.length > 11 ? '${arrivalCountry.name!.substring(0, 11)}..' : arrivalCountry.name ?? 'Unknown'}, $arrivalTime",
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
                    "${departureAirportData['name']} -> ${arrivalAirportData['name']}",
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
