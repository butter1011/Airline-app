import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
    // clientId:
    //     '449918634761-ngrqgm8s6qsvo25o16mkklsprhqa4alo.apps.googleusercontent.com',
  );

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      print('😍$googleUser');
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final String? accessToken = googleAuth.accessToken;
        googleAuth.idToken;

        print('🏆🏆🏆🏆 ${googleAuth.accessToken}');
        print(googleUser);

        final response = await http.post(
          Uri.parse('http://10.0.2.2:3000/auth/google'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({'accessToken': accessToken}),
        );

        if (response.statusCode == 200) {
          // Handle successful authentication
          print('✔✔😔✔Authentication successful');
          Navigator.pushNamed(context, AppRoutes.skipscreen);

          final responseData = jsonDecode(response.body);
          print('User ID: ${responseData['userId']}');
          // You might want to store the user ID or navigate to a new screen
        } else {
          // Handle authentication error
          print('Authentication failed: ${response.body}');
        }
      }
    } catch (error) {
      print('Error during Google sign in: $error');
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
              const SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () {
                  _handleSignIn();
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
                              'assets/icons/google.png',
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 26, horizontal: 48),
                child: Row(children: <Widget>[
                  Expanded(
                      child: Divider(
                    color: Colors.black,
                  )),
                  Text(
                    "   Or   ",
                    style: TextStyle(
                        fontFamily: 'Clash Grotesk',
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    selectionColor: Colors.black,
                  ),
                  Expanded(
                      child: Divider(
                    color: Colors.black,
                  )),
                ]),
              ),
              GestureDetector(
                onTap: () {
                  // _handleSignIn();
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
}
