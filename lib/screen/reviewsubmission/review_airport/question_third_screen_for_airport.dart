import 'dart:io';
import 'dart:ui';
import 'package:airline_app/controller/airport_review_controller.dart';
import 'package:airline_app/controller/boarding_pass_controller.dart';
import 'package:airline_app/models/airport_review_model.dart';
import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/airline_airport_review_provider.dart';
import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/provider/boarding_passes_provider.dart';
import 'package:airline_app/provider/review_feedback_provider_for_airport.dart';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/screen/app_widgets/loading.dart';
import 'package:airline_app/screen/reviewsubmission/review_airport/question_first_screen_for_airport.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_page_button.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/review_success_bottom_sheet.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:airline_app/utils/global_variable.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class QuestionThirdScreenForAirport extends ConsumerStatefulWidget {
  const QuestionThirdScreenForAirport({super.key});

  @override
  ConsumerState<QuestionThirdScreenForAirport> createState() =>
      _QuestionThirdScreenForAirportState();
}

class _QuestionThirdScreenForAirportState
    extends ConsumerState<QuestionThirdScreenForAirport> {
  final List<File> _image = [];
  final AirportReviewController _reviewController = AirportReviewController();
  final TextEditingController _commentController = TextEditingController();
  final BoardingPassController _boardingPassController =
      BoardingPassController();
  bool _isPickingImage = false;

  String comment = "";
  bool _isLoading = false;
  bool isSuccess = false;

  Future<void> _uploadImages(String reviewId) async {
    final url = Uri.parse('$apiUrl/api/v1/airport-review/upload-media');

    for (var media in _image) {
      try {
        final request = http.MultipartRequest('POST', url);
        final filename = media.path.split('/').last;
        final mimeType = lookupMimeType(media.path);

        // Check if file is video or image
        final isVideo = mimeType?.startsWith('video/') ?? false;

        request.files.add(
          await http.MultipartFile.fromPath(
            'files',
            media.path,
            filename: filename,
            contentType: MediaType.parse(
                mimeType ?? (isVideo ? 'video/mp4' : 'image/jpeg')),
          ),
        );

        request.fields['id'] = reviewId;
        request.fields['type'] = isVideo ? 'video' : 'image';

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode != 200) {
          throw Exception('Failed to upload media: ${response.body}');
        }

        print(
            'Successfully uploaded ${isVideo ? 'video' : 'image'}: $filename');
      } catch (e) {
        print('Error uploading media: $e');
        continue;
      }
    }
  }

  Future<void> _pickImage() async {
    if (_isPickingImage) return;

    setState(() {
      _isPickingImage = true;
    });

    try {
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
    } finally {
      setState(() {
        _isPickingImage = false;
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
    final airportData = ref.watch(aviationInfoProvider);
    final reviewData = ref.watch(reviewFeedBackProviderForAirport);
    final index = airportData.index;
    final isDeparture = airportData.isDeparture;
    final airport = airportData.airport;
    final airline = airportData.airline;
    final classTravel = airportData.selectedClassOfTravel;
    final accessibility = reviewData[0]["subCategory"];
    final waitTimes = reviewData[1]["subCategory"];
    final helpfulness = reviewData[2]["subCategory"];
    final ambienceComfort = reviewData[3]["subCategory"];
    final foodBeverage = reviewData[4]["subCategory"];
    final amenities = reviewData[5]["subCategory"];

    final airlinData = ref.watch(aviationInfoProvider);

    final airportname = ref
        .watch(airlineAirportProvider.notifier)
        .getAirportName(airlinData.airport);
    final logoImage = ref
        .watch(airlineAirportProvider.notifier)
        .getAirportLogoImage(airlinData.airport);
    final backgroundImage = ref
        .watch(airlineAirportProvider.notifier)
        .getAirportBackgroundImage(airlinData.airport);

    final selectedClassOfTravel = airlinData.selectedClassOfTravel;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, AppRoutes.questionsecondscreenforairport);
        return false;
      },
      child: Stack(
        children: [
          Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: MediaQuery.of(context).size.height * 0.3,
                flexibleSpace: BuildQuestionHeader(
                  airportName: airportname,
                  subTitle: "Share your experience.",
                  logoImage: logoImage,
                  backgroundImage: backgroundImage,
                  selecetedOfCalssLevel: selectedClassOfTravel,
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
                                final review = AirportReviewModel(
                                  reviewer:
                                      ref.watch(userDataProvider)?['userData']
                                          ['_id'],
                                  airline: airline,
                                  airport: airport,
                                  classTravel: classTravel,
                                  accessibility: accessibility,
                                  waitTimes: waitTimes,
                                  helpfulness: helpfulness,
                                  ambienceComfort: ambienceComfort,
                                  foodBeverage: foodBeverage,
                                  amenities: amenities,
                                  comment: comment,
                                );

                                final result = await _reviewController
                                    .saveAirportReview(review);

                                if (_image.isNotEmpty &&
                                    result['data']?['data']?['_id'] != null) {
                                  print("uploading the image...");
                                  await _uploadImages(
                                      result['data']['data']['_id']);
                                }

                                if (result['success']) {
                                  final updatedUserData =
                                      await _reviewController
                                          .increaseUserPoints(
                                              ref.watch(userDataProvider)?[
                                                  'userData']['_id'],
                                              500);
                                  ref
                                      .read(userDataProvider.notifier)
                                      .setUserData(updatedUserData["data"]);
                                  if (index != null && isDeparture != null) {
                                    final updatedBoardingPass = ref
                                        .read(boardingPassesProvider.notifier)
                                        .markAirportAsReviewed(
                                            index, isDeparture);
                                    await _boardingPassController
                                        .updateBoardingPass(
                                            updatedBoardingPass);
                                  }

                                  ref
                                      .read(reviewsAirlineProvider.notifier)
                                      .addReview(result['data']['data']);

                                  ref
                                      .read(aviationInfoProvider.notifier)
                                      .resetState();
                                  ref
                                      .read(reviewFeedBackProviderForAirport
                                          .notifier)
                                      .resetState();

                                  setState(() => _isLoading = false);

                                  if (!mounted) return;
                                  Navigator.pushNamed(
                                      context, AppRoutes.completereviews);
                                  // await showReviewSuccessBottomSheet(context,
                                  //     () {
                                  //   setState(() => isSuccess = true);
                                  // }, "Review airline");
                                } else {
                                  setState(() => _isLoading = false);
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Failed to submit review')),
                                  );
                                }
                              } catch (e) {
                                setState(() => _isLoading = false);
                                if (!mounted) return;
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
                color: Colors.black.withOpacity(0.5),
                child: const LoadingWidget()),
        ],
      ),
    );
  }

  Future<void> _pickMedia() async {
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
          maxDuration: const Duration(minutes: 1),
        );
      }

      if (pickedFile != null) {
        final file = File(pickedFile.path);
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
          _image.add(file);
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

  Widget _buildImageTile(File file) {
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
            onTap: _pickMedia,
            child: Container(
              height: 48,
              width: 48,
              decoration: AppStyles.cardDecoration
                  .copyWith(borderRadius: BorderRadius.circular(16)),
              child: const Icon(Icons.file_upload_outlined),
            ),
          ),
          const SizedBox(height: 12),
          Text("Choose your media for upload",
              style: AppStyles.textStyle_15_600),
        ],
      ),
    );
  }
}
