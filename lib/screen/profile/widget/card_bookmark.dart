import 'dart:convert';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

// Define a FutureProvider to fetch the bookmark data

class CardBookMark extends ConsumerStatefulWidget {
  const CardBookMark({Key? key}) : super(key: key);

  @override
  ConsumerState<CardBookMark> createState() => _CardBookMarkState();
}

class _CardBookMarkState extends ConsumerState<CardBookMark> {
  List<Map<String, dynamic>> bookmarks = [];
  @override
  void initState() {
    super.initState();
    _profileBookmark();
  }

  void _profileBookmark() async {
    final userData = ref.read(userDataProvider);
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/api/v1/airline/profile/review'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        '_id': userData?['userData']['_id'],
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData is Map<String, dynamic> &&
          responseData['formattedReviews'] is List) {
        final formattedReviews = responseData['formattedReviews'] as List;

        setState(() {
          bookmarks = List<Map<String, dynamic>>.from(
              formattedReviews.map((item) => Map<String, dynamic>.from(item)));
        });
        print('💚💚💚💚💚$bookmarks');
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load bookmarks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: bookmarks.map((bookmarkvalue) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.bookmarkprofilescreen,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${bookmarkvalue['continent']} (${bookmarkvalue['data'].length})',
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
