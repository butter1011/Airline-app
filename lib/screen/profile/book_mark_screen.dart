import 'package:airline_app/screen/profile/profile_screen.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airline_app/provider/bookmark_provider.dart';

class BookMarkScreen extends ConsumerWidget {
  const BookMarkScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarksList = ref.watch(bookmarkDataProvider);
    print("✔✔💖✅💎$bookmarksList");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          '${bookmarksList[0]["continent"]}',
          style: AppStyles.textStyle_16_600,
        ),
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/icons/left.png',
              width: 24,
              height: 24,
            ),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ProfileScreen();
            }));
          },
        ),
      ),
      body: Column(
        children: [
          Divider(
            thickness: 4,
            color: Colors.black,
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: bookmarksList.map((bookmark) {
                    return CreviewList(
                      country: bookmark['airline'],
                      reviewStatus: bookmark['isAirline'],
                    );
                  }).toList(),
                ),
              )
            ],
          )))
        ],
      ),
    );
  }
}

class CreviewList extends StatelessWidget {
  const CreviewList({
    super.key,
    required this.country,
    required this.reviewStatus,
    // required this.index,
    // required this.logo
  });

  final String country;
  final bool reviewStatus;
  // final int index;
  // final String logo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.detailairport);
            // arguments: {'index': index});
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  decoration: AppStyles.circleDecoration,
                  child: CircleAvatar(
                    radius: 20,
                    // backgroundImage: logo.isNotEmpty
                    //     ? AssetImage('assets/images/$logo')
                    //     : AssetImage('assets/images/logo_empty.png'),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      country,
                      style: AppStyles.textStyle_14_600,
                    ),
                    Text(
                      'Airline',
                      style: AppStyles.textStyle_14_600
                          .copyWith(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 8,
                ),
                // Spacer(), // This will take up all available space between the elements
                // SizedBox(width: 300), // This adds a fixed width of 300 pixels

                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  // Use Expanded to take remaining space
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.end, // Align to the end (right)
                    children: [
                      Row(
                        children: [
                          reviewStatus
                              ? Image.asset('assets/icons/graph_primary.png')
                              : Image.asset('assets/icons/graph_danger.png'),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '',
                                style: AppStyles.textStyle_14_600.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff97a09c),
                                ),
                              ),
                              Text(
                                '+100',
                                style: AppStyles.textStyle_14_600.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff38433e),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          thickness: 2,
          color: AppStyles.littleBlackColor,
        )
      ],
    );
  }
}
