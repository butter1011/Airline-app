import 'dart:io';
import 'package:airline_app/screen/app_widgets/aws_upload_service.dart';
import 'package:airline_app/controller/boarding_pass_controller.dart';
import 'package:airline_app/controller/get_review_airline_controller.dart';
import 'package:airline_app/controller/get_review_airport_controller.dart';
import 'package:airline_app/models/airline_review_model.dart';
import 'package:airline_app/models/airport_review_model.dart';
import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/boarding_passes_provider.dart';
import 'package:airline_app/provider/review_feedback_provider_for_airline.dart';
import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/provider/review_feedback_provider_for_airport.dart';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/provider/airline_airport_review_provider.dart';
import 'package:airline_app/screen/app_widgets/keyboard_dismiss_widget.dart';
import 'package:airline_app/screen/app_widgets/loading.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/build_question_header_for_submit.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_page_button.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:airline_app/provider/score_provider.dart';
import 'package:airline_app/utils/global_variable.dart' as aws_credentials;

class SubmitScreen extends ConsumerStatefulWidget {
  const SubmitScreen({super.key});

  @override
  ConsumerState<SubmitScreen> createState() => _SubmitScreenState();
}

class _SubmitScreenState extends ConsumerState<SubmitScreen> {
  String commentOfAirline = "";
  String commentOfAirport = "";
  bool isSuccess = false;

  final TextEditingController _commentOfAirlineController =
      TextEditingController();

  final TextEditingController _commentOfAirportController =
      TextEditingController();

  final List<File> _imageOfAirline = [];
  final List<File> _imageOfAirport = [];
  bool _isLoading = false;
  bool _isPickingImage = false;
  final _reviewAirlineController = GetReviewAirlineController();
  final _reviewAirportController = GetReviewAirportController();

  @override
  void dispose() {
    _commentOfAirlineController.dispose();
    _commentOfAirportController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmission({
    required BuildContext context,
    required Map<String, dynamic>? userData,
    required String from,
    required String to,
    required String classTravel,
    required String airline,
    required Map<String, dynamic> departureArrival,
    required Map<String, dynamic> comfort,
    required Map<String, dynamic> cleanliness,
    required Map<String, dynamic> onboardService,
    required Map<String, dynamic> foodBeverageForAirline,
    required Map<String, dynamic> entertainmentWifi,
    required Map<String, dynamic> accessibility,
    required Map<String, dynamic> waitTimes,
    required Map<String, dynamic> helpfulness,
    required Map<String, dynamic> ambienceComfort,
    required Map<String, dynamic> foodBeverageForAirport,
    required Map<String, dynamic> amenities,
    required String commentOfAirline,
    required String commentOfAirport,
    required List<File> imageOfAirline,
    required List<File> imageOfAirport,
    required int? index,
    required BoardingPassController boardingPassController,
  }) async {
    setState(() => _isLoading = true);

    try {
      final reviewForAirline = AirlineReviewModel(
        reviewer: userData!['userData']['_id'],
        from: from,
        to: to,
        classTravel: classTravel,
        airline: airline,
        departureArrival: departureArrival,
        comfort: comfort,
        cleanliness: cleanliness,
        onboardService: onboardService,
        foodBeverage: foodBeverageForAirline,
        entertainmentWifi: entertainmentWifi,
        comment: commentOfAirline,
        imageUrls: [],
      );

      final reviewForAirport = AirportReviewModel(
        reviewer: userData['userData']['_id'],
        airline: airline,
        airport: from,
        classTravel: classTravel,
        accessibility: accessibility,
        waitTimes: waitTimes,
        helpfulness: helpfulness,
        ambienceComfort: ambienceComfort,
        foodBeverage: foodBeverageForAirport,
        amenities: amenities,
        comment: commentOfAirport,
        imageUrls: [],
      );

      var imageAirlineUrls = await _uploadImages(imageOfAirline);
      var imageAirportUrls = await _uploadImages(imageOfAirport);

      reviewForAirline.imageUrls = imageAirlineUrls.values.toList();
      reviewForAirport.imageUrls = imageAirportUrls.values.toList();

      var resultOfAirline =
          await _reviewAirlineController.saveAirlineReview(reviewForAirline);
      var resultOfAirport =
          await _reviewAirportController.saveAirportReview(reviewForAirport);

      if (resultOfAirline['success'] && resultOfAirport['success']) {
        final updatedUserData = await _reviewAirlineController
            .increaseUserPoints(userData['userData']['_id'], 500);
        ref
            .read(scoreProvider.notifier)
            .updateAirlineScore(resultOfAirline['data']['data']['score']);
        ref
            .read(scoreProvider.notifier)
            .updateAirportScore(resultOfAirport['data']['data']['score']);
        ref
            .read(userDataProvider.notifier)
            .setUserData(updatedUserData["data"]);
        await _handleSuccessfulSubmission(
          context: context,
          resultOfAirline: resultOfAirline,
          resultOfAirport: resultOfAirport,
          index: index,
          boardingPassController: boardingPassController,
        );
      } else {
        _handleFailedSubmission(context);
      }
    } catch (e) {
      _handleSubmissionError(context, e);
    }
  }

  Future<Map<String, dynamic>> _uploadImages(image) async {
    final _awsUploadService = AwsUploadService(
      accessKeyId: aws_credentials.ACCESS_KEY_ID,
      secretAccessKey: aws_credentials.SECRET_ACCESS_KEY,
      region: aws_credentials.REGION,
      bucketName: aws_credentials.BUCKET_NAME,
    );

    try {
      Map<String, dynamic> uploadedUrls = {};
      for (var file in image) {
        final uploadedUrl = await _awsUploadService.uploadFile(file, 'reviews');
        uploadedUrls[file.path] = uploadedUrl;
      }
      return uploadedUrls;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
      return {};
    }
  }

  Future<void> _pickMedia(List image) async {
    if (_isPickingImage) return;

    setState(() {
      _isPickingImage = true;
    });

    try {
      final picker = ImagePicker();

      // Show dialog to choose media type
      final mediaType = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Choose Media Type'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Image'),
                  onTap: () => Navigator.pop(context, 'image'),
                ),
                ListTile(
                  leading: Icon(Icons.video_library),
                  title: Text('Video'),
                  onTap: () => Navigator.pop(context, 'video'),
                ),
              ],
            ),
          );
        },
      );

      if (mediaType == null) return;

      final XFile? pickedFile;
      if (mediaType == 'image') {
        pickedFile = await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
        );
      } else {
        pickedFile = await picker.pickVideo(
          source: ImageSource.gallery,
          maxDuration:
              const Duration(minutes: 1), // Limit video duration to 1 minute
        );
      }

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        // Check file size (limit to 10MB for images, 50MB for videos)
        final fileSize = await file.length();
        final maxSize =
            mediaType == 'image' ? 10 * 1024 * 1024 : 50 * 1024 * 1024;

        if (fileSize > maxSize) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'File too large. Maximum size is ${maxSize ~/ (1024 * 1024)}MB')),
          );
          return;
        }

        setState(() {
          image.add(file);
        });
      }
    } catch (e) {
      print('Error picking media: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking media: $e')),
      );
    } finally {
      setState(() {
        _isPickingImage = false;
      });
    }
  }

  Future<void> _handleSuccessfulSubmission({
    required BuildContext context,
    required Map<String, dynamic> resultOfAirline,
    required Map<String, dynamic> resultOfAirport,
    required int? index,
    required BoardingPassController boardingPassController,
  }) async {
    ref
        .read(reviewsAirlineAirportProvider.notifier)
        .addReview(resultOfAirline['data']['data']);
    ref
        .read(reviewsAirlineAirportProvider.notifier)
        .addReview(resultOfAirport['data']['data']);

    if (index != null) {
      final updatedBoardingPass =
          ref.read(boardingPassesProvider.notifier).markFlightAsReviewed(index);

      await boardingPassController.updateBoardingPass(updatedBoardingPass);
    }

    ref.read(aviationInfoProvider.notifier).resetState();
    ref.read(reviewFeedBackProviderForAirline.notifier).resetState();

    setState(() => _isLoading = false);

    if (!mounted) return;

    Navigator.pushNamed(context, AppRoutes.completereviews);
  }

  void _handleFailedSubmission(BuildContext context) {
    setState(() => _isLoading = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to submit review')),
    );
  }

  void _handleSubmissionError(BuildContext context, Object error) {
    setState(() => _isLoading = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${error.toString()}')),
    );
  }

  Widget _buildFeedbackOptions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Share your experience with other users (Optional)',
            style: AppStyles.textStyle_14_600),
        const SizedBox(height: 19),
        _buildMediaUploadOptionForAirline(context),
        const SizedBox(height: 22),
        if (_imageOfAirline.isNotEmpty)
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _imageOfAirline
                .map((file) => _buildImageTile(file, _imageOfAirline))
                .toList(),
          ),
        const SizedBox(height: 24),
        _buildMediaUploadOptionForAirport(context),
        const SizedBox(height: 22),
        if (_imageOfAirport.isNotEmpty)
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _imageOfAirport
                .map((file) => _buildImageTile(file, _imageOfAirport))
                .toList(),
          ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Airline Comments (Optional)",
                style: AppStyles.textStyle_14_600),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.08,
              ),
              decoration: AppStyles.cardDecoration,
              child: TextFormField(
                onChanged: (value) => setState(() => commentOfAirline = value),
                controller: _commentOfAirlineController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Some comment here",
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Airport Comments (Optional)",
                style: AppStyles.textStyle_14_600),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.08,
              ),
              decoration: AppStyles.cardDecoration,
              child: TextFormField(
                onChanged: (value) => setState(() => commentOfAirport = value),
                controller: _commentOfAirportController,
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

  Widget _buildImageTile(File file, image) {
    final mimeType = lookupMimeType(file.path);
    final isVideo = mimeType?.startsWith('video/') ?? false;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: AppStyles.buttonDecoration.copyWith(
            borderRadius: BorderRadius.circular(8),
          ),
          child: isVideo
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ],
                )
              : Image.file(
                  file,
                  fit: BoxFit.cover,
                ),
        ),
        Positioned(
          right: -5,
          top: -5,
          child: GestureDetector(
            onTap: () => setState(() => image.remove(file)),
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

  Widget _buildMediaUploadOptionForAirline(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.17,
      decoration: AppStyles.cardDecoration
          .copyWith(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _pickMedia(_imageOfAirline),
            child: Container(
              height: 48,
              width: 48,
              decoration: AppStyles.cardDecoration
                  .copyWith(borderRadius: BorderRadius.circular(16)),
              child: const Icon(Icons.file_upload_outlined),
            ),
          ),
          const SizedBox(height: 12),
          Text("Choose your Airline media for upload",
              style: AppStyles.textStyle_15_600),
        ],
      ),
    );
  }

  Widget _buildMediaUploadOptionForAirport(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.17,
      decoration: AppStyles.cardDecoration
          .copyWith(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _pickMedia(_imageOfAirport),
            child: Container(
              height: 48,
              width: 48,
              decoration: AppStyles.cardDecoration
                  .copyWith(borderRadius: BorderRadius.circular(16)),
              child: const Icon(Icons.file_upload_outlined),
            ),
          ),
          const SizedBox(height: 12),
          Text("Choose your Airport media for upload",
              style: AppStyles.textStyle_15_600),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final boardingPassController = BoardingPassController();
    final flightData = ref.watch(aviationInfoProvider);
    final reviewDataForAirline = ref.watch(reviewFeedBackProviderForAirline);
    final reviewDataForAirport = ref.watch(reviewFeedBackProviderForAirport);
    final userData = ref.watch(userDataProvider);
    final index = flightData.index;
    final from = flightData.from;
    final to = flightData.to;
    final airline = flightData.airline;
    final classTravel = flightData.selectedClassOfTravel;
    final departureArrival = reviewDataForAirline[0]["subCategory"];
    final comfort = reviewDataForAirline[1]["subCategory"];
    final cleanliness = reviewDataForAirline[2]["subCategory"];
    final onboardService = reviewDataForAirline[3]["subCategory"];
    final foodBeverageForAirline = reviewDataForAirline[4]["subCategory"];
    final entertainmentWifi = reviewDataForAirline[5]["subCategory"];
    final accessibility = reviewDataForAirport[0]["subCategory"];
    final waitTimes = reviewDataForAirport[1]["subCategory"];
    final helpfulness = reviewDataForAirport[2]["subCategory"];
    final ambienceComfort = reviewDataForAirport[3]["subCategory"];
    final foodBeverageForAirport = reviewDataForAirport[4]["subCategory"];
    final amenities = reviewDataForAirport[5]["subCategory"];

    final airlineData = ref.watch(aviationInfoProvider);
    final airlineName = ref
        .watch(airlineAirportProvider.notifier)
        .getAirlineName(airlineData.airline);
    final airportName = ref
        .watch(airlineAirportProvider.notifier)
        .getAirportName(airlineData.from);
    final logoImage = ref
        .watch(airlineAirportProvider.notifier)
        .getAirlineLogoImage(airlineData.airline);
    final backgroundImage = ref
        .watch(airlineAirportProvider.notifier)
        .getAirlineBackgroundImage(airlineData.airline);

    return PopScope(
      canPop: false, // Prevents the default pop action
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pushNamed(
              context, AppRoutes.questionsecondscreenforairport);
        }
      },
      child: Stack(
        children: [
          KeyboardDismissWidget(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: MediaQuery.of(context).size.height * 0.3,
                flexibleSpace: BuildQuestionHeaderForSubmit(
                  backgroundImage: backgroundImage,
                  title: "Share your experience",
                  subTitle: "Your feedback helps us improve!",
                  logoImage: logoImage,
                  airlineName: airlineName,
                  airportName: airportName,
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: NavPageButton(
                            text: 'Go back',
                            onPressed: () => Navigator.pushNamed(
                                context, AppRoutes.reviewsubmissionscreen),
                            icon: Icons.arrow_back,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: NavPageButton(
                            text: 'Submit',
                            onPressed: () => _handleSubmission(
                              context: context,
                              userData: userData,
                              from: from,
                              to: to,
                              classTravel: classTravel,
                              airline: airline,
                              departureArrival: departureArrival,
                              comfort: comfort,
                              cleanliness: cleanliness,
                              onboardService: onboardService,
                              foodBeverageForAirline: foodBeverageForAirline,
                              entertainmentWifi: entertainmentWifi,
                              index: index,
                              boardingPassController: boardingPassController,
                              accessibility: accessibility,
                              waitTimes: waitTimes,
                              helpfulness: helpfulness,
                              ambienceComfort: ambienceComfort,
                              foodBeverageForAirport: foodBeverageForAirport,
                              amenities: amenities,
                              commentOfAirline: commentOfAirline,
                              commentOfAirport: commentOfAirport,
                              imageOfAirline: _imageOfAirline,
                              imageOfAirport: _imageOfAirport,
                            ),
                            icon: Icons.arrow_forward,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
                color: Colors.black.withOpacity(0.5),
                child: const LoadingWidget()),
        ],
      ),
    );
  }
}
