import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:airline_app/screen/app_widgets/search_field.dart';
import 'package:airline_app/screen/leaderboard/widgets/mainButton.dart';

class CustomSearchAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  final String filterType;
  final Function(String) onSearchChanged;
  final Map<String, bool> buttonStates;
  final Function(String) onButtonToggle;
  final String selectedFilterButton;

  const CustomSearchAppBar({
    super.key,
    required this.searchController,
    required this.filterType,
    required this.onSearchChanged,
    required this.buttonStates,
    required this.onButtonToggle,
    required this.selectedFilterButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 15,
            ),
          ],
        ),
      ),
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SearchBarWidget(
                searchController: searchController,
                filterType: filterType,
                onSearchChanged: onSearchChanged,
              ),
              Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.filterscreen);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.shade400, Colors.green.shade600],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.tune_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenSize.height * 0.02),
              Text(
                AppLocalizations.of(context).translate('Filter by category'),
                style: AppStyles.textStyle_18_600.copyWith(color: Colors.black),
              ),
              SizedBox(height: screenSize.height * 0.015),
              Row(
                children: buttonStates.keys.map((buttonText) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: MainButton(
                      text: buttonText,
                      isSelected: buttonText == selectedFilterButton,
                      onTap: () => onButtonToggle(buttonText),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
      toolbarHeight: screenSize.height * 0.18,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight * 2.8);
}
