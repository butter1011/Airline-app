import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyles.mainButtonColor,
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
                        Navigator.pushNamed(context, AppRoutes.loginscreen);
                      },
                      child: Container(
                        width: 99,
                        height: 54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(27),
                          color: Colors.white,
                          border: Border.all(
                              width: 2, color: AppStyles.littleBlackColor),
                          boxShadow: [
                            BoxShadow(
                                color: AppStyles.littleBlackColor,
                                offset: Offset(2, 2))
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.loginscreen);
                      },
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
                        clipBehavior:
                            Clip.hardEdge, // Ensures no extra space is added
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/apple.png',
                                width: 20,
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.loginscreen);
                      },
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
                              offset: const Offset(
                                  2, 2), // Set offset to (0, 0) for no gap
                            ),
                          ],
                        ),
                        clipBehavior:
                            Clip.hardEdge, // Ensures no extra space is added
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/Outlook.png',
                                width: 20,
                                height: 20,
                              ),
                            ],
                          ),
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
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.signupscreen);
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
                          color: AppStyles.littleBlackColor,
                          offset: const Offset(3, 3))
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
                          style: TextStyle(
                              fontFamily: 'Clash Grotesk',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}