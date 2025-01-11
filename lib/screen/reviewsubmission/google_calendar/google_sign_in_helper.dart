import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

class GoogleSignInHelper {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/calendar', // Changed to full calendar access
      'https://www.googleapis.com/auth/calendar.events',
    ],
  );

  GoogleSignInAccount? currentUser;

  Future<calendar.CalendarApi?> getCalendarApi() async {
    try {
      // Check if already signed in
      currentUser =
          _googleSignIn.currentUser ?? await _googleSignIn.signInSilently();
      currentUser ??= await _googleSignIn.signIn();

      if (currentUser == null) return null;

      // Get the authenticated HTTP client
      final httpClient = await _googleSignIn.authenticatedClient();
      if (httpClient == null) return null;

      return calendar.CalendarApi(httpClient);
    } catch (error) {
      print('Error signing in: $error');
      rethrow; // Rethrow to handle in UI
    }
  }
}
