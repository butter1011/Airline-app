import 'package:airline_app/screen/leaderboard/widgets/airport_list.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({
    super.key,
  });

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  String? continentName;
  int? countryNumber;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    final List<Map<String, dynamic>> leaderBoardList =
        args['continentAirlineList'];

    setState(() {
      continentName = args['continent'];
      countryNumber = args['countryNumber'];
    });

    int expandedItems = 5;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            _AirportListSection(
              leaderBoardList: leaderBoardList,
              expandedItems: expandedItems,
              onExpand: () {
                setState(() {
                  expandedItems += 5;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
          AppLocalizations.of(context)
              .translate('$continentName ($countryNumber)'),
          style: AppStyles.textStyle_16_600.copyWith(color: Colors.black)),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(4.0),
        child: Container(color: Colors.black, height: 4.0),
      ),
    );
  }
}

class _AirportListSection extends StatelessWidget {
  final List<Map<String, dynamic>> leaderBoardList;
  final int expandedItems;
  final VoidCallback onExpand;

  const _AirportListSection({
    required this.leaderBoardList,
    required this.expandedItems,
    required this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: leaderBoardList.asMap().entries.map((entry) {
            int index = entry.key;

            Map<String, dynamic> singleAirport = entry.value;
            if (index < expandedItems) {
              return AirportList(
                airportData: {
                  ...singleAirport,
                  'index': index,
                },
              );
            }
            return const SizedBox.shrink();
          }).toList(),
        ),
        SizedBox(height: 19),
        if (expandedItems < leaderBoardList.length)
          Center(
            child: InkWell(
              onTap: onExpand,
              child: IntrinsicWidth(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context).translate('Expand more'),
                        style:
                            AppStyles.textStyle_18_600.copyWith(fontSize: 15)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_downward),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
