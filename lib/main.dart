import 'package:airline_app/screen/bottom_nav_bar.dart';
import 'package:airline_app/screen/chatbot/chatbot_screen.dart';
import 'package:airline_app/screen/leaderboard/filter/filter_screen.dart';
import 'package:airline_app/screen/leaderboard/media_full_screen/media_full_screen.dart';
import 'package:airline_app/screen/logIn/signup.dart';
import 'package:airline_app/screen/logIn/logIn.dart';
import 'package:airline_app/screen/logIn/start_screen.dart';
import 'package:airline_app/screen/leaderboard/leaderboard_detail/detail_airport.dart';
import 'package:airline_app/screen/leaderboard/leaderboard_home.dart/leaderboard_screen.dart';
import 'package:airline_app/screen/profile/book_mark_screen.dart';
import 'package:airline_app/screen/profile/notifications_screen.dart';
import 'package:airline_app/screen/profile/profile_screen.dart';

import 'package:airline_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  String ACCESS_TOKEN = const String.fromEnvironment(
      "pk.eyJ1Ijoia2luZ2J1dHRlciIsImEiOiJjbTJwcTZtcngwb3gzMnJzMjk0amtrNG14In0.dauZLQQedNrrHuzb1sRxOw");
  MapboxOptions.setAccessToken(ACCESS_TOKEN);
  runApp(const MyApp());
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      routes: {
        AppRoutes.bottomnavbar: (context) => const BottomNavBar(),
        AppRoutes.startscreen: (context) => const StartScreen(),
        AppRoutes.loginscreen: (context) => const Login(),
        AppRoutes.signupscreen: (context) => const SignUp(),
        AppRoutes.leaderboardscreen: (context) => const LeaderboardScreen(),
        AppRoutes.detailairport: (context) => const DetailAirport(),
        AppRoutes.mediafullscreen: (context) => const MediaFullScreen(),
        AppRoutes.profilescreen: (context) => const ProfileScreen(),
        AppRoutes.filterscreen: (context) => const FilterScreen(),
        AppRoutes.chatbotscreen: (context) => const ChatbotScreen(),
        AppRoutes.bookmarkprofilescreen: (context) => BookMarkScreen(),
        AppRoutes.cardnotificationscreen: (context) => NotificationsScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
