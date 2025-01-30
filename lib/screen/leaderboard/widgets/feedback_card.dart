import 'package:airline_app/screen/profile/widget/basic_black_button.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:airline_app/utils/global_variable.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airline_app/provider/airline_airport_review_provider.dart';
import 'package:airline_app/provider/user_data_provider.dart';

class FeedbackCard extends ConsumerStatefulWidget {
  const FeedbackCard(
      {super.key, required this.singleFeedback, required this.thumbnailHeight});

  final Map<String, dynamic> singleFeedback;
  final double thumbnailHeight;

  @override
  ConsumerState<FeedbackCard> createState() => _FeedbackCardState();
}

class _FeedbackCardState extends ConsumerState<FeedbackCard> {
  final CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  bool isFavorite = false;
  int? selectedEmojiIndex;
  late int totalFavorites;

  final Map<String, VideoPlayerController> _videoControllers = {};
  final Map<String, Duration> _videoPositions = {};

  @override
  void dispose() {
    for (var controller in _videoControllers.values) {
      // Store position before disposing
      _videoPositions[controller.dataSource] = controller.value.position;
      controller.pause();
      // Clear video buffer before disposing
      controller.setVolume(0);
      controller.removeListener(() {});
      controller.dispose();
    }
    _videoControllers.clear();
    _videoPositions.clear(); // Clear stored positions
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    for (var media in widget.singleFeedback['imageUrls'] ?? []) {
      if (media.toLowerCase().endsWith('.mp4') ||
          media.toLowerCase().endsWith('.mov')) {
        _videoControllers[media] = VideoPlayerController.networkUrl(
          Uri.parse(media),
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
        )..initialize().then((_) {
            if (mounted) {
              setState(() {
                _videoControllers[media]?.setLooping(true);
                _handleVideoState();
              });
            }
          });
      }
    }

    // Initialize favorite state and count
    final userId = ref.read(userDataProvider)?['userData']?['_id'];
    isFavorite = (widget.singleFeedback['rating'] as List).contains(userId);
    totalFavorites = (widget.singleFeedback['rating'] as List).length;
  }

  void _handleVideoState() {
    if (mounted) {
      _videoControllers.forEach((url, controller) {
        if (!controller.value.isPlaying) {
          controller.play();
        }
      });
    }
  }

  Widget _buildVideoPlayer(String videoUrl) {
    final controller = _videoControllers[videoUrl];
    if (controller == null) return Container();

    if (controller.value.isInitialized) {
      // Restore previous position if available
      if (_videoPositions.containsKey(videoUrl)) {
        controller.seekTo(_videoPositions[videoUrl]!);
        _videoPositions.remove(videoUrl); // Clear after seeking
      }
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller..play()),
      );
    }
    return Center(
      child: CircularProgressIndicator(
        color: Colors.grey,
      ),
    );
  }

  @override
  void deactivate() {
    // Pause and clear cache when widget is not visible
    for (var controller in _videoControllers.values) {
      controller.pause();
      controller.setVolume(0);
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.singleFeedback['reviewer'] == null ||
        widget.singleFeedback['airline'] == null) {
      return Container();
    }
    final userId = ref.watch(userDataProvider)?['userData']?['_id'];
    final List<dynamic> imageUrls = widget.singleFeedback['imageUrls'] ?? [];

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: AppStyles.circleDecoration,
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: (widget.singleFeedback['reviewer']
                                  ['profilePhoto'] !=
                              '' &&
                          widget.singleFeedback['reviewer']['profilePhoto'] !=
                              null)
                      ? NetworkImage(
                          '${widget.singleFeedback['reviewer']['profilePhoto']}')
                      : const AssetImage("assets/images/avatar_1.png")
                          as ImageProvider,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.singleFeedback['reviewer']['name'] ?? '',
                      style: AppStyles.textStyle_14_600,
                    ),
                    Text(
                      'Rated ${(widget.singleFeedback['score'] ?? 0).toStringAsFixed(1)}/10 on ${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(8, 10)}.${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(5, 7)}.${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(2, 4)}',
                      style: AppStyles.textStyle_14_400_grey,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 12),
          BasicBlackButton(
              mywidth: 68,
              myheight: 24,
              myColor: Colors.black,
              btntext: "Verified"),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Text('Flex with', style: AppStyles.textStyle_14_400_littleGrey),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                    '${widget.singleFeedback['airline']['name'].toString().length > 13 ? '${widget.singleFeedback['airline']['name'].toString().substring(0, 13)}..' : widget.singleFeedback['airline']['name']}, ${widget.singleFeedback['classTravel']}',
                    style: AppStyles.textStyle_14_600),
              )
            ],
          ),
          SizedBox(height: 7),
          widget.singleFeedback['from'] != null
              ? Row(
                  children: [
                    Text('Flex from',
                        style: AppStyles.textStyle_14_400_littleGrey),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                          '${widget.singleFeedback['from']['city'].toString().length > 12 ? '${widget.singleFeedback['from']['city'].toString().substring(0, 12)}..' : widget.singleFeedback['from']['city']} -> ${widget.singleFeedback['to']['city'].toString().length > 12 ? '${widget.singleFeedback['to']['city'].toString().substring(0, 12)}..' : widget.singleFeedback['to']['city']}',
                          style: AppStyles.textStyle_14_600),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Text('Flex in',
                        style: AppStyles.textStyle_14_400_littleGrey),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text('${widget.singleFeedback['airport']['city']}',
                          style: AppStyles.textStyle_14_600),
                    ),
                  ],
                ),
          SizedBox(height: 11),
          if (imageUrls.isNotEmpty)
            Stack(
              children: [
                widget.singleFeedback['from'] != null
                    ? InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.mediafullscreen,
                              arguments: {
                                'userId': userId,
                                'feedbackId': widget.singleFeedback['_id'],
                                'imageUrls': imageUrls,
                                'Name': widget.singleFeedback['reviewer']
                                    ['name'],
                                'Avatar': widget.singleFeedback['reviewer']
                                    ['profilePhoto'],
                                'Date':
                                    'Rated ${(widget.singleFeedback['score'] ?? 0).toStringAsFixed(1)}/10 on ${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(8, 10)}.${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(5, 7)}.${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(2, 4)}',
                                'Usedairport': widget.singleFeedback['airline']
                                    ['name'],
                                'Content': widget.singleFeedback['comment'] !=
                                            null &&
                                        widget.singleFeedback['comment'] != ''
                                    ? widget.singleFeedback['comment']
                                    : '',
                                'rating': totalFavorites.toString(),
                              });
                        },
                        child: CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 189,
                            enableInfiniteScroll: false,
                          ),
                          carouselController: buttonCarouselController,
                          items: imageUrls.map((mediaItem) {
                            return Builder(builder: (BuildContext context) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  height: 189,
                                  child: mediaItem
                                          .toString()
                                          .toLowerCase()
                                          .contains(
                                              RegExp(r'\.(mp4|mov|avi|wmv)$'))
                                      ? _buildVideoPlayer(mediaItem)
                                      : Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage('$mediaItem'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                ),
                              );
                            });
                          }).toList(),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.mediafullscreen,
                              arguments: {
                                'userId': userId,
                                'feedbackId': widget.singleFeedback['_id'],
                                'imageUrls': imageUrls,
                                'Name': widget.singleFeedback['reviewer']
                                    ['name'],
                                'Avatar': widget.singleFeedback['reviewer']
                                    ['profilePhoto'],
                                'Date':
                                    'Rated ${(widget.singleFeedback['score'] ?? 0).toStringAsFixed(1)}/10 on ${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(8, 10)}.${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(5, 7)}.${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(2, 4)}',
                                'Usedairport': widget.singleFeedback['airport']
                                    ['name'],
                                'Content': widget.singleFeedback['comment'] !=
                                            null &&
                                        widget.singleFeedback['comment'] != ''
                                    ? widget.singleFeedback['comment']
                                    : '',
                                'rating': totalFavorites.toString(),
                              });
                        },
                        child: CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 189,
                            enableInfiniteScroll: false,
                          ),
                          carouselController: buttonCarouselController,
                          items: imageUrls.map((mediaItem) {
                            return Builder(builder: (BuildContext context) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  height: 189,
                                  child: mediaItem
                                          .toString()
                                          .toLowerCase()
                                          .contains(
                                              RegExp(r'\.(mp4|mov|avi|wmv)$'))
                                      ? _buildVideoPlayer(mediaItem)
                                      : Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage('$mediaItem'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                ),
                              );
                            });
                          }).toList(),
                        ),
                      ),
              ],
            ),
          const SizedBox(height: 11),
          SizedBox(
            height: 40,
            child: Text(
              widget.singleFeedback['comment'] != null &&
                      widget.singleFeedback['comment'].isNotEmpty
                  ? widget.singleFeedback['comment']
                  : 'No comment given',
              style: widget.singleFeedback['comment'] != null &&
                      widget.singleFeedback['comment'].isNotEmpty
                  ? AppStyles.textStyle_14_400
                  : AppStyles.textStyle_14_400
                      .copyWith(fontStyle: FontStyle.italic),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.singleFeedback['from'] != null
                  ? Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            setState(() {
                              isFavorite = !isFavorite;

                              if (isFavorite) {
                                totalFavorites++;
                              } else {
                                totalFavorites--;
                              }
                            });

                            try {
                              // Update reaction in backend

                              final response = await http.post(
                                Uri.parse(
                                    '$apiUrl/api/v1/airline-review/update'),
                                headers: {
                                  'Content-Type': 'application/json',
                                  'Accept': 'application/json',
                                },
                                body: jsonEncode({
                                  'feedbackId': widget.singleFeedback['_id'],
                                  'user_id': userId,
                                  'isFavorite': isFavorite,
                                }),
                              );

                              if (response.statusCode == 200) {
                                setState(() {
                                  ref
                                      .read(reviewsAirlineAirportProvider
                                          .notifier)
                                      .updateReview(
                                          jsonDecode(response.body)['data']);
                                });
                              } else {
                                print('Failed to update reaction');
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Something went wrong')),
                              );
                            }
                          },
                          icon: isFavorite
                              ? Icon(Icons.favorite, color: Colors.red)
                              : Icon(Icons.favorite_border),
                        ),
                        SizedBox(width: 8),
                        AnimatedFlipCounter(
                          value: totalFavorites,
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            setState(() {
                              isFavorite = !isFavorite;
                              if (isFavorite) {
                                totalFavorites++;
                              } else {
                                totalFavorites--;
                              }
                            });

                            try {
                              // Update reaction in backend

                              final response = await http.post(
                                Uri.parse(
                                    '$apiUrl/api/v1/airport-review/update'),
                                headers: {
                                  'Content-Type': 'application/json',
                                  'Accept': 'application/json',
                                },
                                body: jsonEncode({
                                  'feedbackId': widget.singleFeedback['_id'],
                                  'user_id': userId,
                                  'isFavorite': isFavorite,
                                }),
                              );

                              if (response.statusCode == 200) {
                                setState(() {
                                  ref
                                      .read(reviewsAirlineAirportProvider
                                          .notifier)
                                      .updateReview(
                                          jsonDecode(response.body)['data']);
                                });
                              } else {
                                print('Failed to update reaction');
                                // Show error message if API call fails
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //       content:
                                //           Text('Failed to update reaction')),
                                // );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Something went wrong')),
                              );
                            }
                          },
                          icon: isFavorite
                              ? Icon(Icons.favorite, color: Colors.red)
                              : Icon(Icons.favorite_border),
                        ),
                        SizedBox(width: 8),
                        AnimatedFlipCounter(
                          value: totalFavorites,
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
