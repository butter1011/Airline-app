import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List bottomButtonList = [_registerAnother(), _anotherButtons()];
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
                  Navigator.pushNamed(context, AppRoutes.skipscreen);
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
              bottomButtonList[selectedIndex]
            ],
          ),
        ));
  }

  Widget _registerAnother() {
    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex++;
        });
      },
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
                color: AppStyles.littleBlackColor, offset: const Offset(3, 3))
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/mail.png',
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Register with email',
                style: AppStyles.textStyle_15_600,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _anotherButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              width: 99,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(27),
                color: Colors.white,
                border: Border.all(
                  width: 2,
                  color: AppStyles.littleBlackColor,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppStyles.littleBlackColor,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge, // Ensures no extra space is added
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/icon_whatsapp.png',
                      width: 25,
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              width: 99,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(27),
                color: Colors.white,
                border: Border.all(
                  width: 2,
                  color: AppStyles.littleBlackColor,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppStyles.littleBlackColor,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge, // Ensures no extra space is added
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/apple.png',
                      width: 25,
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              width: 99,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(27),
                color: Colors.white,
                border: Border.all(
                  width: 2,
                  color: AppStyles.littleBlackColor,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppStyles.littleBlackColor,
                    // Adjust opacity if needed
                    offset:
                        const Offset(2, 2), // Set offset to (0, 0) for no gap
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge, // Ensures no extra space is added
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/Outlook.png',
                      width: 25,
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ); 
  }
}
