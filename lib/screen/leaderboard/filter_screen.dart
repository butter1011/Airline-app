import 'package:airline_app/screen/leaderboard/widgets/airports_each_continent.dart';
import 'package:airline_app/screen/leaderboard/widgets/filter_button.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Declare continents and selectedStates as instance variables
  final List<String> continents = [
    "All",
    "Africa",
    "Asia",
    "Europe",
    "North America",
    "South America",
    "Australia"
  ];

  // Track selection state for each continent button
  late List<bool>
      selectedStates; // Use 'late' to indicate it will be initialized later

  @override
  void initState() {
    super.initState();
    // Initialize selectedStates based on the number of continents
    selectedStates = List.filled(continents.length, false);
  }

  void _toggleFilter(int index) {
    setState(() {
      if (index == 0) {
        // If "All" is clicked, select it and deselect others
        selectedStates[0] = !selectedStates[0]; // Toggle "All"
        if (selectedStates[0]) {
          // If "All" is selected, deselect all others
          for (int i = 1; i < selectedStates.length; i++) {
            selectedStates[i] = true;
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

  List<String> getSelectedContinents() {
    List<String> selectedContinents = [];
    for (int i = 1; i < selectedStates.length; i++) {
      if (selectedStates[i]) {
        selectedContinents.add(continents[i]);
      }
    }
    return selectedContinents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.arrow_back_ios, size: 24),
        title: Text(
          "Filters",
          textAlign: TextAlign.center,
          style: AppStyles.textStyle_16_600,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 29),
            child: Icon(Icons.search, size: 24),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(height: 4, color: AppStyles.littleBlackColor),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _buildTypeCategory(),
                  const SizedBox(height: 25),
                  _buildGlobalRegionalLeaderboards(),
                  const SizedBox(height: 18),
                  _buildCategorySpecificLeaderboards(
                      "Category-Specific Leaderboards"),
                  const SizedBox(height: 25),
                  _buildClassSpecificLeaderboards(
                      "Class-Specific Leaderboards"),
                ],
              ),
            ),
          ),
          _buildApplyButton(),
        ],
      ),
    );
  }

  Widget _buildTypeCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Type", style: AppStyles.textStyle_18_600),
            const Icon(Icons.expand_less),
          ],
        ),
        const SizedBox(height: 16),
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilterButton(text: 'All'),
            FilterButton(text: 'Airports'),
            FilterButton(text: 'Airline'),
          ],
        ),
      ],
    );
  }

  Widget _buildGlobalRegionalLeaderboards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Global & Regional Leaderboards",
                style: AppStyles.textStyle_18_600),
            const Icon(Icons.expand_less),
          ],
        ),
        const SizedBox(height: 10),
        _buildContinentsSection(),
      ],
    );
  }

  Widget _buildContinentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Best by Continents', style: AppStyles.textStyle_16_600),
            const Icon(Icons.expand_less),
          ],
        ),
        const SizedBox(height: 17),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
              continents.length,
              (index) => ContinentFilterButton(
                    text: continents[index],
                    isSelected: selectedStates[index],
                    onTap: () => _toggleFilter(index),
                  )),
        ),
        const SizedBox(height: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: getSelectedContinents()
              .map((singleKey) => AirportsEachContinent(continent: singleKey))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildCategorySpecificLeaderboards(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppStyles.textStyle_18_600),
            const Icon(Icons.expand_less),
          ],
        ),
        const SizedBox(height: 16),
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilterButton(text: "All"),
            FilterButton(text: "Best Wi-Fi"),
            FilterButton(text: "Best Food"),
            FilterButton(text: "Best Seat Comfort"),
            FilterButton(text: "Cleanliness"),
          ],
        ),
      ],
    );
  }

  Widget _buildClassSpecificLeaderboards(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppStyles.textStyle_18_600),
            const Icon(Icons.expand_less),
          ],
        ),
        const SizedBox(height: 16),
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilterButton(text: "All"),
            FilterButton(text: "Best First Class"),
            FilterButton(text: "Best Business Class"),
            FilterButton(text: "Best Economy Class"),
          ],
        ),
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
          child: Container(
            width: MediaQuery.of(context).size.width * 0.87,
            height: 56,
            decoration: BoxDecoration(
                color: AppStyles.mainColor,
                border: Border.all(width: 2, color: AppStyles.littleBlackColor),
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
                color: isSelected ? AppStyles.mainColor : Colors.white,
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
