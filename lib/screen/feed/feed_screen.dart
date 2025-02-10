import 'package:airline_app/screen/app_widgets/bottom_nav_bar.dart';
import 'package:airline_app/screen/app_widgets/custom_search_appbar.dart';
import 'package:airline_app/screen/app_widgets/keyboard_dismiss_widget.dart';
import 'package:airline_app/screen/app_widgets/loading.dart';
import 'package:airline_app/screen/leaderboard/widgets/feedback_card.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airline_app/provider/feed_data_provider.dart';
import 'package:airline_app/provider/feed_filter_provider.dart';
import 'package:airline_app/controller/feed_service.dart';
import 'package:airline_app/provider/review_filter_button_provider.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  final ScrollController _scrollController = ScrollController();
  Map<String, bool> buttonStates = {
    // "All": true,
    "Airline": true,
    "Airport": false,
  };

  String filterType = 'Airline';
  bool hasMore = true;
  bool isLoading = false;
  late bool selectedAirline = false;
  late bool selectedAirport = false;
  late bool selectedAll = true;
  late bool selectedCleanliness = false;
  late bool selectedOnboard = false;

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void toggleButton(String buttonText) {
    setState(() {
      buttonStates.updateAll((key, value) => false);
      buttonStates[buttonText] = true;
      filterType = buttonText;
    });

    // Update filter type in providers
    ref.read(reviewFilterButtonProvider.notifier).setFilterType(buttonText);
    ref.read(feedFilterProvider.notifier).setFilters(
          airType: buttonText,
          flyerClass: ref.read(feedFilterProvider).flyerClass,
          category: ref.read(feedFilterProvider).category,
          continents: ref.read(feedFilterProvider).continents,
        );

    // Fetch new data with updated filter
    fetchFeedData(page: 1);
  }

  Future<void> fetchFeedData({int? page}) async {
    if (!mounted) return;  // Add this check
  
    setState(() {
      isLoading = true;
    });

    final FeedService _feedService = FeedService();
    final filterState = ref.read(feedFilterProvider);

    try {
      final result = await _feedService.getFilteredFeed(
        airType: filterState.airType,
        flyerClass: filterState.flyerClass,
        category: filterState.category,
        continents: filterState.continents,
        page: page ?? filterState.currentPage,
        searchQuery: _searchQuery,
      );

      if (!mounted) return;  // Add this check

      if (page == 1) {
        ref.read(feedDataProvider.notifier).setData(result);
      } else {
        ref.read(feedDataProvider.notifier).appendData(result);
      }

      setState(() {
        hasMore = result['hasMore'] ?? true;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;  // Add this check
    
      debugPrint('Error fetching feed data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void loadMoreData() {
    if (hasMore) {
      final currentPosition = _scrollController.position.pixels;

      ref.read(feedFilterProvider.notifier).incrementPage();
      fetchFeedData().then((_) {
        // After new data is loaded, restore scroll position
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.jumpTo(currentPosition);
        });
      });
    }
  }

  Future<void> _initializeData() async {
    if (!mounted) return;
    
    setState(() {
      isLoading = true;
    });
    
    await Future.wait([
      fetchFeedData(page: 1),
    ]);
    
    if (!mounted) return;
    
    setState(() {
      isLoading = false;
    });
  }

  void _handleSearchSubmit() {
    fetchFeedData(page: 1);
  }

  @override
  // ignore: unused_element
  Widget build(BuildContext context) {
    final feedState = ref.watch(feedDataProvider);
    return PopScope(
      canPop: false, // Prevents the default pop action
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
        }
      },
      child: KeyboardDismissWidget(
        child: Scaffold(
          appBar: CustomSearchAppBar(
            searchController: _searchController,
            filterType: filterType,
            onSearchChanged: (value) {
              setState(() {
                _searchQuery = value.toLowerCase();
              });
            },
            onSearchSubmit: _handleSearchSubmit,
            buttonStates: buttonStates,
            onButtonToggle: toggleButton,
            selectedFilterButton: ref.watch(reviewFilterButtonProvider),
          ),
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavBar(currentIndex: 1),
          body: Stack(
            children: [
              KeyboardDismissWidget(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Column(
                                    children: feedState.allData.isEmpty
                                        ? [
                                            Text("No reviews available",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500))
                                          ]
                                        : feedState.allData
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                            final index = entry.key;
                                            final singleReview = entry.value;
                                            final reviewer =
                                                singleReview['reviewer'];
                                            final airline =
                                                singleReview['airline'];

                                            if (reviewer != null &&
                                                airline != null) {
                                              return Column(
                                                children: [
                                                  FeedbackCard(
                                                    thumbnailHeight: 260,
                                                    singleFeedback:
                                                        singleReview,
                                                  ),
                                                  if (index !=
                                                      feedState.allData.length -
                                                          1)
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 24.0),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 9,
                                                          ),
                                                          Divider(
                                                            thickness: 1,
                                                            color: Colors
                                                                .grey.shade300,
                                                          ),
                                                          SizedBox(
                                                            height: 24,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                              );
                                            }
                                            return const SizedBox.shrink();
                                          }).toList(),
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  if (feedState.hasMore)
                                    Center(
                                      child: GestureDetector(
                                        onTap: loadMoreData,
                                        child: IntrinsicWidth(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  AppLocalizations.of(context)
                                                      .translate('Expand more'),
                                                  style: AppStyles
                                                      .textStyle_18_600
                                                      .copyWith(fontSize: 15)),
                                              const SizedBox(width: 8),
                                              const Icon(Icons.arrow_downward),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (isLoading)
                Container(
                  color: Colors.white.withOpacity(0.7),
                  child: const Center(
                    child: LoadingWidget(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
