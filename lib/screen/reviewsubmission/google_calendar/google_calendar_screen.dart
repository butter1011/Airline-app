import 'package:airline_app/screen/app_widgets/loading.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_button.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
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
        _events = events.items ?? [];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $_error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 52.2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Navigator.pop(context), // Navigate back when pressed
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('Calendar Events'),
          style: AppStyles.textStyle_18_600,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            color: Colors.black,
            height: 4.0,
          ),
        ),
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
                  text: AppLocalizations.of(context).translate('Fetch Events'),
                  onPressed: _fetchEvents,
                  color: AppStyles.mainColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final calendar.Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.summary ?? 'No title',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Start: ${_formatDateTime(event.start?.dateTime ?? event.start?.date)}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'End: ${_formatDateTime(event.end?.dateTime ?? event.end?.date)}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    return '${dateTime.toLocal().year}-'
        '${dateTime.toLocal().month.toString().padLeft(2, '0')}-'
        '${dateTime.toLocal().day.toString().padLeft(2, '0')} '
        '${dateTime.toLocal().hour.toString().padLeft(2, '0')}:'
        '${dateTime.toLocal().minute.toString().padLeft(2, '0')}';
  }
}
