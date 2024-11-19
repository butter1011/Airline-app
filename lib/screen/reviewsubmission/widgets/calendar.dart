import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends ConsumerStatefulWidget {
  const CalendarWidget({super.key});

  @override
  ConsumerState<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends ConsumerState<CalendarWidget> {
  late String _startDate;
  late String _endDate;
  final DateRangePickerController _controller = DateRangePickerController();
  late List<String> dateRange;

  @override
  void initState() {
    super.initState();
    final DateTime today = DateTime.now();
    // Set initial dates
    _startDate = DateFormat('dd, MMMM yyyy').format(today);
    _endDate = DateFormat('dd, MMMM yyyy').format(today.add(Duration(days: 3)));
    dateRange = [_startDate, _endDate];
    _controller.selectedRange =
        PickerDateRange(today, today.add(Duration(days: 3)));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(aviationInfoProvider.notifier)
          .updateDateRange([_startDate, _endDate]);
    });
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      // Update start and end dates based on selection
      _startDate = DateFormat('dd, MMMM yyyy').format(args.value.startDate);
      _endDate = DateFormat('dd, MMMM yyyy')
          .format(args.value.endDate ?? args.value.startDate);

      List<String> dateRange = [_startDate, _endDate];
      ref.read(aviationInfoProvider.notifier).updateDateRange(dateRange);

      print("Selected dates👑: ${ref.watch(aviationInfoProvider).dateRange}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Departure Date",
          style: AppStyles.textStyle_14_500.copyWith(color: Colors.black),
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
                textStyle: AppStyles.textStyle_14_600),
            controller: _controller,
            selectionMode: DateRangePickerSelectionMode.range,
            onSelectionChanged: selectionChanged,
          ),
        ),
      ],
    );
  }
}