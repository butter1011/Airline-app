import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'google_sign_in_helper.dart';

class CalendarEventsWidget extends StatefulWidget {
  const CalendarEventsWidget({super.key});

  @override
  State<CalendarEventsWidget> createState() => _CalendarEventsWidgetState();
}

class _CalendarEventsWidgetState extends State<CalendarEventsWidget> {
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
        timeMin: now.toUtc(),
        timeMax: now.add(const Duration(days: 7)).toUtc(),
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
        title: const Text('Calendar Events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchEvents,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _fetchEvents,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text('Error: $_error'))
                : _events.isEmpty
                    ? const Center(child: Text('No upcoming events'))
                    : ListView.builder(
                        itemCount: _events.length,
                        itemBuilder: (context, index) {
                          final event = _events[index];
                          return EventCard(event: event);
                        },
                      ),
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
