import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

class GoogleCalendar extends StatefulWidget {
  const GoogleCalendar({super.key});

  @override
  State<GoogleCalendar> createState() => _GoogleCalendarState();
}

class _GoogleCalendarState extends State<GoogleCalendar> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [calendar.CalendarApi.calendarReadonlyScope],
  );
  List<calendar.Event> _events = [];
  bool _isLoading = false;

  Future<void> _getCalendarEvents() async {
    setState(() => _isLoading = true);
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        // Get user's email
        final userEmail = account.email;
      
        final authClient = await _googleSignIn.authenticatedClient();
        if (authClient != null) {
          final calendarApi = calendar.CalendarApi(authClient);
        
          // First get the calendar ID for the user's primary calendar
          final calendarList = await calendarApi.calendarList.list();
          final userCalendar = calendarList.items?.firstWhere(
            (cal) => cal.id == userEmail,
            orElse: () => calendar.CalendarListEntry(id: 'primary'),
          );

          // Fetch events using the user's calendar ID
          final calendarEvents = await calendarApi.events.list(
            userCalendar!.id!,
            timeMin: DateTime.now(),
            maxResults: 10,
            singleEvents: true,
            orderBy: 'startTime',
          );
        
          setState(() {
            _events = calendarEvents.items ?? [];
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching calendar events: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _getCalendarEvents,
          ),
        ],
      ),


      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _events.isEmpty
              ? Center(
                  child: ElevatedButton(
                    onPressed: _getCalendarEvents,
                    child: const Text('Load Calendar Events'),
                  ),
                )
              : ListView.builder(
                  itemCount: _events.length,
                  itemBuilder: (context, index) {
                    final event = _events[index];
                    return ListTile(
                      title: Text(event.summary ?? 'No title'),
                      subtitle: Text(
                        '${event.start?.dateTime?.toString() ?? 'No start time'} - ${event.end?.dateTime?.toString() ?? 'No end time'}',
                      ),
                    );
                  },
                ),
    );
  }
}