import 'package:airline_app/screen/profile/profile_screen.dart';

import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _controller = TextEditingController(
      text: 'Very long goes here pushing it to the second row');
  final TextEditingController _nameController =
      TextEditingController(text: 'Benedict Cumberbatch');
  @override
  void dispose() {
    // Dispose of the controller when the widget is removed from the widget tree
    _controller.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
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
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white, // Background color
                border:
                    Border.all(width: 2, color: Colors.black), // Border color
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(2, 2))
                ],
              ),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),

                  border: InputBorder.none, // Remove the underline
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
                controller: _controller,
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
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

    Overlay.of(context)?.insert(overlayEntry);

    // Remove the overlay after some time
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}

class FavoriteAirlineDropdown extends StatefulWidget {
  @override
  _FavoriteAirlineDropdownState createState() =>
      _FavoriteAirlineDropdownState();
}

class _FavoriteAirlineDropdownState extends State<FavoriteAirlineDropdown> {
  String? _selectedItem; // Variable to hold the selected item
  final List<String> _favoriteAirlineItems = [
    'British Airways',
    'Japan Airways',
    'Dubai Airways',
  ];

  @override
  void initState() {
    super.initState();
    _selectedItem = _favoriteAirlineItems[0]; // Set default selected item
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(width: 2)),
        // Main container for the dropdown
        // Set width as needed
        padding: EdgeInsets.symmetric(horizontal: 10),

        child: DropdownButtonHideUnderline(
          // Hides the default underline
          child: DropdownButton<String>(
            value: _selectedItem,

            isExpanded: true, // Make dropdown fill available space
            icon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.expand_more,
                color: Colors.grey.shade600,
              ),
            ),
            // Style for the button when collapsed

            style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500),
            // Customize the dropdown menu appearance
            menuMaxHeight: 600, // Maximum height of the dropdown menu
            elevation: 8, // Shadow depth of the dropdown menu
            // Style for the dropdown menu
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(8),
            onChanged: (String? newValue) {
              setState(() {
                _selectedItem = newValue;
              });
            },
            // Generate items for the dropdown
            items: _favoriteAirlineItems
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    // Hover effect (only visible on web)
                    color: Colors.transparent,
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
      ),
    );
  }
}
