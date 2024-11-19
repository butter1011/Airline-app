import 'package:airline_app/screen/app_widgets/animaton_widget.dart';
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
import 'package:airline_app/screen/reviewsubmission/review_airline/detail_first_screen_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/review_airline/detail_second_screen_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/review_airline/question_first_screen_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/review_airline/question_second_screen_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/review_airline/question_third_screen_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/review_airline/flight_input_screen.dart';
import 'package:airline_app/screen/reviewsubmission/manual_input_screen.dart';
import 'package:airline_app/screen/reviewsubmission/review_airport/airport_input_screen.dart';
import 'package:airline_app/screen/reviewsubmission/review_airport/detail_first_screen_for_airport.dart';
import 'package:airline_app/screen/reviewsubmission/review_airport/detail_second_screen_for_airport.dart';
import 'package:airline_app/screen/reviewsubmission/review_airport/question_first_screen_for_airport.dart';
import 'package:airline_app/screen/reviewsubmission/review_airport/question_second_screen_for_airport.dart';
import 'package:airline_app/screen/reviewsubmission/review_airport/question_third_screen_for_airport.dart';
import 'package:airline_app/screen/reviewsubmission/reviewsubmission_screen.dart';
import 'package:airline_app/screen/reviewsubmission/synced_screen.dart';
import 'package:airline_app/utils/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

void main() {
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
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
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

        //Airlines routes
        AppRoutes.flightinput: (context) => FlightInputScreen(),
        AppRoutes.questionfirstscreenforairline: (context) =>
            QuestionFirstScreenForAirline(),
        AppRoutes.detailfirstscreenforairline: (context) =>
            DetailFirstScreenForAirline(),
        AppRoutes.questionsecondscreenforairline: (context) =>
            QuestionSecondScreenForAirline(),
        AppRoutes.detailsecondscreenforairline: (context) =>
            DetailSecondScreenForAirline(),
        AppRoutes.questionthirdscreenforairline: (context) =>
            QuestionThirdScreenForAirline(),

        // Airports routes
        AppRoutes.airportinput: (context) => AirportInputScreen(),
        AppRoutes.questionfirstscreenforairport: (context) =>
            QuestionFirstScreenForAirport(),
        AppRoutes.detailfirstscreenforairport: (context) =>
            DetailFirstScreenForAirport(),
        AppRoutes.questionsecondscreenforairport: (context) =>
            QuestionSecondScreenForAirport(),
        AppRoutes.detailsecondscreenforairport: (context) =>
            DetailSecondScreenForAirport(),
        AppRoutes.questionthirdscreenforairport: (context) =>
            QuestionThirdScreenForAirport(),

        AppRoutes.profilesupportscreen: (context) => SupportScreen(),
        AppRoutes.eidtprofilescreen: (context) => EditProfileScreen(),
        AppRoutes.aboutapp: (context) => AboutApp(),
        AppRoutes.termsofservice: (context) => TermsOfService(),
        AppRoutes.animation: (context) => AnimationS(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
