import 'package:dropdown_search/dropdown_search.dart';

import 'package:flutter/material.dart';

class ExampleScreen extends StatelessWidget {
  final dropDownKey = GlobalKey<DropdownSearchState>();

  ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('examples mode')),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        children: [
          Text("We are now living on what some people call the digital age, meaning that computer have become on essential")
        ],
      ),
    );
  }
}
