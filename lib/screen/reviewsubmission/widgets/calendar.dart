import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class CalendarExample extends StatefulWidget {
  @override
  _CalendarExampleState createState() => _CalendarExampleState();
}

class _CalendarExampleState extends State<CalendarExample> {
  dynamic _startDate = ''; // Initialize with an empty string
  dynamic _endDate = ''; // Initialize with an empty string
  final DateRangePickerController _controller = DateRangePickerController();

  @override
  void initState() {
    super.initState();
    final DateTime today = DateTime.now();
    // Set initial dates
    _startDate = DateFormat('dd, MMMM yyyy').format(today);
    _endDate = DateFormat('dd, MMMM yyyy').format(today.add(Duration(days: 3)));
    _controller.selectedRange =
        PickerDateRange(today, today.add(Duration(days: 3)));
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      // Update start and end dates based on selection
      _startDate = DateFormat('dd, MMMM yyyy').format(args.value.startDate);
      _endDate = DateFormat('dd, MMMM yyyy')
          .format(args.value.endDate ?? args.value.startDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Departure Date",
          style: AppStyles.litteBlackTextStyle.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 8),
        Container(
          height: 324,
          padding: EdgeInsets.all(16),
          decoration: AppStyles.cardDecoration,
          child: SfDateRangePicker(
            backgroundColor: Colors.white,
            rangeSelectionColor: Colors.black.withOpacity(0.3),
            headerHeight: 56,
            selectionRadius: 56,
            selectionTextStyle: TextStyle(color: Colors.black),
            // selectionShape: DateRangePickerSelectionShape.rectangle,
            startRangeSelectionColor: AppStyles.mainColor,
            endRangeSelectionColor: AppStyles.mainColor,
            headerStyle: DateRangePickerHeaderStyle(
                textAlign: TextAlign.center,
                backgroundColor: Colors.white,
                textStyle: AppStyles.cardTextStyle),
            controller: _controller,
            selectionMode: DateRangePickerSelectionMode.range,
            onSelectionChanged: selectionChanged,
          ),
        ),
      ],
    );
  }
}
