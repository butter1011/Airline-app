import 'package:airline_app/controller/get_airline_controller.dart';
import 'package:airline_app/models/boarding_pass.dart';
import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/boarding_passes_provider.dart';
import 'package:airline_app/screen/reviewsubmission/scanner_screen.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_button.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/review_airport_card.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/review_flight_card.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/type_button.dart';
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
      ref.read(airlineAirportProvider.notifier).setData(value['data']);
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
        child: boardingPasses.isEmpty
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  height: 24,
                ),
                Text(
                  AppLocalizations.of(context)
                      .translate('Nothing to show here'),
                  style: AppStyles.textStyle_24_600,
                ),
                Text(
                    AppLocalizations.of(context).translate(
                        'Here, you can synchronize your calendar and wallet or manually input the review details.'),
                    style: AppStyles.textStyle_15_500
                        .copyWith(color: Color(0xff38433E))),
              ])
            : ListView(
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
                        return _CardWidget(singleBoardingPass);
                      }),
                    ],
                  ),
                ],
              ),
      ),
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 2,
            color: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                NavButton(
                  text: AppLocalizations.of(context).translate('Synchronize'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScannerScreen(),
                      ),
                    );
                  },
                  color: Colors.white,
                ),
                SizedBox(
                  height: 12,
                ),
                NavButton(
                  text:
                      AppLocalizations.of(context).translate('Input manually'),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.manualinput);
                  },
                  color: AppStyles.mainColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _CardWidget(BoardingPass singleBoardingPass) {
    final index = ref.watch(boardingPassesProvider).indexOf(singleBoardingPass);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          if (selectedType == "All" || selectedType == "Flights")
            ReviewFlightCard(
              singleBoardingPass: singleBoardingPass,
              index: index,
              isReviewed: singleBoardingPass.isFlightReviewed,
            ),
          if ((selectedType == "All" || selectedType == "Airports") &&
              (selectedType != "Flights"))
            Column(
              children: [
                if (selectedType == "All") SizedBox(height: 10),
                ReviewAirportCard(
                    index: index,
                    status: singleBoardingPass.visitStatus,
                    airlineCode: singleBoardingPass.airlineCode,
                    airportCode: singleBoardingPass.departureAirportCode,
                    time: singleBoardingPass.departureTime,
                    isDeparture: true,
                    isReviewed: singleBoardingPass.isDepartureAirportReviewed),
                SizedBox(height: 10),
                ReviewAirportCard(
                  index: index,
                  status: singleBoardingPass.visitStatus,
                  airlineCode: singleBoardingPass.airlineCode,
                  airportCode: singleBoardingPass.arrivalAirportCode,
                  time: singleBoardingPass.arrivalTime,
                  isDeparture: false,
                  isReviewed: singleBoardingPass.isArrivalAirportReviewed,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
