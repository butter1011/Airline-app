import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/screen/profile/utils/country_code_json.dart';

class CardBookMark extends ConsumerStatefulWidget {
  const CardBookMark({Key? key}) : super(key: key);

  @override
  ConsumerState<CardBookMark> createState() => _CardBookMarkState();
}

class _CardBookMarkState extends ConsumerState<CardBookMark> {
  Map<String, List<dynamic>> _userBookmarkList = {};
  Map<String, List<Map<String, dynamic>>> _bookmarksItems = {};
  Map<String, String> _continentMap = {};

  @override
  void initState() {
    super.initState();
    _initializeContinentMap();
    _loadBookmarks();
  }

  void _initializeContinentMap() {
    _continentMap = Map<String, String>.from(countryCode[0]);
  }

  String _getContinentFromCountryCode(String countryCode) {
    return _continentMap[countryCode.toUpperCase()] ?? 'Unknown';
  }

  Future<void> _loadBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? bookmarksJson = prefs.getString('bookmarks');
      if (bookmarksJson != null) {
        setState(() {
          _userBookmarkList = Map<String, List<dynamic>>.from(
            jsonDecode(bookmarksJson).map(
              (key, value) => MapEntry(key, List<dynamic>.from(value)),
            ),
          );
        });
      }

      final userId = ref.watch(userDataProvider)?['userData']?['_id'];
      // final airlineInfo = ref.watch(airlineAirportProvider).filteredList;
      final List<Map<String, dynamic>> leaderBoardList =
          ref.watch(airlineAirportProvider).filteredList;
      // [
      //   ...airlineInfo.airlineData.map((e) => Map<String, dynamic>.from(e)),
      //   ...airlineInfo.airportData.map((e) => Map<String, dynamic>.from(e)),
      // ];

      if (userId != null) {
        final bookmarks = _userBookmarkList[userId];
        if (bookmarks != null) {
          final Map<String, List<Map<String, dynamic>>> sortedBookmarks = {};

          for (var bookmarkId in bookmarks) {
            final airline = leaderBoardList.firstWhere(
              (airline) => airline['_id'] == bookmarkId,
              orElse: () => <String, dynamic>{},
            );
            if (airline.isNotEmpty && airline['countryCode'] != null) {
              final countryCode =
                  airline['countryCode'].toString().toUpperCase();
              final continent = _getContinentFromCountryCode(countryCode);
              if (!sortedBookmarks.containsKey(continent)) {
                sortedBookmarks[continent] = [];
              }
              sortedBookmarks[continent]!.add(airline);
            }
          }

          setState(() {
            _bookmarksItems = sortedBookmarks;
          });
        }
      }
    } catch (e) {
      print('Error loading bookmarks: $e');
      // Handle the error appropriately, e.g., show a snackbar to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _bookmarksItems.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  print('🎈🎈🎈${entry.value}');
                  Navigator.pushNamed(context, AppRoutes.bookmarkprofilescreen,
                      arguments: {
                        'continentAirlineList': entry.value,
                        'continent': entry.key,
                        'countryNumber': entry.value.length
                      });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ' ${entry.key} (${entry.value.length})',
                      style: TextStyle(
                          fontFamily: 'Clash Grotesk',
                          fontSize: 20,
                          color: Color(0xFF181818),
                          fontWeight: FontWeight.w600),
                    ),
                    Image.asset(
                      'assets/icons/rightarrow.png',
                      width: 40,
                      height: 40,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
