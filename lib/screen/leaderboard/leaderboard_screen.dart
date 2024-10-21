import 'package:airline_app/screen/widgets/button.dart';
import 'package:airline_app/screen/widgets/itemButton.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    // Add padding for a border effect
                    decoration: BoxDecoration(
                        color: Colors.white, // Border color
                        // borderRadius: BorderRadius.circular(25),
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.black),
                        boxShadow: const [
                          BoxShadow(color: Colors.black, offset: Offset(2, 2))
                        ]),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/avatar1.png'),
                    ),
                  ),
                  Container(
                    width: 50, // Diameter of the circular avatar
                    height: 50, // Diameter of the circular avatar
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white, // Background color
                      border: Border.all(
                          width: 2, color: Colors.black), // Border color
                      boxShadow: [
                        BoxShadow(color: Colors.black, offset: Offset(2, 2))
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/icons/notification.png', // Local image asset
                        // fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // Diameter of the circular avatar
                    height: 48, // Diameter of the circular avatar
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppStyles.mainButtonColor, // Background color
                      border: Border.all(
                          width: 2, color: Colors.black), // Border color
                      boxShadow: [
                        BoxShadow(color: Colors.black, offset: Offset(2, 2))
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Center(
                        child: Text(
                          "All",
                          style: GoogleFonts.getFont("Schibsted Grotesk",
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                  ),
                  Button(text: "Airports", color: Colors.white),
                  Button(text: "Airline", color: Colors.white),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 50, // Diameter of the circular avatar
                    height: 50, // Diameter of the circular avatar
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white, // Background color
                      border: Border.all(
                          width: 2, color: Colors.black), // Border color
                      boxShadow: [
                        BoxShadow(color: Colors.black, offset: Offset(2, 2))
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/icons/setting.png', // Local image asset
                        // fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Divider(
          thickness: 5,
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                // height: 295,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(width: 2, color: Colors.black),
                  boxShadow: [
                    BoxShadow(color: Colors.black, offset: Offset(2, 2))
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 175,
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(22)),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/Abu_Dhabi_Terminal.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                            top: 18,
                            left: 26,
                            child: Container(
                              // Diameter of the circular avatar
                              height: 24, // Diameter of the circular avatar
                              decoration: BoxDecoration(
                                // shape: BoxShape.circle,
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white, // Background color
                                border: Border.all(
                                    width: 2,
                                    color: Colors.black), // Border color
                              ),

                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text('9/10 from 382 reviews',
                                    style: AppStyles.mainTextStyle
                                        .copyWith(fontSize: 14)),
                              ),
                            )),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Abu Dhabi Airport',
                              style: AppStyles.mainTextStyle.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ItemButton(
                                    text: "Top 1 Airport", color: Colors.black),
                                SizedBox(
                                  width: 8,
                                ),
                                ItemButton(
                                    text: 'Cleanliness', color: Colors.white),
                                SizedBox(
                                  width: 8,
                                ),
                                ItemButton(
                                    text: 'Best Wi-Fi', color: Colors.white)
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            const Row(
                              children: [
                                ItemButton(
                                    text: 'Best Business Class',
                                    color: Colors.white),
                              ],
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
