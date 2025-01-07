import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

class GoogleSignInHelper {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/calendar',
      'https://www.googleapis.com/auth/calendar.events',
    ],
    signInOption: SignInOption.standard,
  );

  Future<calendar.CalendarApi?> getCalendarApi() async {
    try {
      await _googleSignIn.signOut(); // Sign out first to clear any existing sessions
      
      // Sign in and get authentication
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) return null;

      // Ensure authentication is valid
      await account.authentication;

      // Get the authenticated HTTP client
      final httpClient = await _googleSignIn.authenticatedClient();
      if (httpClient == null) return null;

      // Create and return the Calendar API instance
      return calendar.CalendarApi(httpClient);
    } catch (error) {
      print('Error signing in: $error');
      await _googleSignIn.signOut(); // Clean up on error
      return null;
    }
  }
}