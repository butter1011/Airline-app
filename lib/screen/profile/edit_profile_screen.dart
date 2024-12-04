import 'dart:convert';
import 'dart:async';
import 'dart:ui';
import 'dart:io';
import 'package:airline_app/screen/app_widgets/loading.dart';
import 'package:airline_app/utils/global_variable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:airline_app/controller/get_airline_controller.dart';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool isLoading = false;
  final _getAirlineData = GetAirlineAirportController();
  XFile? _selectedImage;

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

  Future<void> _pickImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image =
          await _picker.pickImage(source: ImageSource.gallery).timeout(
        Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Image picker timed out');
        },
      );

      if (image != null) {
        // Clear existing image cache before setting new image
        final imageCache = ImageCache();
        imageCache.clear();
        imageCache.clearLiveImages();

        setState(() {
          _selectedImage = image;
        });
      }
    } on PlatformException catch (e) {
      if (e.code == 'already_active') {
        // Handle the case where image picker is already active
        print('Image picker is already active');
        return;
      }
      // Handle other platform exceptions
      print('Failed to pick image: ${e.message}');
    } catch (e) {
      // Handle other exceptions
      print('Error picking image: $e');
    }
  }

  void reloadProfileImage() {
    setState(() {
      // Clear image cache to force reload
      final imageCache = PaintingBinding.instance.imageCache;
      imageCache.clear();
      imageCache.clearLiveImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserData = ref.watch(userDataProvider);
    _nameController.text = '${UserData?['userData']['name']}';
    _bioController.text = '${UserData?['userData']['bio']}';
    return Stack(
      children: [
        Scaffold(
          appBar: _buildAppBar(context),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(3, 3),
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundImage: _selectedImage != null
                            ? FileImage(File(_selectedImage!.path))
                            : UserData?['userData']['profilePhoto'] != null
                                ? NetworkImage(
                                    UserData?['userData']['profilePhoto'])
                                : AssetImage("assets/images/avatar_1.png")
                                    as ImageProvider,
                        radius: 48,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(2, 2),
                              blurRadius: 3,
                            )
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18),
                            onTap: _pickImage,
                            child: Icon(
                              Icons.camera_alt,
                              size: 20,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
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
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
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
                        style: AppStyles
                            .textStyle_15_500, // Adjust font size as needed
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          border: InputBorder.none,
                          isCollapsed: true, // Removes the default padding
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Bio",
                        style: AppStyles.textStyle_14_600,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
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
                      style: AppStyles.textStyle_14_500,
                      controller: _bioController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12)),
                      maxLines: null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
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
                ),
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
                        border: Border.all(
                            width: 2, color: AppStyles.littleBlackColor),
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
        ),
        if (isLoading)
          Container(
              color: Colors.black.withOpacity(0.5),
              child: const LoadingWidget()),
      ],
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

  void _editProfileFunction() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    reloadProfileImage();
    final userData = ref.watch(userDataProvider);

    try {
      if (_selectedImage != null) {
        final url = Uri.parse('$apiUrl/api/v1/editUser/avatar');
        final request = http.MultipartRequest('POST', url);

        final file = File(_selectedImage!.path);
        final filename = file.path.split('/').last;

        request.files.add(
          http.MultipartFile(
            'avatar',
            file.readAsBytes().asStream(),
            file.lengthSync(),
            filename: filename,
          ),
        );

        request.fields['userId'] = userData?['userData']['_id'];

        await request.send();
      }

      final userInformationResponse = await http.post(
        Uri.parse('$apiUrl/api/v1/editUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'name': _nameController.text,
          'bio': _bioController.text,
          '_id': userData?['userData']['_id'],
          'favoriteAirline': _selectedAirline,
        }),
      );

      if (userInformationResponse.statusCode == 200) {
        final responseData = jsonDecode(userInformationResponse.body);
        ref.read(userDataProvider.notifier).setUserData(responseData);

        setState(() {
          isLoading = false; // Hide loading indicator
        });

        Navigator.pushNamed(context, AppRoutes.profilescreen);
        showCustomSnackbar(context);
      } else {
        setState(() {
          isLoading = false; // Hide loading indicator on error
        });
        print('Failed to update user profile: ${userInformationResponse.body}');
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Hide loading indicator on error
      });
      print('Error updating profile: $e');
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
            hint: Text('Select your favorite airline',
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
                    hintText: "Select your favorite airline",
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
