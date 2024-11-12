import 'dart:convert';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:otpless_flutter/otpless_flutter.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _otplessFlutterPlugin = Otpless();
  static const String appId = "bzpl0offchgcjrm8a4sj";

  @override
  void initState() {
    super.initState();
    _initializeOtpless();
  }

  Future<void> _initializeOtpless() async {
    await _otplessFlutterPlugin.enableDebugLogging(true);
    await _otplessFlutterPlugin.initHeadless(appId);
    _otplessFlutterPlugin.setHeadlessCallback(onHeadlessResult);
  }

  void onHeadlessResult(dynamic result) async {
    String jsonString = jsonEncode(result);
    if (result != null && result['data'] != null) {
      print('🏆🏆🏆🏆$result');
      UserData userData = UserData.fromJson(jsonString);
      print('Name: ${userData.name}');
      print('Identity Value: ${userData.identityValue}');

      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/auth/signin'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
            {'name': userData.name, 'identityValue': userData.identityValue}),
      );
      if (response.statusCode == 200) {
        print('🌹🌹🌹🌹🌹Authentication successful');
        final responseData = jsonDecode(response.body);
        if (responseData['userState'] == 0) {
          Navigator.pushNamed(context, AppRoutes.skipscreen);
        } else {
          Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
        }

        // You might want to store the user ID or navigate to a new screen
      } else {
        // Handle authentication error
        print('Authentication failed: ${response.body}');
      }
    } else {
      _showErrorSnackBar('Login failed. Please try again.');
    }
  }

  Future<void> _loginWithWhatsApp() async {
    try {
      Map<String, dynamic> arg = {'appId': appId};
      await _otplessFlutterPlugin.openLoginPage(onHeadlessResult, arg);
    } catch (e) {
      print('WhatsApp login error: $e');
      _showErrorSnackBar('WhatsApp login failed. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyles.mainColor,
        body: Center(
          // width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/plane.png',
                width: 575,
                height: 575,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () {
                  _loginWithWhatsApp();
                },
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      width: 327,
                      height: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(27),
                        border: Border.all(
                          width: 2,
                          color: AppStyles.littleBlackColor,
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: AppStyles.littleBlackColor,
                              offset: const Offset(3, 3))
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/whatsapp.png',
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Sign in with Google',
                                style: AppStyles.textStyle_15_600),
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ));
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

  UserData({required this.name, required this.identityValue});

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
    );
  }
}
