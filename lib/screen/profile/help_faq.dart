import 'package:airline_app/screen/profile/utils/help_faqs_json.dart';

import 'package:airline_app/utils/app_styles.dart';

import 'package:flutter/material.dart';

class HelpFaq extends StatelessWidget {
  const HelpFaq({super.key});
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text('Help & FAQs',
          style: AppStyles.textStyle_16_600.copyWith(color: Colors.black)),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(4.0),
        child: Container(color: Colors.black, height: 4.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 24,
          ),
          ...helpAndFaqsList.map((value) {
            return Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(value['topic'], style: AppStyles.textStyle_16_600),
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
                    Expanded(
                      child: Text(
                        value['contents'],
                        style: AppStyles.textStyle_14_400,
                        maxLines: null,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ]);
          }).toList(),
        ],
      ),
    );
  }
}
