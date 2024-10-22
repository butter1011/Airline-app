import 'package:airline_app/screen/leaderboard/leaderboard_detail/detail_airport.dart';
import 'package:airline_app/screen/leaderboard/leaderboard_home.dart/leaderboard_screen.dart';
import 'package:airline_app/screen/profile/profile_screen.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
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
      routes: {
        AppRoutes.leaderboarderscreen: (context) => LeaderboardScreen(),
        AppRoutes.profilescreen: (context) => ProfileScreen(),
        AppRoutes.detailairport: (context) => DetailAirport(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Airline App',
    );
  }
}
