import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:airline_app/provider/airline_airport_review_provider.dart';
import 'package:airline_app/screen/app_widgets/keyboard_dismiss_widget.dart';
import 'package:airline_app/screen/app_widgets/loading.dart';
import 'package:airline_app/screen/profile/edit_custom_dropdown_button.dart';
import 'package:airline_app/utils/global_variable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:airline_app/controller/get_airline_controller.dart';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:airline_app/utils/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:airline_app/screen/app_widgets/aws_upload_service.dart';
import 'package:airline_app/utils/global_variable.dart' as aws_credentials;

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  List<dynamic> airlineData = [];
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
      });
      isLoading = false;
    });
  }

  Future<String> _uploadImages(XFile? image) async {
    if (image == null) return '';
    final _awsUploadService = AwsUploadService(
      accessKeyId: aws_credentials.ACCESS_KEY_ID,
      secretAccessKey: aws_credentials.SECRET_ACCESS_KEY,
      region: aws_credentials.REGION,
      bucketName: aws_credentials.BUCKET_NAME,
    );


    try {
      final uploadedUrl =
          await _awsUploadService.uploadFile(File(image.path), 'avatar');
      return uploadedUrl;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
      return '';
    }
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
        KeyboardDismissWidget(
          child: Scaffold(
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
                        borderRadius: BorderRadius.circular(
                            20), // Adjusted for new height
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
                          textAlignVertical: TextAlignVertical
                              .center, // Centers text vertically
                          style: AppStyles
                              .textStyle_15_500, // Adjust font size as needed
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
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
                          color: Colors.white,
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
      String? uploadedProfilePhoto;
      if (_selectedImage != null) {
        uploadedProfilePhoto = await _uploadImages(_selectedImage);
      }

      print("uploadedProfilePhoto: $uploadedProfilePhoto");

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
          'profilePhoto': uploadedProfilePhoto ?? null,
        }),
      );

      if (userInformationResponse.statusCode == 200) {
        final responseData = jsonDecode(userInformationResponse.body);

        ref.read(userDataProvider.notifier).setUserData(responseData);

// Or using a ref (if using Riverpod)
        ref.read(reviewsAirlineProvider.notifier).setReviewUserProfileImageData(
            userData?['userData']['_id'],
            userData?['userData']['profilePhoto']);

        final prefs = await SharedPreferences.getInstance();

        await prefs.setString('userData', json.encode(responseData));
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
