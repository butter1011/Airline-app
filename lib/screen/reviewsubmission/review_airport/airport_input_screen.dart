import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/aviation_info_provider.dart';

import 'package:airline_app/screen/reviewsubmission/widgets/calendar.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/toggle_btn.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirportInputScreen extends ConsumerStatefulWidget {
  AirportInputScreen({super.key});

  @override
  ConsumerState<AirportInputScreen> createState() => _AirportInputScreenState();
}

class _AirportInputScreenState extends ConsumerState<AirportInputScreen> {
  @override
  Widget build(BuildContext context) {
    final flightInputState = ref.watch(aviationInfoProvider);
    final airlineAirportState = ref.watch(airlineAirportProvider);
    List<dynamic> airlineData = airlineAirportState.airlineData;
    List<dynamic> airportData = airlineAirportState.airportData;
    bool isValid = ref.read(aviationInfoProvider.notifier).isAirportValid();
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, AppRoutes.manualinput);
        return false;
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView(
            children: [
              const SizedBox(height: 19),
              _buildInfoText(
                  "Add your flight schedule below or sync your calendar/email"),
              const SizedBox(height: 22),
              _buildSectionTitle("Synchronize (Recommended):"),
              const SizedBox(height: 13),
              _buildSyncButtons(),
              const SizedBox(height: 18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDropdownButton(
                    labelText: "Airline",
                    hintText: "your Airline",
                    onChanged: (value) => ref
                        .read(aviationInfoProvider.notifier)
                        .updateAirline(value),
                    airlineNames: airlineData,
                  ),
                  const SizedBox(height: 18),
                  CustomDropdownButton(
                    labelText: "Airport",
                    hintText: "your Airport",
                    onChanged: (value) => ref
                        .read(aviationInfoProvider.notifier)
                        .updateAirport(value),
                    airlineNames: airportData,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              CalendarWidget(),
              const SizedBox(height: 18),
              _buildTravelClassSelection(ref),
              const SizedBox(height: 18),
              _buildAdditionalSyncOptions(ref),
              const SizedBox(height: 16),
            ],
          ),
        ),
        bottomNavigationBar:
            _buildBottomNavigationBar(context, flightInputState, isValid),
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
      title: Text('Airport Input',
          style: AppStyles.textStyle_16_600.copyWith(color: Colors.black)),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(4.0),
        child: Container(color: Colors.black, height: 4.0),
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: AppStyles.textStyle_15_400,
      textAlign: TextAlign.start,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppStyles.textStyle_14_600,
    );
  }

  Widget _buildSyncButtons() {
    return Row(
      children: [
        Expanded(child: _buildSyncButton("E-mail Sync")),
        const SizedBox(width: 8),
        Expanded(child: _buildSyncButton("Calendar Sync")),
      ],
    );
  }

  Widget _buildSyncButton(String label) {
    return Container(
      height: 40,
      decoration: AppStyles.cardDecoration,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppStyles.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          // Add functionality for syncing here
          // Placeholder for functionality
        },
        child: Center(
          child: Text(label, style: AppStyles.textStyle_14_600),
        ),
      ),
    );
  }

  Widget _buildTravelClassSelection(WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Pick your class of travel:", style: AppStyles.textStyle_14_600),
        const SizedBox(height: 13),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ToggleBtn(
              buttonText: "Business",
              height: 40,
              isSelected:
                  ref.watch(aviationInfoProvider).selectedClassOfTravel ==
                      "Business",
              onSelected: () => ref
                  .read(aviationInfoProvider.notifier)
                  .updateClassOfTravel("Business"),
            ),
            ToggleBtn(
              buttonText: "Premium Economy",
              height: 40,
              isSelected:
                  ref.watch(aviationInfoProvider).selectedClassOfTravel ==
                      "Premium Economy",
              onSelected: () => ref
                  .read(aviationInfoProvider.notifier)
                  .updateClassOfTravel("Premium Economy"),
            ),
            ToggleBtn(
              buttonText: "Economy",
              height: 40,
              isSelected:
                  ref.watch(aviationInfoProvider).selectedClassOfTravel ==
                      "Economy",
              onSelected: () => ref
                  .read(aviationInfoProvider.notifier)
                  .updateClassOfTravel("Economy"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAdditionalSyncOptions(WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Synchronize (Recommended):", style: AppStyles.textStyle_14_600),
        const SizedBox(height: 13),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ToggleBtn(
              buttonText: "Boarding Passes",
              height: 40,
              isSelected: ref.watch(aviationInfoProvider).selectedSynchronize ==
                  "Boarding Passes",
              onSelected: () => ref
                  .read(aviationInfoProvider.notifier)
                  .updateSynchronize("Boarding Passes"),
            ),
            ToggleBtn(
              buttonText: "Geolocation",
              height: 40,
              isSelected: ref.watch(aviationInfoProvider).selectedSynchronize ==
                  "Geolocation",
              onSelected: () => ref
                  .read(aviationInfoProvider.notifier)
                  .updateSynchronize("Geolocation"),
            ),
            ToggleBtn(
              buttonText: "E-Tickets",
              height: 40,
              isSelected: ref.watch(aviationInfoProvider).selectedSynchronize ==
                  "E-Tickets",
              onSelected: () => ref
                  .read(aviationInfoProvider.notifier)
                  .updateSynchronize("E-Tickets"),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(context, flightInputState, isValid) {
    return Column(
      mainAxisSize:
          MainAxisSize.min, // Ensures it takes only the required space
      children: [
        Container(
          height: 2, // Height of the black line
          color: Colors.black, // Color of the line
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: InkWell(
            onTap: () {
              if (isValid) {
                Navigator.pushNamed(
                    context, AppRoutes.questionfirstscreenforairport);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xFFFC8B8B),
                    content: Text(
                      "Please fill all the fields",
                      style: AppStyles.textStyle_15_600,
                    ),
                  ),
                );
              }
            },
            child: Container(
              height: 56,
              decoration: AppStyles.buttonDecoration.copyWith(
                borderRadius: BorderRadius.circular(28),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Next", style: AppStyles.textStyle_15_600),
                    Icon(Icons.arrow_forward_outlined)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.onChanged,
      required this.airlineNames});

  final String labelText;
  final String hintText;
  final ValueChanged<String> onChanged;
  final List<dynamic> airlineNames;

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  final TextEditingController textEditingController = TextEditingController();
  String? selectedValue;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText, style: AppStyles.textStyle_14_600),
        const SizedBox(height: 8),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text('Select ${widget.hintText}',
                style: AppStyles.textStyle_15_400
                    .copyWith(color: Color(0xFF38433E))),
            items: widget.airlineNames
                .map((item) => DropdownMenuItem<String>(
                      value: item['name'],
                      child: Text(
                        item['name'],
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              var id = widget.airlineNames
                  .where((element) => element['name'] == value)
                  .first['_id'];

              setState(() {
                selectedValue = value;
              });
              widget.onChanged(id ?? ""); // Call the callback
            },
            buttonStyleData: ButtonStyleData(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: AppStyles.cardDecoration,
              height: 48,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              decoration: AppStyles.cardDecoration,
            ),
            menuItemStyleData: const MenuItemStyleData(height: 40),
            dropdownSearchData: DropdownSearchData(
              searchController: textEditingController,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Container(
                height: 50,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    hintText: "Select ${widget.hintText}",
                    hintStyle: AppStyles.textStyle_15_400
                        .copyWith(color: Color(0xFF38433E)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return item.value.toString().contains(searchValue);
              },
            ),
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                textEditingController.clear();
              }
            },
            iconStyleData: IconStyleData(icon: Icon(Icons.expand_more)),
          ),
        )
      ],
    );
  }
}
