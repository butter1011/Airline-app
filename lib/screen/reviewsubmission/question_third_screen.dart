import 'dart:io';
import 'dart:ui';
import 'package:airline_app/controller/review_controller.dart';
import 'package:airline_app/models/review.dart';
import 'package:airline_app/provider/count_like_provider.dart';
import 'package:airline_app/provider/flight_info_provider.dart';
import 'package:airline_app/screen/app_widgets/loading.dart';

import 'package:airline_app/screen/reviewsubmission/question_first_screen.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_button.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_page_button.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class QuestionThirdScreen extends ConsumerStatefulWidget {
  const QuestionThirdScreen({super.key});

  @override
  ConsumerState<QuestionThirdScreen> createState() =>
      _QuestionThirdScreenState();
}

class _QuestionThirdScreenState extends ConsumerState<QuestionThirdScreen> {
  List<File> _image = []; // Initialize as an empty list
  final ReviewController _reviewController = ReviewController();
  final TextEditingController _commentController =
      TextEditingController(); // Step 1: Declare the controller
  String comment = "";
  bool _isLoading = false;

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
    final flightData = ref.watch(flightInputProvider);
    final reviewData = ref.watch(countLikeProvider);
    final from = flightData.from;
    final to = flightData.to;
    final airline = flightData.airline;
    final classTravel = flightData.selectedClassOfTravel;
    final departureArrival = reviewData[0]["subCategory"];
    final comfort = reviewData[1]["subCategory"];
    final cleanliness = reviewData[2]["subCategory"];
    final onboardService = reviewData[3]["subCategory"];
    final foodBeverage = reviewData[4]["subCategory"];
    final entertainmentWifi = reviewData[5]["subCategory"];

    return Stack(
      children: [
        Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: MediaQuery.of(context).size.height * 0.3,
              flexibleSpace: BuildQuestionHeader(
                subTitle: "Share your experience.",
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFeedbackOptions(context),
                    SizedBox(height: 20), // Space before comments section
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(height: 2, color: Colors.black),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
                          text: 'Submit',
                          onPressed: () async {
                            try {
                              setState(() {
                                _isLoading = true;
                              });

                              final review = Review(
                                reviewer:
                                    "673511a26b35199491bc3adf", // Replace with actual reviewer ID
                                from: from,
                                to: to,
                                classTravel: classTravel,
                                airline: airline,
                                departureArrival: departureArrival,
                                comfort: comfort,
                                cleanliness: cleanliness,
                                onboardService: onboardService,
                                foodBeverage: foodBeverage,
                                entertainmentWifi: entertainmentWifi,
                                comment: comment,
                              );
                              print("📞${review.toJson()}");

                              final result =
                                  await _reviewController.saveReview(review);
                              if (result) {
                                print("📞📞📞📞📞");
                                setState(() {
                                  _isLoading = false;
                                });
                                await _buildBottomSheet(context);
                              } else {
                                setState(() {
                                  _isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Failed to submit review')),
                                );
                              }
                            } catch (e) {
                              setState(() {
                                _isLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Error: ${e.toString()}')),
                              );
                            }
                          },
                          icon: Icons.arrow_forward,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
        if (_isLoading)
          Container(
              color: Colors.black.withOpacity(0.5), child: LoadingWidget()),
      ],
    );
  }

  Widget _buildFeedbackOptions(BuildContext context) {
    return Column(
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
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Comments (Optional)", style: AppStyles.textStyle_14_600),
          SizedBox(height: 6),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.22,
            decoration: AppStyles.cardDecoration,
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  comment = value;
                });
                print("🤣$comment");
              },
              controller: _commentController,
              maxLines: null, // Allows unlimited lines
              decoration: InputDecoration(
                hintText: "Some comment here",
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ])
      ],
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
}

Future<void> _buildBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent, // Make background transparent
    isScrollControlled:
        true, // Allow the bottom sheet to expand beyond its content
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: 10, sigmaY: 10), // Adjust sigma values for blur intensity
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(
                0.9), // Slightly transparent white background for the sheet itself
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          height: MediaQuery.of(context).size.height * 0.37,
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 27, bottom: 16, left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text("Your Score is 9",
                          style: AppStyles.textStyle_32_600),
                    ),
                    SizedBox(height: 21),
                    Text(
                      "You've earned 100 points",
                      style: AppStyles.textStyle_24_600
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Your feedback helps make every journey better!",
                      style: AppStyles.textStyle_14_400,
                    ),
                    SizedBox(height: 18),
                    Row(
                      children: [
                        _ReviewScoreIcon(
                            iconUrl: 'assets/icons/review_cup.png'),
                        SizedBox(width: 16),
                        _ReviewScoreIcon(
                            iconUrl: 'assets/icons/review_notification.png'),
                      ],
                    )
                  ],
                ),
              ),
              Divider(thickness: 2, color: Colors.black),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: NavButton(
                    text: "Review airport",
                    onPressed: () {},
                    color: Colors.white),
              )
            ],
          ),
        ),
      );
    },
  );
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
