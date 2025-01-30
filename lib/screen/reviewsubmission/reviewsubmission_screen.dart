import 'package:airline_app/controller/boarding_pass_controller.dart';
import 'package:airline_app/models/boarding_pass.dart';
import 'package:airline_app/provider/boarding_passes_provider.dart';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/screen/app_widgets/appbar_widget.dart';
import 'package:airline_app/screen/app_widgets/loading.dart';
import 'package:airline_app/screen/reviewsubmission/google_calendar/google_calendar_screen.dart';
import 'package:airline_app/screen/reviewsubmission/scanner_screen/scanner_screen.dart';
import 'package:airline_app/screen/reviewsubmission/wallet_sync_screen.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_button.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/review_flight_card.dart';
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
  bool isLoading = true;
  String selectedType = "All";

  final _boardingPassController = BoardingPassController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void onTypeSelected(String type) {
    setState(() {
      selectedType = type;
    });
  }

  Future<void> _loadData() async {
    try {
      await Future.wait([
        _boardingPassController
            .getBoardingPasses(ref.read(userDataProvider)?['userData']['_id'])
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<BoardingPass> boardingPasses = ref.watch(boardingPassesProvider);
    return PopScope(
      canPop: false, // Prevents the default pop action
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
        }
      },
      child: Scaffold(
        appBar: AppbarWidget(
          title: "Reviews",
          onBackPressed: () {
            Navigator.pop(context);
          },
        ),
        body: isLoading
            ? const Center(child: LoadingWidget())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: boardingPasses.isEmpty
                    ? _buildEmptyState()
                    : ListView(
                        children: [
                          // _buildTypeSelector(),
                          const SizedBox(height: 24),
                          ...boardingPasses.map(_buildCardWidget),
                        ],
                      ),
              ),
        bottomNavigationBar: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  NavButton(
                    text: AppLocalizations.of(context).translate('Next'),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 16),
                                child: Column(
                                  children: [
                                    NavButton(
                                      text: AppLocalizations.of(context)
                                          .translate('Sync from Your Wallet'),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const WalletSyncScreen(),
                                          ),
                                        );
                                      },
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 12),
                                    NavButton(
                                      text: AppLocalizations.of(context)
                                          .translate(
                                              'Sync from Google Calendar'),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                GoogleCalendarScreen(),
                                          ),
                                        );
                                      },
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 12),
                                    NavButton(
                                      text: AppLocalizations.of(context)
                                          .translate('Scan'),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ScannerScreen(),
                                          ),
                                        );
                                      },
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    color: AppStyles.backgroundColor,
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
