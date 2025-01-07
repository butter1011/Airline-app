import 'package:airline_app/controller/boarding_pass_controller.dart';
import 'package:airline_app/models/boarding_pass.dart';
import 'package:airline_app/provider/boarding_passes_provider.dart';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/screen/app_widgets/loading.dart';
import 'package:airline_app/screen/reviewsubmission/google_calendar/calendar_widget.dart';
import 'package:airline_app/screen/reviewsubmission/scanner_screen.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/calendar.dart';
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
  final _boardingPassController = BoardingPassController();
  bool isLoading = true;
  String selectedType = "All";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      await Future.wait([
        _boardingPassController
            .getBoardingPasses(ref.read(userDataProvider)?['userData']?['_id'])
            .then((boardingPasses) {
          if (mounted) {
            ref.read(boardingPassesProvider.notifier).setData(boardingPasses);
          }
        })
      ]);
    } catch (e) {
      debugPrint('Error loading data: $e');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void onTypeSelected(String type) {
    setState(() {
      selectedType = type;
    });
  }

  void _showSyncOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border(
                top: BorderSide(color: Colors.black, width: 2.0),
                left: BorderSide(color: Colors.black, width: 2.0),
                bottom: BorderSide(color: Colors.black, width: 4.0),
                right: BorderSide(color: Colors.black, width: 4.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                NavButton(
                  text: 'Google Calendar',
                  onPressed: () {
                       Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalendarEventsWidget(),
                      ),
                    );
                  },
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                NavButton(
                  text: 'Wallet',
                  onPressed: () {
                    // Handle Wallet sync
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                NavButton(
                  text: 'Scanning',
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
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 24),
      Text(
        AppLocalizations.of(context).translate('Nothing to show here'),
        style: AppStyles.textStyle_24_600,
      ),
      Text(
          AppLocalizations.of(context).translate(
              'Here, you can synchronize your calendar and wallet or manually input the review details.'),
          style: AppStyles.textStyle_15_500
              .copyWith(color: const Color(0xff38433E))),
    ]);
  }

  Widget _buildTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Text(
            AppLocalizations.of(context).translate('Type'),
            style: AppStyles.textStyle_18_600,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TypeButton(
              text: "All",
              isSelected: selectedType == "All",
              onTap: () => onTypeSelected("All"),
            ),
            const SizedBox(width: 8),
            TypeButton(
              text: "Flights",
              isSelected: selectedType == "Flights",
              onTap: () => onTypeSelected("Flights"),
            ),
            const SizedBox(width: 8),
            TypeButton(
              text: "Airports",
              isSelected: selectedType == "Airports",
              onTap: () => onTypeSelected("Airports"),
            ),
          ],
        ),
        const SizedBox(height: 26),
        const Divider(color: Colors.black, thickness: 2),
      ],
    );
  }

  Widget _buildCardWidget(BoardingPass singleBoardingPass) {
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
                if (selectedType == "All") const SizedBox(height: 10),
                ReviewAirportCard(
                    index: index,
                    status: singleBoardingPass.visitStatus,
                    airlineCode: singleBoardingPass.airlineCode,
                    airportCode: singleBoardingPass.departureAirportCode,
                    time: singleBoardingPass.departureTime,
                    isDeparture: true,
                    isReviewed: singleBoardingPass.isDepartureAirportReviewed),
                const SizedBox(height: 10),
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

  @override
  Widget build(BuildContext context) {
    final List<BoardingPass> boardingPasses = ref.watch(boardingPassesProvider);
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: screenSize.height * 0.08,
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
        body: isLoading
            ? const Center(child: LoadingWidget())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: boardingPasses.isEmpty
                    ? _buildEmptyState()
                    : ListView(
                        children: [
                          _buildTypeSelector(),
                          const SizedBox(height: 12),
                          ...boardingPasses.map(_buildCardWidget),
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  NavButton(
                    text: AppLocalizations.of(context).translate('Synchronize'),
                    onPressed: _showSyncOptions,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  NavButton(
                    text: AppLocalizations.of(context)
                        .translate('Input manually'),
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
      ),
    );
  }
}
