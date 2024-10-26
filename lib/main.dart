import 'package:airline_app/screen/leaderboard/media_full_screen/media_full_screen.dart';
import 'package:airline_app/screen/logIn/logIn.dart';
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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        AppRoutes.loginscreen: (context) => Login(),
        AppRoutes.leaderboardscreen: (context) => LeaderboardScreen(),
        AppRoutes.profilescreen: (context) => ProfileScreen(),
        AppRoutes.detailairport: (context) => DetailAirport(),
        AppRoutes.mediafullscreen: (context) => MediaFullScreen(),
        AppRoutes.bookmarkprofilescreen: (context) => BookMarkScreen(),
        AppRoutes.cardnotificationscreen: (context) => NotificationsScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
