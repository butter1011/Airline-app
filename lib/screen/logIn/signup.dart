import 'package:airline_app/screen/logIn/logIn.dart';
import 'package:airline_app/screen/logIn/widget/button.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpUserName extends StatefulWidget {
  const SignUpUserName({super.key});

  @override
  State<SignUpUserName> createState() => _SignUpUserNameState();
}

class _SignUpUserNameState extends State<SignUpUserName> {
  // Option 2
  String? selectedGender;
  String? selectedCountry;
  final List<String> Country = [
    'United States',
    'United Kingdom',
    'Japan',
    'Australia',
  ];
  final List<String> Gender = ['Female', 'Male'];

  // _getCategories() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 66,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Login();
                    }));
                  },
                  child: Image.asset(
                    'assets/images/left.png', // Path to your arrow icon
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'Account Creation',
                    style: AppStyles.textStyle_24_600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            color: Colors.black,
            thickness: 5,
          ),
          const Padding(
            padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 25),
            child: Text(
              'Please respond to a couple of questions',
              style: TextStyle(
                fontFamily: 'Clash Grotesk',
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  'Name',
                  style: TextStyle(
                      fontFamily: 'Clash Grotesk',
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(27),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(2, 2),
                    )
                  ]),
              child: TextField(
                  decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Padding(padding: const EdgeInsets.all(2)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
                labelText: 'Name&Sirname',
                labelStyle: GoogleFonts.getFont('Schibsted Grotesk',
                    fontSize: 20, letterSpacing: 0.3),
              )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                child: Text(
                  'What is your gender?',
                  style: TextStyle(
                      fontFamily: 'Clash Grotesk',
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              // vertical: 20,
            ),
            child: Container(
              width: 400,
              height: 47,
              decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(27),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(2, 2),
                    )
                  ]),
              child: Center(
                child: SizedBox(
                  width: 320,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text('Gender'),
                      // Hint text when no item is selected
                      value: selectedGender, // Current selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGender =
                              newValue; // Update the selected value
                        });
                      },
                      items:
                          Gender.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                      isExpanded: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                child: Text(
                  'Your country of living?',
                  style: TextStyle(
                      fontFamily: 'Clash Grotesk',
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              // vertical: 20,
            ),
            child: Container(
              width: 400,
              height: 47,
              decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(27),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(2, 2),
                    )
                  ]),
              child: Center(
                child: SizedBox(
                  width: 320,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text('Country'),
                      // Hint text when no item is selected
                      value: selectedCountry, // Current selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCountry =
                              newValue; // Update the selected value
                        });
                      },
                      items:
                          Country.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                      isExpanded: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Text(
                  'Pick your preferred class of travel:',
                  style: TextStyle(
                      fontFamily: 'Clash Grotesk',
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            child: Row(
              children: [
                Button(
                    mywidth: 90,
                    myheight: 40,
                    myColor: Color.fromARGB(
                      255,
                      63,
                      234,
                      156,
                    ),
                    travelname: 'Business'),
                SizedBox(
                  width: 8,
                ),
                Button(
                    mywidth: 156,
                    myheight: 40,
                    myColor: Colors.white,
                    travelname: 'Prenium economy'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Align(
              alignment: Alignment.topLeft,
              child: Button(
                  mywidth: 93,
                  myheight: 40,
                  myColor: Colors.white,
                  travelname: 'Economy'),
            ),
          ),
          SizedBox(
            height: 91,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Divider(
              color: Colors.black,
              thickness: 3,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
            },
            child: Container(
              width: 327,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(27),
                color: AppStyles.mainButtonColor,
                border: Border.all(width: 2, color: AppStyles.littleBlackColor),
                boxShadow: [
                  BoxShadow(color: Colors.black, offset: Offset(3, 3))
                ],
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Finish',
                      style: TextStyle(
                          fontFamily: 'Clash Grotesk',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'assets/icons/right.png',
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
    );
  }
}
