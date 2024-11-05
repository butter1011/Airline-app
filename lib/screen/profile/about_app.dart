import 'package:airline_app/utils/app_routes.dart';

import 'package:airline_app/utils/app_styles.dart';

import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.profilescreen);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 24,
          ),
        ),
        title: Text(
          "About the app",
          textAlign: TextAlign.center,
          style: AppStyles.textStyle_16_600,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            thickness: 4,
            color: Colors.black,
          ),
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Headline goes here',
                  style: AppStyles.textStyle_14_400,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'The secondary next goes here, creating the\n second row next',
                  style: AppStyles.textStyle_14_400,
                  maxLines: null,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
