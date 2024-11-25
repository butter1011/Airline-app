import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/build_country_flag.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:country_flags/country_flags.dart';

class ReviewAirportCard extends ConsumerWidget {
  const ReviewAirportCard({
    super.key,
    required this.status,
    required this.airlineCode,
    required this.airportCode,
    required this.time,
  });

  final String status;
  final String time;
  final String airlineCode;
  final String airportCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final airlineAirportNotifier = ref.read(airlineAirportProvider.notifier);
    final aviationInfoNotifier = ref.read(aviationInfoProvider.notifier);
    final airportData = airlineAirportNotifier.getAirportData(airportCode);
    final airlineData = airlineAirportNotifier.getAirlineData(airlineCode);
    final CountryDetails country =
        CountryCodes.detailsFromAlpha2(airportData['countryCode']);

    return Opacity(
      opacity: status == "Upcoming visit" ? 0.2 : 1,
      child: InkWell(
        onTap: () {
          final String airlineId = airlineData['_id'];
          aviationInfoNotifier.updateAirline(airlineId);
          final String airportId = airportData['_id'];

          aviationInfoNotifier.updateAirport(airportId);
          final aviation = ref.watch(aviationInfoProvider);
      

          print(
              "🎁🎁🎁This is airport card==============>airportId: ${aviation.airport} airlineId: ${aviation.airline} ");
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
                    buildCountryFlag(airportData['countryCode']),
                    // departureCountryCode.isNotEmpty ? Image.asset(departureCountryCode) : Text(""),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "${country.name}, $time",
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
                      airportData['name'],
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
