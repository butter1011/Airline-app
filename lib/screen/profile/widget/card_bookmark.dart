import 'package:airline_app/screen/profile/utils/book_mark_json.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:flutter/material.dart';

class CardBookMark extends StatelessWidget {
  const CardBookMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: bookMark.map((bookmarkvalue) {
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
                      bookmarkvalue['countryName'],
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

//////////////////////////////////////////////////////////////////////////////////////////////////
