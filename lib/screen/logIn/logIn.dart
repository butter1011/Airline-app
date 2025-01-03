import 'dart:io';
import 'dart:ui';
import 'dart:convert';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:airline_app/utils/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:otpless_flutter/otpless_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:airline_app/screen/app_widgets/loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airline_app/controller/get_airline_controller.dart';
import 'package:airline_app/controller/get_reviews_airline_controller.dart';

import 'package:airline_app/provider/airline_airport_review_provider.dart';
import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final _otplessFlutterPlugin = Otpless();
  List<Map<String, dynamic>> leaderBoardList = [];
  List<Map<String, dynamic>> reviewList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _otplessFlutterPlugin.enableDebugLogging(true);
    _checkToken();
    _initializeOtpless();
  }

  Future<void> _initializeOtpless() async {
    if (Platform.isAndroid) {
      await _otplessFlutterPlugin.enableDebugLogging(true);
      await _otplessFlutterPlugin.initHeadless(appId);
      _otplessFlutterPlugin.setHeadlessCallback(onHeadlessResult);
    }
    _otplessFlutterPlugin.setWebviewInspectable(true);
  }

  Future<void> _checkToken() async {
    setState(() {
      isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      // Token exists, fetch necessary data and navigate to LeaderboardScreen
      final userData = prefs.getString('userData');
      if (userData != null) {
        ref.read(userDataProvider.notifier).setUserData(json.decode(userData));
      }
      await _fetchDataAndNavigate();
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _fetchDataAndNavigate() async {
    final airlineController = GetAirlineAirportController();
    final result = await airlineController.getAirlineAirport();
    if (result['success']) {
      ref.read(airlineAirportProvider.notifier).setData(result['data']);
    }

    final reviewsController = GetReviewsAirlineController();
    final reviewsResult = await reviewsController.getReviews();
    if (reviewsResult['success']) {
      ref
          .read(reviewsAirlineProvider.notifier)
          .setReviewData(reviewsResult['data']);
    }

    Navigator.pushReplacementNamed(context, AppRoutes.leaderboardscreen);
  }

  void onHeadlessResult(dynamic result) async {
    String jsonString = jsonEncode(result);
    final response;
    print("----------------------------------------------");

    if (result != null && result['data'] != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Container(
            color: Colors.black.withOpacity(0.5),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: const Center(
                child: LoadingWidget(),
              ),
            ),
          );
        },
      );

      UserData userData = UserData.fromJson(jsonString);

      if (userData.channel == 'WHATSAPP') {
        response = await http.post(
          Uri.parse('$apiUrl/api/v1/user'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            'name': userData.name,
            'whatsappNumber': userData.identityValue,
            'email': "",
          }),
        );
      } else {
        response = await http.post(
          Uri.parse('$apiUrl/api/v1/user'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            'name': userData.name,
            'whatsappNumber': '',
            'email': userData.identityValue,
          }),
        );
      }

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        ref.read(userDataProvider.notifier).setUserData(responseData);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', userData.idToken);
        await prefs.setString('userData', json.encode(responseData));

        final airlineController = GetAirlineAirportController();
        final result = await airlineController.getAirlineAirport();
        if (result['success']) {
          ref.read(airlineAirportProvider.notifier).setData(result['data']);
        }

        final reviewsController = GetReviewsAirlineController();
        final reviewsResult = await reviewsController.getReviews();
        if (reviewsResult['success']) {
          ref
              .read(reviewsAirlineProvider.notifier)
              .setReviewData(reviewsResult['data']);
        }

        Navigator.pop(context); // Remove loading dialog

        if (responseData['userState'] == 0) {
          Navigator.pushReplacementNamed(context, AppRoutes.skipscreen);
        } else {
          Navigator.pushReplacementNamed(context, AppRoutes.leaderboardscreen);
        }
      } else {
        Navigator.pop(context); // Remove loading dialog
      }
    } else {
      _showErrorSnackBar('Login failed. Please try again.');
    }
  }

  Future<void> _openLoginPage() async {
    try {
      Map<String, dynamic> arg = {'appId': appId};
      await _otplessFlutterPlugin.openLoginPage(onHeadlessResult, arg);
    } catch (e) {
      print("Login error: $e");
      _showErrorSnackBar('WhatsApp login failed. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppStyles.mainColor,
      body: isLoading
          ? const LoadingWidget()
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/login.png',
                    width: screenSize.width,
                    height: screenSize.height * 0.74,
                    fit: BoxFit.cover,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      _openLoginPage();
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.only(bottom: 100, right: 48, left: 48),
                      child: Row(children: <Widget>[
                        Expanded(
                            child: Divider(
                          color: Colors.black,
                        )),
                        Text(
                          "   Tap here to signin   ",
                          style: TextStyle(
                              fontFamily: 'Clash Grotesk',
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                          selectionColor: Colors.black,
                        ),
                        Expanded(
                            child: Divider(
                          color: Colors.black,
                        )),
                      ]),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class UserData {
  final String name;
  final String identityValue;
  final String channel;
  final String idToken;

  UserData(
      {required this.name,
      required this.identityValue,
      required this.channel,
      required this.idToken});

  factory UserData.fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    final List<dynamic> identities = json['data']['identities'];

    if (identities.isEmpty) {
      throw Exception('No identities found in the JSON data');
    }

    final Map<String, dynamic> firstIdentity = identities.first;

    return UserData(
        name: firstIdentity['name'] ?? 'Unknown',
        identityValue: firstIdentity['identityValue'] ?? 'Unknown',
        channel: firstIdentity['channel'] ?? 'Unknown',
        idToken: json['data']['idToken'] ?? 'Unknown');
  }
}
