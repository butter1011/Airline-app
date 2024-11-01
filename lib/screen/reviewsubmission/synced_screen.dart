import 'package:airline_app/screen/reviewsubmission/widgets/nav_button.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class SyncedScreen extends StatelessWidget {
  const SyncedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 52.2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Navigator.pop(context), // Navigate back when pressed
        ),
        centerTitle: true,
        title: Text(
          'Reviews',
          style: AppStyles.textStyle_16_600,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            color: Colors.black,
            height: 4.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nothing to show here",
              style: AppStyles.textStyle_24_600,
            ),
            Text(
                "Here, you can synchronize your calendar and wallet or manually input the review details.",
                style: AppStyles.textStyle_15_500
                    .copyWith(color: Color(0xff38433E))),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  NavButton(
                    text: "Synchronize",
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.manualinput);
                    },
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  NavButton(
                    text: "Input manually",
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.manualinput);
                    },
                    color: AppStyles.mainColor,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
