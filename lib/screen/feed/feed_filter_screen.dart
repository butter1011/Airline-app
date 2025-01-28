import 'package:airline_app/provider/airline_airport_review_provider.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedFilterScreen extends ConsumerStatefulWidget {
  const FeedFilterScreen({super.key});

  @override
  ConsumerState<FeedFilterScreen> createState() => _FeedFilterScreenState();
}

class _FeedFilterScreenState extends ConsumerState<FeedFilterScreen> {
  // Declare continents and selectedStates as instance variables
  final List<dynamic> airType = [
    "All",
    "Airport",
    "Airline",
  ];
  final List<dynamic> flyerClass = [
    "All",
    "Business",
    "Premium economy",
    "Economy",
  ];
  final List airlineCategory = [
    "Departure & Arrival Experience",
    "Comfort",
    "Cleanliness",
    "Onboard Service",
    "Food & Beverage",
    "Entertainment & WiFi"
  ];
  final List airportCategory = [
    "Accessibility",
    "Wait Times",
    "Helpfulness",
    "Ambience",
    "Food & Beverage",
    "Amenities and Facilities"
  ];
  final List<dynamic> continent = [
    "All",
    "Africa",
    "Asia",
    "Europe",
    "Americas",
    "Oceania"
  ];

  late List<bool> selectedairTypeStates;
  late List<bool> selectedFlyerClassStates;
  late List<bool> selectedContinentStates;
  late List<bool> selectedCategoryStates;
  List<String> currentCategories = [];

  bool typeIsExpanded = true;
  bool flyerClassIsExpanded = true;
  bool categoryIsExpanded = true;
  bool continentIsExpanded = true;
  bool openedSearchTextField = false;

  String selectedAirType = "All";
  String selectedFlyerClass = "";
  String selectedCategory = "";
  List<dynamic> selectedContinents = [];

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
    ref.read(reviewsAirlineProvider.notifier).getFilteredReviews(
          selectedAirType,
          null,
          selectedFlyerClass,
          selectedCategory,
          selectedContinents[0] == "All"
              ? ["Africa", "Asia", "Europe", "Americas", "Oceania"]
              : selectedContinents,
        );
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


    ref.read(reviewsAirlineProvider.notifier).getFilteredReviews(
          selectedAirType,
          null,
          selectedFlyerClass == "All" ? null : selectedFlyerClass,
          selectedCategory,
          selectedContinents.isEmpty || selectedContinents[0] == "All"
              ? ["Africa", "Asia", "Europe", "Americas", "Oceania"]
              : selectedContinents,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios, size: 24)),
        title: openedSearchTextField
            ? TextField(
                decoration: InputDecoration(
                  hintStyle: AppStyles.textStyle_14_400
                      .copyWith(color: Color(0xff38433E)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  prefixIcon: Icon(
                    Icons.search,
                    color:
                        Color(0xff38433E), // Set the color of the search icon
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        openedSearchTextField = false;
                      });
                    },
                    icon: Image.asset('assets/icons/icon_cancel.png'),
                  ),
                ),
              )
            : Text(
                AppLocalizations.of(context).translate('Filters'),
                textAlign: TextAlign.center,
                style: AppStyles.textStyle_16_600,
              ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(color: Colors.black, height: 4.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildTypeCategory(),
            const SizedBox(height: 17),
            _buildFlyerClassLeaderboards(),
            const SizedBox(height: 17),
            _buildCategoryLeaderboards(),
            const SizedBox(height: 17),
            _buildContinentLeaderboards(),
            const SizedBox(height: 85),
          ],
        ),
      ),
      bottomSheet: _buildApplyButton(),
    );
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

  Widget _buildApplyButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 4,
          color: AppStyles.littleBlackColor,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.87,
              height: 56,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border.all(width: 2, color: AppStyles.littleBlackColor),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                        color: AppStyles.littleBlackColor, offset: Offset(2, 2))
                  ]),
              child: Center(
                child: Text(
                  AppLocalizations.of(context).translate('Apply'),
                  style: AppStyles.textStyle_15_600,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: IntrinsicWidth(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isSelected ? AppStyles.mainColor : Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.black, width: 2),
                  left: BorderSide(color: Colors.black, width: 2),
                  bottom: BorderSide(color: Colors.black, width: 4),
                  right: BorderSide(color: Colors.black, width: 4),
                )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(text, style: AppStyles.textStyle_14_600),
              ),
            ),
          ),
        ));
  }
}
