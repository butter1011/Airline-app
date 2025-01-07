import 'package:airline_app/screen/chatbot/ai_chatbot.dart';
import 'package:airline_app/screen/feed/feed_filter_screen.dart';
import 'package:airline_app/screen/feed/feed_screen.dart';
import 'package:airline_app/screen/leaderboard/leaderboard_filter_screen.dart';
import 'package:airline_app/screen/leaderboard/media_full_screen.dart';
import 'package:airline_app/screen/logIn/logIn.dart';
import 'package:airline_app/screen/logIn/skip_screen.dart';
import 'package:airline_app/screen/leaderboard/detail_airport.dart';
import 'package:airline_app/screen/leaderboard/leaderboard_screen.dart';
import 'package:airline_app/screen/profile/about_app.dart';
import 'package:airline_app/screen/profile/book_mark_screen.dart';
import 'package:airline_app/screen/profile/calender_sync_screen.dart';
import 'package:airline_app/screen/profile/edit_profile_screen.dart';
import 'package:airline_app/screen/profile/help_faq.dart';
import 'package:airline_app/screen/profile/notifications_screen.dart';
import 'package:airline_app/screen/profile/profile_screen.dart';
import 'package:airline_app/screen/profile/support_screen.dart';
import 'package:airline_app/screen/profile/terms_of_service.dart';
import 'package:airline_app/screen/reviewsubmission/complete_reviews.dart';
import 'package:airline_app/screen/reviewsubmission/google_calendar.dart';
import 'package:airline_app/screen/reviewsubmission/review_airline/detail_first_screen_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/review_airline/detail_second_screen_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/review_airline/overview_airline_review_screen.dart';
import 'package:airline_app/screen/reviewsubmission/review_airline/question_first_screen_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/review_airline/question_second_screen_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/review_airline/question_third_screen_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/review_airline/flight_input_screen.dart';
import 'package:airline_app/screen/reviewsubmission/manual_input_screen.dart';
import 'package:airline_app/screen/reviewsubmission/review_airport/airport_input_screen.dart';
import 'package:airline_app/screen/reviewsubmission/review_airport/detail_first_screen_for_airport.dart';
import 'package:airline_app/screen/reviewsubmission/review_airport/detail_second_screen_for_airport.dart';
import 'package:airline_app/screen/reviewsubmission/review_airport/overview_airport_review_screen.dart';
import 'package:airline_app/screen/reviewsubmission/review_airport/question_first_screen_for_airport.dart';
import 'package:airline_app/screen/reviewsubmission/review_airport/question_second_screen_for_airport.dart';
import 'package:airline_app/screen/reviewsubmission/review_airport/question_third_screen_for_airport.dart';
import 'package:airline_app/screen/reviewsubmission/reviewsubmission_screen.dart';
import 'package:airline_app/screen/reviewsubmission/start_reviews.dart';
import 'package:airline_app/screen/reviewsubmission/synced_screen.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final String languageCode = prefs.getString('selectedLanguageSym') ?? 'en';

  runApp(
    ProviderScope(
      overrides: [
        localeProvider.overrideWith((ref) => Locale(languageCode)),
      ],
      child: MyApp(),
    ),
  );
}

final localeProvider = StateProvider<Locale>((ref) => Locale('en'));

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return MaterialApp(
      locale: locale,
      supportedLocales: [
        Locale('en', ''),
        Locale('zh', ''),
        Locale('es', ''),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Airline App',
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
            TargetPlatform.android: CustomPageTransitionBuilder(),
            TargetPlatform.iOS: CustomPageTransitionBuilder(),
          },
        ),
      ),
      routes: {
        AppRoutes.chatbotscreen: (context) => const ChatScreen(),
        AppRoutes.loginscreen: (context) => const Login(),
        AppRoutes.skipscreen: (context) => const SkipScreen(),
        AppRoutes.startreviews: (context) => const StartReviews(),
        AppRoutes.reviewsubmissionscreen: (context) =>
            const ReviewsubmissionScreen(),
        AppRoutes.syncedscreen: (context) => SyncedScreen(),
        AppRoutes.feedscreen: (context) => FeedScreen(),
        AppRoutes.feedfilterscreen: (context) => FeedFilterScreen(),
        AppRoutes.leaderboardscreen: (context) => const LeaderboardScreen(),
        AppRoutes.detailairport: (context) => const DetailAirport(),
        AppRoutes.mediafullscreen: (context) => const MediaFullScreen(),
        AppRoutes.profilescreen: (context) => const ProfileScreen(),
        AppRoutes.filterscreen: (context) => const LeaderboardFilterScreen(),
        AppRoutes.bookmarkprofilescreen: (context) => BookMarkScreen(),
        AppRoutes.cardnotificationscreen: (context) => NotificationsScreen(),
        AppRoutes.manualinput: (context) => ManualInputScreen(),

        //Airlines routes
        AppRoutes.flightinput: (context) => FlightInputScreen(),
        AppRoutes.overviewairlinereviewscreen: (context) =>
            OverviewAirlineReviewScreen(),
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
        AppRoutes.overviewairportreviewscreen: (context) =>
            OverviewAirportReviewScreen(),
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
        //////
        AppRoutes.completereviews: (context) => CompleteReviews(),

        AppRoutes.profilesupportscreen: (context) => SupportScreen(),
        AppRoutes.eidtprofilescreen: (context) => EditProfileScreen(),
        AppRoutes.aboutapp: (context) => AboutApp(),
        AppRoutes.helpFaqs: (context) => HelpFaq(),
        AppRoutes.termsofservice: (context) => TermsOfService(),
        AppRoutes.calendersyncscreen: (context) => CalenderSyncScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      )),
      child: child,
    );
  }
}
