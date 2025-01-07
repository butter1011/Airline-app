import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'google_sign_in_help.dart';

class CalendarEventsWidget extends StatefulWidget {
  const CalendarEventsWidget({super.key});

  @override
  State<CalendarEventsWidget> createState() => _CalendarEventsWidgetState();
}

class _CalendarEventsWidgetState extends State<CalendarEventsWidget> {
  final GoogleSignInHelper _signInHelper = GoogleSignInHelper();
  List<calendar.Event> _events = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    if (!mounted) return;    
    setState(() {
      _isLoading = true;
    });

    try {
      final calendarApi = await _signInHelper.getCalendarApi();
      print("This is the calendarApi:🎁🎁 $calendarApi");
      if (calendarApi != null) {
        final now = DateTime.now();
        final events = await calendarApi.events.list(
          'primary',
          timeMin: now.toUtc(),
          timeMax: now.add(const Duration(days: 7)).toUtc(),
          orderBy: 'startTime',
          singleEvents: true,
        );

        if (!mounted) return;
        setState(() {
          _events = events.items ?? [];
        });
      }
    } catch (e) {
      if (!mounted) return;
      debugPrint('Error fetching events: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch calendar events')),
      );
    } finally {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _events.length,
                  itemBuilder: (context, index) {
                    final event = _events[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      child: ListTile(
                        title: Text(event.summary ?? 'No title'),
                        subtitle: Text(
                          '${_formatDateTime(event.start?.dateTime)} - '
                          '${_formatDateTime(event.end?.dateTime)}',
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    return dateTime.toLocal().toString().split('.')[0];
  }
}