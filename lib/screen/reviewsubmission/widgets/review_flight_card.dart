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
  const ReviewFlightCard(
      {super.key,
      required this.index,
      required this.singleBoardingPass,
      required this.isReviewed});
  final int index;
  final BoardingPass singleBoardingPass;
  final bool isReviewed;

  @override
  ConsumerState<ReviewFlightCard> createState() => _ReviewFlightCardState();
}

class _ReviewFlightCardState extends ConsumerState<ReviewFlightCard> {
  @override
  Widget build(BuildContext context) {
    final airlineAirportNotifier = ref.read(airlineAirportProvider.notifier);
    final aviationInfoNotifier = ref.read(aviationInfoProvider.notifier);
    final airlineData = airlineAirportNotifier
        .getAirlineData(widget.singleBoardingPass.airlineCode);
    final departureAirportData = airlineAirportNotifier
        .getAirportData(widget.singleBoardingPass.departureAirportCode);
    final arrivalAirportData = airlineAirportNotifier
        .getAirportData(widget.singleBoardingPass.arrivalAirportCode);

    final airlineName = widget.singleBoardingPass.airlineName;
    final departureCountryCode = widget.singleBoardingPass.departureCountryCode;
    final originTime = widget.singleBoardingPass.departureTime;
    final arrivalCountryCode = widget.singleBoardingPass.arrivalCountryCode;
    final arrivalTime = widget.singleBoardingPass.arrivalTime;
    final flightNumber = widget.singleBoardingPass.flightNumber;
    final status = widget.singleBoardingPass.visitStatus;
    final departureCity = widget.singleBoardingPass.departureCity;
    final arrivalCity = widget.singleBoardingPass.arrivalCity;
    final departureAirportCode = widget.singleBoardingPass.departureAirportCode;
    final arrivalAirportCode = widget.singleBoardingPass.arrivalAirportCode;
    final String classTravel = widget.singleBoardingPass.classOfTravel;
    CountryDetails? departureCountry;
    CountryDetails? arrivalCountry;
    try {
      departureCountry = CountryCodes.detailsFromAlpha2(departureCountryCode);
      arrivalCountry = CountryCodes.detailsFromAlpha2(arrivalCountryCode);
    } catch (e) {
      return const SizedBox.shrink();
    }

    return Opacity(
      opacity: widget.isReviewed ? 0.5 : 1.0,
      child: Container(
        decoration: AppStyles.cardDecoration,
        child: InkWell(
          onTap: widget.isReviewed
              ? null
              : () {
                  if (departureAirportData.isEmpty ||
                      arrivalAirportData.isEmpty ||
                      airlineData.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'There is no data in the database.',
                          style: AppStyles.textStyle_16_600,
                        ),
                        duration: const Duration(seconds: 1),
                        backgroundColor: Colors.lightBlue,
                      ),
                    );
                    return;
                  }
                  final String fromId = departureAirportData['_id'];
                  final String toId = arrivalAirportData['_id'];
                  final String airlineId = airlineData['_id'];

                  aviationInfoNotifier
                    ..updateFrom(fromId)
                    ..updateTo(toId)
                    ..updateClassOfTravel(classTravel)
                    ..updateAirline(airlineId)
                    ..updateIndex(widget.index);

                  Navigator.pushNamed(
                      context, AppRoutes.questionfirstscreenforairline);
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
                        const SizedBox(width: 4),
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
                        const SizedBox(width: 4),
                        Text(
                          "${arrivalCountry.name != null && arrivalCountry.name!.length > 11 ? '${arrivalCountry.name!.substring(0, 11)}..' : arrivalCountry.name ?? 'Unknown'}, $arrivalTime",
                          style: AppStyles.textStyle_13_600,
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "${departureCity.length > 12 ? '${departureCity.substring(0, 12)}...' : departureCity}  ($departureAirportCode) -> ${arrivalCity.length > 12 ? '${arrivalCity.substring(0, 12)}...' : arrivalCity} ($arrivalAirportCode)",                        style: AppStyles.textStyle_16_600
                            .copyWith(color: Colors.black),
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                    const Icon(Icons.arrow_forward)
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Class : $classTravel",
                            style: AppStyles.textStyle_14_500),
                        Text("Flight Number : $flightNumber",
                            style: AppStyles.textStyle_14_500),
                      ],
                    ),
                    Text(airlineName, style: AppStyles.textStyle_14_500),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                    ),
                    if (widget.isReviewed)
                      IntrinsicWidth(
                        child: Container(
                          height: 24,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Center(
                              child: Text(
                                "Reviewed",
                                style: AppStyles.textStyle_14_500
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
