import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class FlightInputScreen extends StatelessWidget {
  const FlightInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Navigator.pop(context), // Navigate back when pressed
        ),
        centerTitle: true,
        title: Text(
          'Input Manually',
          style: AppStyles.mainTextStyle,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(color: Colors.black, height: 4.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(children: [
          
        ],),
      ),
    );
  }
}
