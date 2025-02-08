import 'package:airline_app/screen/app_widgets/appbar_widget.dart';
import 'package:airline_app/screen/app_widgets/filter_button.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airline_app/screen/app_widgets/loading.dart';
import 'package:airline_app/provider/feed_data_provider.dart';
import 'package:airline_app/provider/feed_filter_provider.dart';
import 'package:airline_app/controller/feed_service.dart';
import 'package:airline_app/provider/feed_filter_button_provider.dart';
import 'package:airline_app/provider/review_filter_button_provider.dart';
import 'package:airline_app/screen/app_widgets/bottom_button_bar.dart';
import 'package:airline_app/screen/app_widgets/main_button.dart';

class FeedFilterScreen extends ConsumerStatefulWidget {
  const FeedFilterScreen({super.key});

  @override
  ConsumerState<FeedFilterScreen> createState() => _FeedFilterScreenState();
}

class _FeedFilterScreenState extends ConsumerState<FeedFilterScreen> {
  // Declare continents and selectedStates as instance variables
  final FeedService _feedService = FeedService();
  final List<dynamic> airType = [
    "Airline",
    "Airport",
  ];

  final List airlineCategory = [
    "Departure & Arrival Experience",
    "Comfort",
    "Cleanliness",
    "Onboard Service",
    "Airline Food",
    "Entertainment & WiFi"
  ];

  final List airportCategory = [
    "Accessibility",
    "Wait Times",
    "Helpfulness",
    "Ambience",
    "Airport Food",
    "Amenities and Facilities"
  ];

  bool categoryIsExpanded = true;
  final List<dynamic> continent = [
    "Africa",
    "Asia",
    "Europe",
    "Americas",
    "Oceania"
  ];

  bool continentIsExpanded = true;
  List<String> currentCategories = [];
  final List<dynamic> flyerClass = [
    "Business",
    "Premium Economy",
    "Economy",
  ];

  bool flyerClassIsExpanded = true;
  bool openedSearchTextField = false;
  String selectedAirType = "Airline";
  String selectedCategory = "";
  late List<bool> selectedCategoryStates;
  late List<bool> selectedContinentStates;
  List<dynamic> selectedContinents = [];
  String selectedFlyerClass = "Business";
  late List<bool> selectedFlyerClassStates;
  late List<bool> selectedairTypeStates;
  bool typeIsExpanded = true;

  @override
  void initState() {
    super.initState();
    selectedairTypeStates =
        List.generate(airType.length, (index) => index == 0);
    selectedFlyerClassStates =
        List.generate(flyerClass.length, (index) => index == 0);
    selectedContinentStates =
        List.generate(continent.length, (index) => index == 0);
  }

  void updateCurrentCategories() {
    if (selectedAirType == "Airport") {
      currentCategories = List<String>.from(airportCategory);
    } else if (selectedAirType == "Airline") {
      currentCategories = List<String>.from(airlineCategory);
    }
    selectedCategoryStates =
        List.generate(currentCategories.length, (index) => false);
  }

  void _toggleFilter(int index, List selectedStates) {
    setState(() {
      if (index == 0) {
        selectedStates[0] = !selectedStates[0];
        if (selectedStates[0]) {
          for (int i = 1; i < selectedStates.length; i++) {
            selectedStates[i] = false;
          }
        }
      } else {
        selectedStates[index] = !selectedStates[index];
        selectedStates[0] = false;

        bool allOthersSelected = true;
        for (int i = 1; i < selectedStates.length; i++) {
          if (!selectedStates[i]) {
            allOthersSelected = false;
            break;
          }
        }

        if (allOthersSelected) {
          selectedStates[0] = true;
          for (int i = 1; i < selectedStates.length; i++) {
            selectedStates[i] = false;
          }
        }
      }

      selectedContinents = [];
      for (int i = 0; i < selectedContinentStates.length; i++) {
        if (selectedContinentStates[i]) {
          selectedContinents.add(continent[i]);
        }
      }
    });
  }

  void _toggleOnlyOneFilter(int index, List selectedStates) {
    setState(() {
      for (int i = 0; i < selectedStates.length; i++) {
        selectedStates[i] = false;
      }
      selectedStates[index] = true;

      if (selectedStates == selectedairTypeStates) {
        selectedAirType = airType[index];
        updateCurrentCategories();
      } else if (selectedStates == selectedFlyerClassStates) {
        selectedFlyerClass = flyerClass[index];
      } else if (selectedStates == selectedCategoryStates) {
        selectedCategory = currentCategories[index];
      }
    });
  }

  Widget _buildTypeCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context).translate('Type'),
                style: AppStyles.textStyle_18_600),
            IconButton(
                onPressed: () {
                  setState(() {
                    typeIsExpanded = !typeIsExpanded;
                  });
                },
                icon: Icon(
                    typeIsExpanded ? Icons.expand_more : Icons.expand_less)),
          ],
        ),
        Visibility(
            visible: typeIsExpanded,
            child: Column(
              children: [
                const SizedBox(height: 17),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(
                      airType.length,
                      (index) => FilterButton(
                            text: AppLocalizations.of(context)
                                .translate(airType[index]),
                            isSelected: selectedairTypeStates[index],
                            onTap: () => _toggleOnlyOneFilter(
                                index, selectedairTypeStates),
                          )),
                ),
              ],
            ))
      ],
    );
  }

  Widget _buildFlyerClassLeaderboards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context).translate('Flyer Class'),
                style: AppStyles.textStyle_18_600),
            IconButton(
                onPressed: () {
                  setState(() {
                    flyerClassIsExpanded = !flyerClassIsExpanded;
                  });
                },
                icon: Icon(flyerClassIsExpanded
                    ? Icons.expand_more
                    : Icons.expand_less)),
          ],
        ),
        Visibility(
          visible: flyerClassIsExpanded,
          child: Column(
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                    flyerClass.length,
                    (index) => FilterButton(
                          text: AppLocalizations.of(context)
                              .translate('${flyerClass[index]}'),
                          isSelected: selectedFlyerClassStates[index],
                          onTap: () => _toggleOnlyOneFilter(
                              index, selectedFlyerClassStates),
                        )),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryLeaderboards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context).translate('Categories'),
                style: AppStyles.textStyle_18_600),
            IconButton(
                onPressed: () {
                  setState(() {
                    categoryIsExpanded = !categoryIsExpanded;
                  });
                },
                icon: Icon(categoryIsExpanded
                    ? Icons.expand_more
                    : Icons.expand_less)),
          ],
        ),
        Visibility(
          visible: categoryIsExpanded,
          child: Column(
            children: [
              selectedAirType == "All"
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "To access this feature, please select an airline or airport.",
                        style: AppStyles.textStyle_15_600,
                      ),
                    )
                  : Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(
                          currentCategories.length,
                          (index) => FilterButton(
                                text: AppLocalizations.of(context)
                                    .translate(currentCategories[index]),
                                isSelected: selectedCategoryStates[index],
                                onTap: () => _toggleOnlyOneFilter(
                                    index, selectedCategoryStates),
                              )),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContinentLeaderboards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context).translate('Best by Continents'),
                style: AppStyles.textStyle_16_600),
            IconButton(
                onPressed: () {
                  setState(() {
                    continentIsExpanded = !continentIsExpanded;
                  });
                },
                icon: Icon(continentIsExpanded
                    ? Icons.expand_more
                    : Icons.expand_less)),
          ],
        ),
        Visibility(
            visible: continentIsExpanded,
            child: Column(
              children: [
                const SizedBox(height: 17),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(
                      continent.length,
                      (index) => FilterButton(
                            text: AppLocalizations.of(context)
                                .translate('${continent[index]}'),
                            isSelected: selectedContinentStates[index],
                            onTap: () =>
                                _toggleFilter(index, selectedContinentStates),
                          )),
                ),
              ],
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppbarWidget(
        title: "Filter",
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildTypeCategory(),
            const SizedBox(height: 17),
            _buildFlyerClassLeaderboards(),
            const SizedBox(height: 17),
          ],
        ),
      ),
      bottomNavigationBar: BottomButtonBar(
        child: MainButton(
          text: AppLocalizations.of(context).translate('Apply'),
          onPressed: () async {
            try {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(child: LoadingWidget()),
              );

              ref
                  .read(reviewFilterButtonProvider.notifier)
                  .setFilterType(selectedAirType);

              ref.read(feedFilterProvider.notifier).setFilters(
                    airType: selectedAirType,
                    flyerClass: selectedFlyerClass ?? "Business",
                    category:
                        selectedCategory.isEmpty ? null : selectedCategory,
                    continents: selectedContinents.isEmpty ||
                            selectedContinents[0] == "All"
                        ? ["Africa", "Asia", "Europe", "Americas", "Oceania"]
                        : selectedContinents.cast<String>(),
                  );

              final result = await _feedService.getFilteredFeed(
                airType: selectedAirType,
                flyerClass: selectedFlyerClass,
                category: selectedCategory.isEmpty ? null : selectedCategory,
                continents:
                    selectedContinents.isEmpty || selectedContinents[0] == "All"
                        ? ["Africa", "Asia", "Europe", "Americas", "Oceania"]
                        : selectedContinents.cast<String>(),
                page: 1,
              );

              ref
                  .read(feedFilterButtonProvider.notifier)
                  .setFilterType(selectedAirType);
              ref.read(feedDataProvider.notifier).setData(result);

              Navigator.pop(context);
              Navigator.pop(context);
            } catch (e) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text('Failed to fetch filtered data: ${e.toString()}')),
              );
            }
          },
        ),
      ),
    );
  }
}
