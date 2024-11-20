import 'dart:convert';
import 'package:airline_app/controller/get_airline_controller.dart';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:airline_app/utils/app_localizations.dart';
class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  List<dynamic> airlineData = [];
  List<dynamic> airportData = [];
  String? _selectedAirline;
  bool isLoading = true;
  final _getAirlineData = GetAirlineController();

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getAirlineData.getAirlineAirport().then((value) {
      print('🚝${value["data"]}');
      setState(() {
        airlineData = (value["data"]["data"] as List)
            .where((element) => element['isAirline'] == true)
            .toList();
        airportData = (value["data"]["data"] as List)
            .where((element) => element['isAirline'] == false)
            .toList();
      });
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserData = ref.watch(userDataProvider);
    _nameController.text = '${UserData?['userData']['name']}';
    _bioController.text = '${UserData?['userData']['bio']}';
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
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

            SizedBox(
              height: 8,
            ),
            // FavoriteAirlineDropdown(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: EditCustomDropdownButton(
                labelText: "Your Favorite Airline",
                hintText: "${UserData?['userData']['favoriteairlines']}",
                onChanged: (value) => setState(() {
                  _selectedAirline = value;
                }),
                airlineNames: airlineData,
              ),
            )
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
    print('🌹💦💚💎✅');
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

  void _editProfileFunction() async {
    final UserData = ref.watch(userDataProvider);
    print('✔✔✔💎💎💎$_selectedAirline');
    final userInformationData = await http.post(
        Uri.parse('https://airline-backend-c8p8.onrender.com/api/v1/editUser'),
        // Uri.parse('http://10.0.2.2:3000/api/v1/editUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'name': _nameController.text,
          'bio': _bioController.text,
          '_id': UserData?['userData']['_id'],
          'favoriteAirline': _selectedAirline
        }));

    if (userInformationData.statusCode == 200) {
      final responseChangeData = jsonDecode(userInformationData.body);
      print('😜😜😜${responseChangeData}');
      ref.read(userDataProvider.notifier).setUserData(responseChangeData);

      Navigator.pushNamed(context, AppRoutes.profilescreen);
      showCustomSnackbar(context);
      // You might want to store the user ID or navigate to a new screen
    } else {
      // Handle authentication error
      print('Changing the userProfile failed: ${userInformationData.body}');
    }
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(AppLocalizations.of(context).translate('Edit Profile'),
          style: AppStyles.textStyle_16_600.copyWith(color: Colors.black)),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(4.0),
        child: Container(color: Colors.black, height: 4.0),
      ),
    );
  }
}

class EditCustomDropdownButton extends StatefulWidget {
  const EditCustomDropdownButton(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.onChanged,
      required this.airlineNames});

  final String labelText;
  final String hintText;
  final ValueChanged<String> onChanged;
  final List<dynamic> airlineNames;

  @override
  State<EditCustomDropdownButton> createState() =>
      _EditCustomDropdownButtonState();
}

class _EditCustomDropdownButtonState extends State<EditCustomDropdownButton> {
  final TextEditingController textEditingController = TextEditingController();
  String? selectedValue;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText, style: AppStyles.textStyle_14_600),
        const SizedBox(height: 8),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text('Select ${widget.hintText}',
                style: AppStyles.textStyle_15_400
                    .copyWith(color: Color(0xFF38433E))),
            items: widget.airlineNames
                .map((item) => DropdownMenuItem<String>(
                      value: item['name'],
                      child: Text(
                        item['name'],
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              var id = widget.airlineNames
                  .where((element) => element['name'] == value)
                  .first['_id'];
              print("👌  $value  $id");

              setState(() {
                selectedValue = value;
              });
              widget.onChanged(selectedValue ?? ""); // Call the callback
            },
            buttonStyleData: ButtonStyleData(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: AppStyles.cardDecoration,
              height: 48,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              decoration: AppStyles.cardDecoration,
            ),
            menuItemStyleData: const MenuItemStyleData(height: 40),
            dropdownSearchData: DropdownSearchData(
              searchController: textEditingController,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Container(
                height: 50,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    hintText: "Select ${widget.hintText}",
                    hintStyle: AppStyles.textStyle_15_400
                        .copyWith(color: Color(0xFF38433E)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return item.value.toString().contains(searchValue);
              },
            ),
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                textEditingController.clear();
              }
            },
            iconStyleData: IconStyleData(icon: Icon(Icons.expand_more)),
          ),
        )
      ],
    );
  }
}
