import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/build_country_flag.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewAirportCard extends ConsumerWidget {
  const ReviewAirportCard({
    super.key,
    required this.index,
    required this.status,
    required this.countryCode,
    required this.airlineCode,
    required this.airportCode,
    required this.airportName,
    required this.time,
    required this.isDeparture,
    required this.isReviewed,
    required this.classOfTravel,
  });

  final int index;
  final String status;
  final String countryCode;
  final String time;
  final String airlineCode;
  final String airportCode;
  final String airportName;
  final bool isDeparture;
  final bool isReviewed;
  final String classOfTravel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final airlineAirportNotifier = ref.read(airlineAirportProvider.notifier);
    final aviationInfoNotifier = ref.read(aviationInfoProvider.notifier);
    final airportData = airlineAirportNotifier.getAirportData(airportCode);
    final airlineData = airlineAirportNotifier.getAirlineData(airlineCode);

    final CountryDetails country = CountryCodes.detailsFromAlpha2(countryCode);

    return Opacity(
      opacity: status == "Upcoming visit" || isReviewed ? 0.5 : 1,
      child: InkWell(
        onTap: isReviewed
            ? null
            : () {
                if (airportData.isEmpty ||
                    airlineData.isEmpty ||
                    airportData['countryCode'] == null) {
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
                final String airlineId = airlineData['_id'];
                final String airportId = airportData['_id'];

                aviationInfoNotifier
                  ..updateAirline(airlineId)
                  ..updateAirport(airportId)
                  ..updateIndex(index)
                  ..updateIsDeparture(isDeparture)
                  ..updateClassOfTravel(classOfTravel);

                Navigator.pushNamed(
                    context, AppRoutes.questionfirstscreenforairport);
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
                    buildCountryFlag(countryCode),
                    const SizedBox(width: 4),
                    Text(
                      "${country.name}, $time",
                      style: AppStyles.textStyle_13_600,
                    )
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      airportName,
                      style: AppStyles.textStyle_16_600
                          .copyWith(color: Colors.black),
                    ),
                    const Icon(Icons.arrow_forward)
                  ],
                ),
                const SizedBox(height: 23),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatusContainer(status),
                    if (isReviewed) _buildStatusContainer("Reviewed"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusContainer(String text) {
    return IntrinsicWidth(
      child: Container(
        height: 24,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Center(
            child: Text(
              text,
              style: AppStyles.textStyle_14_500.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
