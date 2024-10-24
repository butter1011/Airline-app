import 'package:airline_app/screen/logIn/SignUpName.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(
          255,
          63,
          234,
          156,
        ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignUpUserName();
                        }));
                      },
                      child: Container(
                        width: 99,
                        height: 54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(27),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black, offset: Offset(3, 3))
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/google.png',
                                width: 20,
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 99,
                      height: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(27),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black, offset: Offset(3, 3))
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/apple.png',
                              width: 20,
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 99,
                      height: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(27),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black, offset: Offset(3, 3))
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/Outlook.png',
                              width: 20,
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
              Container(
                width: 327,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black, offset: Offset(3, 3))
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/mail.png',
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Register with email',
                        style: TextStyle(
                            fontFamily: 'Clash Grotesk',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
