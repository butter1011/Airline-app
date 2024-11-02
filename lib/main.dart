import 'package:airline_app/screen/chatbot/chatbot_screen.dart';
import 'package:airline_app/screen/feed/feed_screen.dart';
import 'package:airline_app/screen/leaderboard/filter_screen.dart';
import 'package:airline_app/screen/leaderboard/media_full_screen.dart';
import 'package:airline_app/screen/logIn/logIn.dart';
import 'package:airline_app/screen/logIn/skip_screen.dart';

import 'package:airline_app/screen/leaderboard/detail_airport.dart';
import 'package:airline_app/screen/leaderboard/leaderboard_screen.dart';
import 'package:airline_app/screen/profile/about_app.dart';
import 'package:airline_app/screen/profile/book_mark_screen.dart';
import 'package:airline_app/screen/profile/edit_profile_screen.dart';
import 'package:airline_app/screen/profile/notifications_screen.dart';
import 'package:airline_app/screen/profile/profile_screen.dart';
import 'package:airline_app/screen/profile/support_screen.dart';
import 'package:airline_app/screen/profile/terms_of_service.dart';
import 'package:airline_app/screen/reviewsubmission/detail_first_screen.dart';
import 'package:airline_app/screen/reviewsubmission/detail_second_screen%20copy.dart';
import 'package:airline_app/screen/reviewsubmission/question_first_screen.dart';
import 'package:airline_app/screen/reviewsubmission/question_second_screen.dart';
import 'package:airline_app/screen/reviewsubmission/question_third_screen.dart';
import 'package:airline_app/screen/reviewsubmission/flight_input_screen.dart';
import 'package:airline_app/screen/reviewsubmission/manual_input_screen.dart';
import 'package:airline_app/screen/reviewsubmission/reviewsubmission_screen.dart';
import 'package:airline_app/screen/reviewsubmission/synced_screen.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // String ACCESS_TOKEN = const String.fromEnvironment(
  //     "pk.eyJ1Ijoia2luZ2J1dHRlciIsImEiOiJjbTJwcTZtcngwb3gzMnJzMjk0amtrNG14In0.dauZLQQedNrrHuzb1sRxOw");
  // MapboxOptions.setAccessToken(ACCESS_TOKEN);
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
        ),
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      routes: {
        AppRoutes.loginscreen: (context) => const Login(),
        AppRoutes.skipscreen: (context) => const SkipScreen(),
        AppRoutes.reviewsubmissionscreen: (context) =>
            const ReviewsubmissionScreen(),
        AppRoutes.syncedscreen: (context) => SyncedScreen(),
        AppRoutes.feedscreen: (context) => FeedScreen(),
        AppRoutes.leaderboardscreen: (context) => const LeaderboardScreen(),
        AppRoutes.detailairport: (context) => const DetailAirport(),
        AppRoutes.mediafullscreen: (context) => const MediaFullScreen(),
        AppRoutes.profilescreen: (context) => const ProfileScreen(),
        AppRoutes.filterscreen: (context) => const FilterScreen(),
        AppRoutes.chatbotscreen: (context) => const ChatbotScreen(),
        AppRoutes.bookmarkprofilescreen: (context) => BookMarkScreen(),
        AppRoutes.cardnotificationscreen: (context) => NotificationsScreen(),
        AppRoutes.manualinput: (context) => ManualInputScreen(),
        AppRoutes.flightinput: (context) => FlightInputScreen(),
        AppRoutes.questionfirstscreen: (context) => QuestionFirstScreen(),
        AppRoutes.detailfirstscreen: (context) => DetailFirstScreen(),
        AppRoutes.questionsecondscreen: (context) => QuestionSecondScreen(),
        AppRoutes.detailsecondscreen: (context) => DetailSecondScreen(),
        AppRoutes.questionthirdscreen: (context) => QuestionThirdScreen(),
        AppRoutes.profilesupportscreen: (context) => SupportScreen(),
        AppRoutes.eidtprofilescreen: (context) => EditProfileScreen(),
        AppRoutes.aboutapp: (context) => AboutApp(),
        AppRoutes.termsofservice: (context) => TermsOfService(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
