import 'package:airline_app/controller/boarding_pass_controller.dart';
import 'package:airline_app/controller/fetch_flight_info_by_cirium.dart';
import 'package:airline_app/models/boarding_pass.dart';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/screen/app_widgets/appbar_widget.dart';
import 'package:airline_app/screen/app_widgets/bottom_button_bar.dart';
import 'package:airline_app/screen/app_widgets/custom_snackbar.dart';
import 'package:airline_app/screen/app_widgets/loading.dart';
import 'package:airline_app/screen/app_widgets/main_button.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'google_sign_in_helper.dart';

class GoogleCalendarScreen extends StatefulWidget {
  const GoogleCalendarScreen({super.key});

  @override
  State<GoogleCalendarScreen> createState() => _GoogleCalendarScreenState();
}

class _GoogleCalendarScreenState extends State<GoogleCalendarScreen> {
  final GoogleSignInHelper _signInHelper = GoogleSignInHelper();
  List<calendar.Event> _events = [];
  bool _isLoading = false;
  String? _error;

  Future<void> _fetchEvents() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final calendarApi = await _signInHelper.getCalendarApi();

      if (calendarApi == null) {
        throw Exception('Failed to initialize Calendar API');
      }

      final now = DateTime.now();
      final events = await calendarApi.events.list(
        'primary',
        timeMin: now.subtract(const Duration(days: 335)).toUtc(),
        timeMax: now.add(const Duration(days: 30)).toUtc(),
        orderBy: 'startTime',
        singleEvents: true,
        maxResults: 100,
      );

      setState(() {
        _events = (events.items ?? [])
            .where((event) =>
                event.summary != null &&
                RegExp(r'\([A-Z]{2} \d+\)').hasMatch(event.summary!))
            .toList();
        _isLoading = false;
      });
      for (var event in _events) {
        print("Event Details:");
        print("Summary: ${event.summary}");
        print("Description: ${event.description}");
        print("Start Time: ${event.start?.dateTime ?? event.start?.date}");
        print("End Time: ${event.end?.dateTime ?? event.end?.date}");
        print("Location: ${event.location}");
        print("Creator: ${event.creator?.email}");
        print("Created: ${event.created}");
        print("Updated: ${event.updated}");
        print("Status: ${event.status}");
        print("Event Keys:");
        event.toJson().keys.forEach((key) {
          print(key);
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
      if (mounted) {
        CustomSnackBar.error(context, 'Error: $_error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarWidget(
          title: AppLocalizations.of(context).translate('Calendar Events'),
          onBackPressed: () {
            Navigator.pop(context);
          },
        ),
        body: RefreshIndicator(
          onRefresh: _fetchEvents,
          child: _isLoading
              ? const Center(child: LoadingWidget())
              : _error != null
                  ? Center(child: Text('Error: $_error'))
                  : _events.isEmpty
                      ? Center(
                          child: Text(
                          'No upcoming events',
                          style: AppStyles.textStyle_14_600,
                        ))
                      : ListView.builder(
                          itemCount: _events.length,
                          itemBuilder: (context, index) {
                            final event = _events[index];
                            return EventCard(event: event);
                          },
                        ),
        ),
        bottomNavigationBar: BottomButtonBar(
            child: MainButton(
          text: AppLocalizations.of(context).translate('Fetch Events'),
          onPressed: _fetchEvents,
        )));
  }
}

class EventCard extends ConsumerStatefulWidget {
  const EventCard({super.key, required this.event});
  final calendar.Event event;

  @override
  ConsumerState<EventCard> createState() => _EventCardState();
}

class _EventCardState extends ConsumerState<EventCard> {
  final FetchFlightInforByCirium _flightInfoFetcher =
      FetchFlightInforByCirium();
  final BoardingPassController _boardingPassController =
      BoardingPassController();
  bool _isLoading = false;

  Future<void> parseEvent(calendar.Event event) async {
    setState(() => _isLoading = true);
    try {
      print("This is scanned barcode ========================> $event");

      final RegExp regexSummary = RegExp(r'\([A-Z]{2} \d+\)');
      final Match? match = regexSummary.firstMatch(event.summary!);
      final RegExp regexLocation = RegExp(r'([A-Z]{3})');
      final Match? matchLocation = regexLocation.firstMatch(event.location!);

      if (match == null) {
        throw Exception('Invalid barcode format');
      }

      final String pnr = event.iCalUID!;
      final String carrier = match.group(0)!.substring(1, 3);
      final String flightNumber =
          match.group(0)!.substring(4, match.group(0)!.length - 1);
      final DateTime date = event.start!.dateTime!;
      final String departureAirport = matchLocation!.group(0)!;
      final String classOfService = "Business";

      final bool pnrExists = await _boardingPassController.checkPnrExists(pnr);
      if (pnrExists) {
        if (mounted) {
          CustomSnackBar.info(
              context, 'Boarding pass has already been reviewed');
        }

        return;
      }

      Map<String, dynamic> flightInfo =
          await _flightInfoFetcher.fetchFlightInfo(
        carrier: carrier,
        flightNumber: flightNumber,
        flightDate: date,
        departureAirport: departureAirport,
      );

      await _processFetchedFlightInfo(flightInfo, pnr, classOfService);
    } catch (e) {
      if (mounted) {
        CustomSnackBar.error(context,
            'Oops! We had trouble processing your boarding pass. Please try again.');
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _processFetchedFlightInfo(Map<String, dynamic> flightInfo,
      String pnr, String classOfService) async {
    if (flightInfo['flightStatuses']?.isEmpty ?? true) {
      CustomSnackBar.info(
          context, 'No flight data found for the boarding pass.');
      return;
    }
    final flightStatus = flightInfo['flightStatuses'][0];
    final airlines = flightInfo['appendix']['airlines'];
    final airports = flightInfo['appendix']['airports'];
    final airlineName = airlines.firstWhere((airline) =>
        airline['fs'] == flightStatus['primaryCarrierFsCode'])['name'];
    final departureAirport = airports.firstWhere(
        (airport) => airport['fs'] == flightStatus['departureAirportFsCode']);
    final arrivalAirport = airports.firstWhere(
        (airport) => airport['fs'] == flightStatus['arrivalAirportFsCode']);
    final departureEntireTime =
        DateTime.parse(flightStatus['departureDate']['dateLocal']);
    final arrivalEntireTime =
        DateTime.parse(flightStatus['arrivalDate']['dateLocal']);

    final newPass = BoardingPass(
      name: ref.read(userDataProvider)?['userData']['_id'],
      pnr: pnr,
      airlineName: airlineName,
      departureAirportCode: departureAirport['fs'],
      departureCity: departureAirport['city'],
      departureCountryCode: departureAirport['countryCode'],
      departureTime: _formatTime(departureEntireTime),
      arrivalAirportCode: arrivalAirport['fs'],
      arrivalCity: arrivalAirport['city'],
      arrivalCountryCode: arrivalAirport['countryCode'],
      arrivalTime: _formatTime(arrivalEntireTime),
      classOfTravel: classOfService,
      airlineCode: flightStatus['carrierFsCode'],
      flightNumber:
          "${flightStatus['carrierFsCode']} ${flightStatus['flightNumber']}",
      visitStatus: _getVisitStatus(departureEntireTime),
    );

    final bool result = await _boardingPassController.saveBoardingPass(newPass);
    if (result) {
      if (mounted) {
        Navigator.pushNamed(context, AppRoutes.reviewsubmissionscreen);
        CustomSnackBar.success(context, 'Boarding pass saved successfully.');
      }
    }
  }

  String _getVisitStatus(DateTime departureEntireTime) {
    final now = DateTime.now();
    final difference = now.difference(departureEntireTime);

    if (departureEntireTime.isAfter(now)) {
      return "Upcoming";
    } else if (difference.inDays <= 20) {
      return "Recent";
    } else {
      return "Earlier";
    }
  }

  String _formatTime(DateTime? time) =>
      "${time?.hour.toString().padLeft(2, '0')}:${time?.minute.toString().padLeft(2, '0')}";

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: LoadingWidget())
        : InkWell(
            onTap: () {
              parseEvent(widget.event);
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.event.summary ?? 'No title',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Start: ${_formatTime(widget.event.start?.dateTime ?? widget.event.start?.date)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'End: ${_formatTime(widget.event.end?.dateTime ?? widget.event.end?.date)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
