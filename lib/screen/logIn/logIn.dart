import 'dart:io';
import 'dart:ui';
import 'dart:convert';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:airline_app/utils/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otpless_flutter/otpless_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:airline_app/screen/app_widgets/loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

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
    final lastAccessTime = prefs.getInt('lastAccessTime');
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    // Check if 24 hours have passed since last access
    if (token != null &&
        lastAccessTime != null &&
        currentTime - lastAccessTime < Duration(hours: 24).inMilliseconds) {
      // Update last access time
      await prefs.setInt('lastAccessTime', currentTime);

      final userData = prefs.getString('userData');
      if (userData != null) {
        ref.read(userDataProvider.notifier).setUserData(json.decode(userData));
        if (mounted) {
          Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
        }
      }
    } else {
      await prefs.clear();
    }
    setState(() {
      isLoading = false;
    });
  }

  void onHeadlessResult(dynamic result) async {
    String jsonString = jsonEncode(result);
    final http.Response response;

    if (result != null && result['data'] != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Container(
            color: Colors.white.withOpacity(0.9),
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
            'apple': "",
          }),
        );
      } else if (userData.channel == 'APPLE') {
        response = await http.post(
          Uri.parse('$apiUrl/api/v1/user'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            'name': userData.name,
            'whatsappNumber': "",
            'email': "",
            'apple': userData.identityValue,
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
            'apple': "",
          }),
        );
      }

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        ref.read(userDataProvider.notifier).setUserData(responseData);

        // When storing the data
        final prefs = await SharedPreferences.getInstance();
        final lastAccessTime = DateTime.now().millisecondsSinceEpoch;

        await prefs.setString('token', userData.idToken);
        await prefs.setString('userData', json.encode(responseData));
        await prefs.setInt('lastAccessTime', lastAccessTime);

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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Column(children: [
                Image.asset(
                  'assets/icon/logoIcon.png',
                  width: screenSize.width * 0.5,
                  // height: screenSize.width * 0.5,
                  // fit: BoxFit.cover,
                ),
                // SizedBox(
                //   height: 18,
                // ),
                Text("Exp.aero",
                    style: TextStyle(
                        fontFamily: 'ArialBlack',
                        fontWeight: FontWeight.w900,
                        fontSize: 60,
                        height: 0.8,
                        color: Colors.black)),
                SizedBox(
                  height: 214,
                ),
                Text(
                  "Let's get flying",
                  style: TextStyle(
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      color: Colors.black),
                ),
              ]),
            ),
          ),

          // Existing Content
          isLoading
              ? const LoadingWidget()
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          _openLoginPage();
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.only(bottom: 68, right: 24, left: 24),
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(2, 2),
                                  )
                                ],
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                )),
                            child: Center(
                              child: Text(
                                "   Tap here to signin   ",
                                style: TextStyle(
                                    fontFamily: 'Clash Grotesk',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                                selectionColor: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Center(child: Text(message, style: AppStyles.textStyle_14_600)),
        backgroundColor: AppStyles.notifyColor,
      ),
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
