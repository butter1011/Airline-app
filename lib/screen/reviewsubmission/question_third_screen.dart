import 'dart:io';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_button.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_page_button.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class QuestionThirdScreen extends StatefulWidget {
  const QuestionThirdScreen({super.key});

  @override
  State<QuestionThirdScreen> createState() => _QuestionThirdScreenState();
}

class _QuestionThirdScreenState extends State<QuestionThirdScreen> {
  // dynamic _image;

  // pickImage() async {
  //   FilePickerResult? result = await FilePicker.platform
  //       .pickFiles(type: FileType.image, allowMultiple: false);
  //   if (result != null) {
  //     setState(() {
  //       _image = result.files.first.bytes;
  //     });
  //   }
  // }
  List<File> _image = []; // Initialize as an empty list

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image.add(File(pickedFile.path)); // Add the new image to the list
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.3,
        flexibleSpace: _buildHeader(context),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildFeedbackOptions(context),
            _buildNavigationButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackOptions(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Share your experience with other users (Optional)',
                style: AppStyles.textStyle_14_600),
            SizedBox(height: 19),
            _buildMediaUploadOption(context),
            SizedBox(height: 24),
            if (_image.isNotEmpty) // Check if the list is not empty
              Wrap(
                spacing: 8.0, // Space between images
                runSpacing: 8.0,
                children: _image
                    .map(
                      (file) => Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: AppStyles.buttonDecoration.copyWith(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: FileImage(file),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: -5,
                            top: -5,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _image.remove(file); // Remove image on tap
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.cancel_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            SizedBox(height: 20),
            _buildCommentsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Japan.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          color:
              Color(0xff181818).withOpacity(0.75), // Black overlay with opacity
        ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.052),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeaderTitle(),
              SizedBox(height: 32),
              _buildHeaderSubtitle(),
              SizedBox(height: 20),
              _buildFlightDetails(),
              Spacer(), // Pushes the following container to the bottom
              _buildBottomContainer(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/icons/vector_japan.png"),
        SizedBox(width: 8),
        Column(
          children: [
            Text('JAPAN', style: AppStyles.oswaldTextStyle),
            Text('AIRLINES', style: AppStyles.oswaldTextStyle),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderSubtitle() {
    return Column(
      children: [
        Text("Share your experience",
            style:
                AppStyles.textStyle_18_600.copyWith(color: Color(0xffF9F9F9))),
        Text('Your feedback helps us improve!',
            style:
                AppStyles.textStyle_15_600.copyWith(color: Color(0xffC1C7C4))),
      ],
    );
  }

  Widget _buildFlightDetails() {
    return Column(
      children: [
        Text('Japan Airways, 18/10/24, Premium Economy',
            style: AppStyles.textStyle_15_600.copyWith(color: Colors.white)),
        SizedBox(height: 4),
        Text('Tokyo > Bucharest',
            style: AppStyles.textStyle_15_600.copyWith(color: Colors.white)),
      ],
    );
  }

  Widget _buildBottomContainer() {
    return Container(
      height: 24,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(24), topLeft: Radius.circular(24)),
      ),
    );
  }

  Widget _buildMediaUploadOption(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.17,
      decoration: AppStyles.cardDecoration
          .copyWith(borderRadius: BorderRadius.circular(16)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        GestureDetector(
          onTap: () {
            _pickImage();
          },
          child: Container(
              height: 48,
              width: 48,
              decoration: AppStyles.cardDecoration
                  .copyWith(borderRadius: BorderRadius.circular(16)),
              child: Icon(Icons.file_upload_outlined)),
        ),
        SizedBox(height: 12),
        Text("Choose your media for upload", style: AppStyles.textStyle_15_600),
      ]),
    );
  }

  Widget _buildCommentsSection(context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Comments (Optional)", style: AppStyles.textStyle_14_600),
          SizedBox(height: 6),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: AppStyles.cardDecoration,
              child: TextFormField(
                maxLines: null, // Allows unlimited lines
                decoration: InputDecoration(
                  hintText: "Some comment here",
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Column(
      children: [
        Divider(
            color: Colors.black,
            thickness: 2), // Using Divider for better semantics
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: NavPageButton(
                  text: 'Go back',
                  onPressed: () {
                    Navigator.pop(context); // Navigate back
                  },
                  icon: Icons.arrow_back,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: NavPageButton(
                  text: 'Next',
                  onPressed: () async {
                    Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
                    // Show the bottom sheet before navigating
                    await _buildBottomSheet(context);
                    // Then navigate to the next screen
                  },
                  icon: Icons.arrow_forward,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _buildBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.37,
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 27, bottom: 16, left: 24, right: 24),
                // Adjust height based on items
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text("Your Score is 9",
                            style: AppStyles.textStyle_32_600)),
                    SizedBox(
                      height: 21,
                    ),
                    Text(
                      "You’ve earned 100 points",
                      style: AppStyles.textStyle_24_600
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Your feedback helps make every journey better!",
                      style: AppStyles.textStyle_14_400,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        _ReviewScoreIcon(
                            iconUrl: 'assets/icons/review_cup.png'),
                        SizedBox(
                          width: 16,
                        ),
                        _ReviewScoreIcon(
                            iconUrl: 'assets/icons/review_notification.png'),
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                color: Colors.black,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: NavButton(
                  text: "Review airport",
                  onPressed: () {},
                  color: Colors.white,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _ReviewScoreIcon extends StatefulWidget {
  const _ReviewScoreIcon({required this.iconUrl});
  final String iconUrl;

  @override
  State<_ReviewScoreIcon> createState() => __ReviewScoreIconState();
}

class __ReviewScoreIconState extends State<_ReviewScoreIcon> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
        height: 40,
        decoration: AppStyles.circleDecoration
            .copyWith(color: _isSelected ? AppStyles.mainColor : Colors.white),
        child: Image.asset(widget.iconUrl),
      ),
    );
  }
}
