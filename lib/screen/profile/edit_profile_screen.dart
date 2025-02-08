import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:airline_app/provider/airline_airport_review_provider.dart';
import 'package:airline_app/screen/app_widgets/appbar_widget.dart';
import 'package:airline_app/screen/app_widgets/bottom_button_bar.dart';
import 'package:airline_app/screen/app_widgets/custom_icon_button.dart';
import 'package:airline_app/screen/app_widgets/keyboard_dismiss_widget.dart';
import 'package:airline_app/screen/app_widgets/loading.dart';
import 'package:airline_app/screen/app_widgets/main_button.dart';
import 'package:airline_app/screen/profile/edit_custom_dropdown_button.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/comment_input_field.dart';
import 'package:airline_app/utils/global_variable.dart';
import 'package:image_picker/image_picker.dart';
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
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  List<dynamic> airlineData = [];
  bool isLoading = false;
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String? _selectedAirline;
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
  }

  void reloadProfileImage() {
    setState(() {
      // Clear image cache to force reload
      final imageCache = PaintingBinding.instance.imageCache;
      imageCache.clear();
      imageCache.clearLiveImages();
    });
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
                decoration: AppStyles.cardDecoration.copyWith(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                // padding: EdgeInsets.all(16),
                // color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle_outline),
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
                ),              ),
              Positioned(
                  right: 8,
                  top: 8,
                  child: Icon(Icons.close, size: 32,))
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

  void _editProfileFunction() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    reloadProfileImage();
    final userData = ref.watch(userDataProvider);

    try {
      String uploadedProfilePhoto = userData?['userData']['profilePhoto'] ?? '';
      if (_selectedImage != null) {
        uploadedProfilePhoto = await _uploadImages(_selectedImage) ?? '';
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
          'profilePhoto': uploadedProfilePhoto,
        }),
      );

      if (userInformationResponse.statusCode == 200) {
        final responseData = jsonDecode(userInformationResponse.body);

        ref.read(userDataProvider.notifier).setUserData(responseData);

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

  @override
  Widget build(BuildContext context) {
    final UserData = ref.watch(userDataProvider);
    _nameController.text = '${UserData?['userData']['name']}';
    _bioController.text = '${UserData?['userData']['bio']}';
    return Stack(
      children: [
        KeyboardDismissWidget(
          child: Scaffold(
            appBar: AppbarWidget(
              title: AppLocalizations.of(context).translate('Edit Profile'),
              onBackPressed: () => Navigator.pop(context),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
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
                          decoration: AppStyles.avatarDecoration,
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
                            child: CustomIconButton(
                                onTap: _pickImage, icon: Icons.camera_alt)),
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
                      height: 32,
                    ),
                    CommentInputField(
                        commentController: _nameController,
                        title: "Name & Surname",
                        onChange: (value) {},
                        hintText: "",
                        height: 0.06),
                    SizedBox(
                      height: 22,
                    ),
                    CommentInputField(
                        commentController: _bioController,
                        title: "Bio",
                        onChange: (value) {},
                        hintText: ""),
                    SizedBox(
                      height: 32,
                    ),
                    EditCustomDropdownButton(
                      labelText: "Your Favorite Airline",
                      hintText: "${UserData?['userData']['favoriteairlines']}",
                      onChanged: (value) => setState(() {
                        _selectedAirline = value;
                      }),
                      airlineNames: airlineData,
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomButtonBar(
                child: MainButton(
                    text: AppLocalizations.of(context).translate('Save'),
                    onPressed: () {
                      _editProfileFunction();
                    })),
          ),
        ),
        if (isLoading)
          Container(
              color: Colors.black.withAlpha(127), child: const LoadingWidget()),
      ],
    );
  }
}
