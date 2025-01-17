import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/calendar.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/custom_dropdown_button.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/toggle_btn.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirportInputScreen extends ConsumerStatefulWidget {
  AirportInputScreen({super.key});

  @override
  ConsumerState<AirportInputScreen> createState() => _AirportInputScreenState();
}

class _AirportInputScreenState extends ConsumerState<AirportInputScreen> {
  @override
  Widget build(BuildContext context) {
    final flightInputState = ref.watch(aviationInfoProvider);
    final airlineAirportState = ref.watch(airlineAirportProvider);
    List<dynamic> airlineData = airlineAirportState.airlineData;
    print(airlineData);
    List<dynamic> airportData = airlineAirportState.airportData;
    bool isValid = ref.read(aviationInfoProvider.notifier).isAirportValid();
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, AppRoutes.manualinput);
        return false;
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView(
            children: [
              const SizedBox(height: 19),
              _buildInfoText(
                  "Add your flight schedule below or sync your calendar/email"),
              const SizedBox(height: 22),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDropdownButton(
                    labelText: "Airline",
                    hintText: "your Airline",
                    onChanged: (value) => ref
                        .read(aviationInfoProvider.notifier)
                        .updateAirline(value),
                    airlineNames: airlineData,
                  ),
                  const SizedBox(height: 18),
                  CustomDropdownButton(
                    labelText: "Airport",
                    hintText: "your Airport",
                    onChanged: (value) => ref
                        .read(aviationInfoProvider.notifier)
                        .updateAirport(value),
                    airlineNames: airportData,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              CalendarWidget(),
              const SizedBox(height: 18),
              _buildTravelClassSelection(ref),
              const SizedBox(height: 18),
              // _buildAdditionalSyncOptions(ref),
              const SizedBox(height: 16),
            ],
          ),
        ),
        bottomNavigationBar:
            _buildBottomNavigationBar(context, flightInputState, isValid),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.height * 0.08,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text('Airport Input',
          style: AppStyles.textStyle_16_600.copyWith(color: Colors.black)),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(4.0),
        child: Container(color: Colors.black, height: 4.0),
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: AppStyles.textStyle_15_400,
      textAlign: TextAlign.start,
    );
  }

  Widget _buildTravelClassSelection(WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Pick your class of travel:", style: AppStyles.textStyle_14_600),
        const SizedBox(height: 13),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ToggleBtn(
              buttonText: "Business",
              height: 40,
              isSelected:
                  ref.watch(aviationInfoProvider).selectedClassOfTravel ==
                      "Business",
              onSelected: () => ref
                  .read(aviationInfoProvider.notifier)
                  .updateClassOfTravel("Business"),
            ),
            ToggleBtn(
              buttonText: "Premium Economy",
              height: 40,
              isSelected:
                  ref.watch(aviationInfoProvider).selectedClassOfTravel ==
                      "Premium Economy",
              onSelected: () => ref
                  .read(aviationInfoProvider.notifier)
                  .updateClassOfTravel("Premium Economy"),
            ),
            ToggleBtn(
              buttonText: "Economy",
              height: 40,
              isSelected:
                  ref.watch(aviationInfoProvider).selectedClassOfTravel ==
                      "Economy",
              onSelected: () => ref
                  .read(aviationInfoProvider.notifier)
                  .updateClassOfTravel("Economy"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(context, flightInputState, isValid) {
    return Column(
      mainAxisSize:
          MainAxisSize.min, // Ensures it takes only the required space
      children: [
        Container(
          height: 2, // Height of the black line
          color: Colors.black, // Color of the line
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: InkWell(
            onTap: () {
              if (isValid) {
                Navigator.pushNamed(
                    context, AppRoutes.overviewairportreviewscreen);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xFFFC8B8B),
                    content: Text(
                      "Please fill all the fields",
                      style: AppStyles.textStyle_15_600,
                    ),
                  ),
                );
              }
            },
            child: Container(
              height: 56,
              decoration: AppStyles.buttonDecoration.copyWith(
                borderRadius: BorderRadius.circular(28),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Next", style: AppStyles.textStyle_15_600),
                    Icon(Icons.arrow_forward_outlined)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
