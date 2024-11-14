import 'package:airline_app/screen/leaderboard/widgets/filter_button.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Declare continents and selectedStates as instance variables
  final List<String> airType = [
    "All",
    "Airports",
    "Airline",
  ];
  final List<String> flyerClass = [
    "All",
    "First Class",
    "Business",
    "Premium economy",
    "Economy",
    "Presidential",
  ];
  final List<String> category = [
    "All",
    "First Class",
    "Business",
    "Premium economy",
    "Economy",
    "Presidential",
  ];

  final List<String> continent = [
    "All",
    "Africa",
    "Asia",
    "Europe",
    "North America",
    "South America",
    "Australia"
  ];

  // Track selection state for each continent button
  late List<bool> selectedairTypeStates;

  // Use 'late' to indicate it will be initialized later
  late List<bool> selectedFlyerClassStates;
  late List<bool> selectedCategoryStates;
  late List<bool> selectedContinentStates;

  bool typeIsExpanded = true;
  bool flyerClassIsExpanded = true;
  bool categoryIsExpanded = true;
  bool rankIsExpanded = true;
  bool continentIsExpanded = true;
  bool openedSearchTextField = false;

  @override
  void initState() {
    super.initState();
    // Initialize selectedStates based on the number of continents
    selectedairTypeStates = List.filled(airType.length, false);
    selectedFlyerClassStates = List.filled(flyerClass.length, false);
    selectedCategoryStates = List.filled(category.length, false);
    selectedContinentStates = List.filled(continent.length, false);
  }

  void _toggleFilter(int index, List selectedStates) {
    setState(() {
      if (index == 0) {
        // If "All" is clicked
        if (selectedStates[0]) {
          // If "All" is already selected, deselect it and all others
          selectedStates[0] = false;
          for (int i = 1; i < selectedStates.length; i++) {
            selectedStates[i] = false;
          }
        } else {
          // Toggle "All" on
          selectedStates[0] = true;
          // Deselect all others
          for (int i = 1; i < selectedStates.length; i++) {
            selectedStates[i] = true; // Select all others
          }
        }
      } else {
        // If any other button is clicked, toggle its selection
        selectedStates[index] = !selectedStates[index];

        // If any button other than "All" is selected, deselect "All"
        if (selectedStates[index]) {
          selectedStates[0] = false;
        }
      }

      // Check if all continent buttons are selected
      bool allSelected = true;
      for (int i = 1; i < selectedStates.length; i++) {
        if (!selectedStates[i]) {
          allSelected = false;
          break;
        }
      }

      // If all continents are selected, select "All"
      selectedStates[0] = allSelected;
    });
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
                "Filters",
                textAlign: TextAlign.center,
                style: AppStyles.textStyle_16_600,
              ),
        actions: [
          openedSearchTextField
              ? Text("")
              : Padding(
                  padding: const EdgeInsets.only(right: 29),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        openedSearchTextField = !openedSearchTextField;
                      });
                    },
                    icon: Icon(Icons.search, size: 24),
                  ),
                )
        ],
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
            _buildRankLeaderboards(),
            const SizedBox(height: 10),
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
            Text('Type', style: AppStyles.textStyle_18_600),
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
                      (index) => ContinentFilterButton(
                            text: airType[index],
                            isSelected: selectedairTypeStates[index],
                            onTap: () =>
                                _toggleFilter(index, selectedairTypeStates),
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
            Text('Flyer Class', style: AppStyles.textStyle_18_600),
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
                    (index) => ContinentFilterButton(
                          text: flyerClass[index],
                          isSelected: selectedFlyerClassStates[index],
                          onTap: () =>
                              _toggleFilter(index, selectedFlyerClassStates),
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
            Text('Categories', style: AppStyles.textStyle_18_600),
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
                const SizedBox(height: 17),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(
                      category.length,
                      (index) => ContinentFilterButton(
                            text: category[index],
                            isSelected: selectedCategoryStates[index],
                            onTap: () =>
                                _toggleFilter(index, selectedCategoryStates),
                          )),
                ),
              ],
            ))
      ],
    );
  }

  Widget _buildRankLeaderboards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Filter Rank', style: AppStyles.textStyle_18_600),
            IconButton(
                onPressed: () {
                  setState(() {
                    rankIsExpanded = !rankIsExpanded;
                  });
                },
                icon: Icon(
                    rankIsExpanded ? Icons.expand_more : Icons.expand_less)),
          ],
        ),
        // const SizedBox(height: 17),
        // Wrap(
        //   spacing: 8,
        //   runSpacing: 8,
        //   children: List.generate(
        //       category.length,
        //       (index) => ContinentFilterButton(
        //             text: category[index],
        //             isSelected: selectedCategoryStates[index],
        //             onTap: () => _toggleFilter(index, selectedCategoryStates),
        //           )),
        // ),
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
            Text('Best by Continents', style: AppStyles.textStyle_16_600),
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
                      (index) => ContinentFilterButton(
                            text: continent[index],
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
              Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.87,
              height: 56,
              decoration: BoxDecoration(
                  color: AppStyles.mainColor,
                  border:
                      Border.all(width: 2, color: AppStyles.littleBlackColor),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                        color: AppStyles.littleBlackColor, offset: Offset(2, 2))
                  ]),
              child: Center(
                child: Text(
                  "Apply",
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

class ContinentFilterButton extends StatelessWidget {
  const ContinentFilterButton({
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
                borderRadius: BorderRadius.circular(30),
                color: text == "All"
                    ? AppStyles.mainColor
                    : (isSelected ? AppStyles.mainColor : Colors.white),
                border: Border(
                  top: BorderSide(color: Colors.black, width: 2.0),
                  left: BorderSide(color: Colors.black, width: 2.0),
                  bottom: BorderSide(color: Colors.black, width: 4.0),
                  right: BorderSide(color: Colors.black, width: 4.0),
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
