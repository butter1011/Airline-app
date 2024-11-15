import 'dart:convert';

import 'package:airline_app/provider/favorite_airline_provider.dart';
import 'package:airline_app/screen/logIn/logIn.dart';
import 'package:airline_app/screen/profile/profile_screen.dart';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserData = ref.watch(userDataProvider);
    _nameController.text = '${UserData?['userData']['name']}';
    _bioController.text = '${UserData?['userData']['bio']}';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.profilescreen);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 24,
          ),
        ),
        title: Text(
          "Edit Profile",
          textAlign: TextAlign.center,
          style: AppStyles.textStyle_16_600,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 4,
              color: AppStyles.littleBlackColor,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: AppStyles.circleDecoration,
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/avatar_1.png"),
                radius: 36,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              "Change Photo",
              style: AppStyles.textStyle_15_600,
            ),
            SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Name & Surname",
                    style: AppStyles.textStyle_14_600,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Container(
                height: 40, // Increased height for better visibility
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(20), // Adjusted for new height
                  color: Colors.white,
                  border: Border.all(width: 2, color: Colors.black),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(2, 2),
                    )
                  ],
                ),
                child: Center(
                  // Added Center widget
                  child: TextField(
                    controller: _nameController,
                    textAlignVertical:
                        TextAlignVertical.center, // Centers text vertically
                    style:
                        TextStyle(fontSize: 16), // Adjust font size as needed
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: InputBorder.none,
                      isCollapsed: true, // Removes the default padding
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Bio",
                    style: AppStyles.textStyle_14_600,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Container(
                height: 122,
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(27),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(2, 2),
                      )
                    ]),
                child: TextField(
                  controller: _bioController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12)),
                  maxLines: null,
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Your Favorite Airline",
                    style: AppStyles.textStyle_14_600,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            FavoriteAirlineDropdown(),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4, // Set the height to match the thickness you want
            color: AppStyles.littleBlackColor, // Use your desired color
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: InkWell(
              onTap: () {
                showCustomSnackbar(context);

                _editProfileFunction();
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.87,
                height: 56,
                decoration: BoxDecoration(
                    color: AppStyles.mainColor,
                    border:
                        Border.all(width: 2, color: AppStyles.littleBlackColor),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                          color: AppStyles.littleBlackColor,
                          offset: Offset(2, 2))
                    ]),
                child: Center(
                  child: Text(
                    "Save Changes",
                    style: AppStyles.textStyle_15_600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void showCustomSnackbar(BuildContext context) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 45, // Position from top
        left: 24,
        right: 24,

        child: Material(
          // elevation: 4.0,
          child: ClipRect(
            child: Stack(children: [
              Container(
                height: 60,
                decoration: AppStyles.buttonDecoration.copyWith(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                // padding: EdgeInsets.all(16),
                // color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/icons/alert.png',
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Successfully saved!',
                        style: AppStyles.textStyle_16_600.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  right: 8,
                  top: 8,
                  child: Image.asset(
                    "assets/icons/closeButton.png",
                    width: 32,
                    height: 32,
                  ))
            ]),
          ),
        ),
      ),
    );

    // Overlay.of(context)?.insert(overlayEntry);

    // Remove the overlay after some time
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  void _editProfileFunction() async {
    final UserData = ref.watch(userDataProvider);

    final userInformationData = await http.post(
        Uri.parse('https://airline-backend-pi.vercel.app/api/v1/editUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'name': _nameController.text,
          'bio': _bioController.text,
          '_id': UserData?['userData']['_id']
        }));

    if (userInformationData.statusCode == 200) {
      final responseChangeData = jsonDecode(userInformationData.body);
      print('😜😜😜${responseChangeData}');
      ref.read(userDataProvider.notifier).setUserData(responseChangeData);

      Navigator.pushNamed(context, AppRoutes.profilescreen);

      // You might want to store the user ID or navigate to a new screen
    } else {
      // Handle authentication error
      print('Changing the userProfile failed: ${userInformationData.body}');
    }
  }
}

class FavoriteAirlineDropdown extends StatefulWidget {
  @override
  _FavoriteAirlineDropdownState createState() =>
      _FavoriteAirlineDropdownState();
}

class _FavoriteAirlineDropdownState extends State<FavoriteAirlineDropdown> {
  String? _selectedItem;
  bool _isExpanded = false; // Variable to hold the selected item
  final List<String> _favoriteAirlineItems = [
    'American Airlines',
    'Delta Air Lines',
    'United Airlines',
    'Southwest Airlines',
  ];

  @override
  void initState() {
    super.initState();
    _selectedItem = _favoriteAirlineItems[0]; // Set default selected item
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(width: 2),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedItem ?? '',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Container(
              margin: EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView(
                shrinkWrap: true,
                children: _favoriteAirlineItems.map((String value) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedItem = value;
                        _isExpanded = false;
                      });
                    },
                    child: Container(
                      height: 40,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: _selectedItem == value
                            ? Colors.grey.withOpacity(0.2)
                            : Colors.transparent,
                      ),
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
