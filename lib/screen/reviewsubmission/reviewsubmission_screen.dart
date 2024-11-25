import 'package:airline_app/controller/get_airline_controller.dart';
import 'package:airline_app/models/boarding_pass.dart';
import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/boarding_passes_provider.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/review_airport_card.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/review_flight_card.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/type_button.dart';
import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewsubmissionScreen extends ConsumerStatefulWidget {
  const ReviewsubmissionScreen({super.key});

  @override
  ConsumerState<ReviewsubmissionScreen> createState() =>
      _ReviewsubmissionScreenState();
}

class _ReviewsubmissionScreenState
    extends ConsumerState<ReviewsubmissionScreen> {
  final _getAirlineData = GetAirlineAirportController();
  bool isLoading = true;
  String selectedType = "All";

  @override
  void initState() {
    super.initState();
    _getAirlineData.getAirlineAirport().then((value) {
      ref.read(airlineAirportProvider.notifier).setData(value);
    });
  }

  void onTypeSelected(String type) {
    setState(() {
      selectedType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("✈✈This is airline and airport data by http========> ${airlineAirportState.airportData}");
    final List<BoardingPass> boardingPasses = ref.watch(boardingPassesProvider);
    // List<dynamic> flights = airportCardList;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 52.2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('Reviews'),
          style: AppStyles.textStyle_16_600,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            color: Colors.black,
            height: 4.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Text(
                    AppLocalizations.of(context).translate('Type'),
                    style: AppStyles.textStyle_18_600,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TypeButton(
                      text: "All",
                      isSelected: selectedType == "All",
                      onTap: () => onTypeSelected("All"),
                    ),
                    SizedBox(width: 8),
                    TypeButton(
                      text: "Flights",
                      isSelected: selectedType == "Flights",
                      onTap: () => onTypeSelected("Flights"),
                    ),
                    SizedBox(width: 8),
                    TypeButton(
                      text: "Airports",
                      isSelected: selectedType == "Airports",
                      onTap: () => onTypeSelected("Airports"),
                    ),
                  ],
                ),
                SizedBox(height: 26),
                Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
              ],
            ),
            SizedBox(height: 12),
            Column(
              children: [
                ...boardingPasses.map((singleBoardingPass) {
                  print("⭕⭕⭕   ${singleBoardingPass.visitStatus}");
                  return _CardWidget(singleBoardingPass);
                }),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 2,
            color: Colors.black,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.syncedscreen);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Container(
                height: 56,
                decoration: AppStyles.buttonDecoration.copyWith(
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Center(
                    child: Text(
                  AppLocalizations.of(context).translate('Not here?'),
                  style: AppStyles.textStyle_15_600,
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _CardWidget(BoardingPass singleBoardingPass) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          if (selectedType == "All" || selectedType == "Flights")
            ReviewFlightCard(singleBoardingPass: singleBoardingPass),
          if ((selectedType == "All" || selectedType == "Airports") &&
              (selectedType != "Flights"))
            Column(
              children: [
                if (selectedType == "All") SizedBox(height: 10),
                ReviewAirportCard(
                  status: singleBoardingPass.visitStatus,
                  airlineCode: singleBoardingPass.airlineCode,           
                  airportCode: singleBoardingPass.departureAirportCode,              
                  time: singleBoardingPass.departureTime,
                ),
                SizedBox(height: 10),
                ReviewAirportCard(
                  status: singleBoardingPass.visitStatus,
                  airlineCode: singleBoardingPass.airlineCode,
          
                  airportCode: singleBoardingPass.arrivalAirportCode,
          
                  time: singleBoardingPass.arrivalTime,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
