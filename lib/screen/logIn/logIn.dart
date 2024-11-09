import 'package:airline_app/screen/logIn/skip_screen.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ValueNotifier userCredential = ValueNotifier('');
  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      // ignore: avoid_print
      print('exception->$e');
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
                onTap: () async {
                  userCredential.value = await signInWithGoogle();
                  if (userCredential.value != null) {
                    // ignore: avoid_print, use_build_context_synchronously
                    Navigator.pushNamed(context, AppRoutes.skipscreen);
                    print(userCredential.value.user!.email);
                  }
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
