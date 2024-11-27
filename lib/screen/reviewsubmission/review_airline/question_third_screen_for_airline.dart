import 'dart:io';
import 'dart:ui';
import 'package:airline_app/controller/airline_review_controller.dart';
import 'package:airline_app/controller/boarding_pass_controller.dart';
import 'package:airline_app/models/airline_review_model.dart';
import 'package:airline_app/provider/boarding_passes_provider.dart';
import 'package:airline_app/provider/review_feedback_provider_for_airline.dart';
import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/screen/app_widgets/loading.dart';
import 'package:airline_app/screen/reviewsubmission/review_airline/question_first_screen_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_page_button.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/review_success_bottom_sheet.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class QuestionThirdScreenForAirline extends ConsumerStatefulWidget {
  const QuestionThirdScreenForAirline({super.key});

  @override
  ConsumerState<QuestionThirdScreenForAirline> createState() =>
      _QuestionThirdScreenForAirlineState();
}

class _QuestionThirdScreenForAirlineState
    extends ConsumerState<QuestionThirdScreenForAirline> {
  final List<File> _image = [];
  final AirlineReviewController _reviewController = AirlineReviewController();
  final TextEditingController _commentController = TextEditingController();

  String comment = "";
  bool _isLoading = false;
  bool isSuccess = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (pickedFile != null) {
      setState(() {
        _image.add(File(pickedFile.path));
      });
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boardingPassController = BoardingPassController();
    final flightData = ref.watch(aviationInfoProvider);
    final reviewData = ref.watch(reviewFeedBackProviderForAirline);
    final index = flightData.index;
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
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFeedbackOptions(context),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(height: 2, color: Colors.black),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: NavPageButton(
                          text: 'Go back',
                          onPressed: () => Navigator.pop(context),
                          icon: Icons.arrow_back,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: NavPageButton(
                          text: 'Submit',
                          onPressed: () async {
                            setState(() => _isLoading = true);
                            try {
                              final review = AirlineReviewModel(
                                reviewer: "673ce4b17b423be4af57fb8a",
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

                              final result = await _reviewController.saveReview(review);
                              if (result) {
                                if (index != null) {
                                  final updatedBoardingPass = ref
                                      .read(boardingPassesProvider.notifier)
                                      .markFlightAsReviewed(index);

                                  await boardingPassController
                                      .updateBoardingPass(updatedBoardingPass);
                                }

                                ref.read(aviationInfoProvider.notifier).resetState();
                                ref.read(reviewFeedBackProviderForAirline.notifier).resetState();
                                
                                setState(() => _isLoading = false);
                                
                                if (!mounted) return;
                                // ignore: use_build_context_synchronously
                                Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
                                await showReviewSuccessBottomSheet(
                                  // ignore: use_build_context_synchronously
                                  context, 
                                  () => setState(() => isSuccess = true),
                                  "Review airport"
                                );
                              } else {
                                setState(() => _isLoading = false);
                                if (!mounted) return;
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Failed to submit review')),
                                );
                              }
                            } catch (e) {
                              setState(() => _isLoading = false);
                              if (!mounted) return;
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: ${e.toString()}')),
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
              color: Colors.black.withOpacity(0.5), child: const LoadingWidget()),
      ],
    );
  }

  Widget _buildFeedbackOptions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Share your experience with other users (Optional)',
            style: AppStyles.textStyle_14_600),
        const SizedBox(height: 19),
        _buildMediaUploadOption(context),
        const SizedBox(height: 24),
        if (_image.isNotEmpty)
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _image.map((file) => _buildImageTile(file)).toList(),
          ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Comments (Optional)", style: AppStyles.textStyle_14_600),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.22,
              decoration: AppStyles.cardDecoration,
              child: TextFormField(
                onChanged: (value) => setState(() => comment = value),
                controller: _commentController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Some comment here",
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildImageTile(File file) {
    return Stack(
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
            onTap: () => setState(() => _image.remove(file)),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: const Center(
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
    );
  }

  Widget _buildMediaUploadOption(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.17,
      decoration: AppStyles.cardDecoration
          .copyWith(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              height: 48,
              width: 48,
              decoration: AppStyles.cardDecoration
                  .copyWith(borderRadius: BorderRadius.circular(16)),
              child: const Icon(Icons.file_upload_outlined),
            ),
          ),
          const SizedBox(height: 12),
          Text("Choose your media for upload", style: AppStyles.textStyle_15_600),
        ],
      ),
    );
  }
}