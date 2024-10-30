import 'package:airline_app/screen/reviewsubmission/widgets/calendar.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/toggle_btn.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlightInputScreen extends StatelessWidget {
  const FlightInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            _buildDropdownSection(),
            const SizedBox(height: 18),
            CalendarExample(),
            const SizedBox(height: 18),
            _buildTravelClassSelection(),
            const SizedBox(height: 18),
            _buildAdditionalSyncOptions(),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
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
      title: Text('Input Manually',
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
          print('$label button pressed'); // Placeholder for functionality
        },
        child: Center(
          child: Text(label, style: AppStyles.textStyle_14_600),
        ),
      ),
    );
  }

  Widget _buildDropdownSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropdownButton(
          labelText: "From",
          hintText: "departure Airport",
        ),
        const SizedBox(height: 18),
        CustomDropdownButton(
          labelText: "To",
          hintText: "destination Airport",
        ),
        const SizedBox(height: 18),
        CustomDropdownButton(labelText: "Airline", hintText: "your Airline"),
      ],
    );
  }

  Widget _buildTravelClassSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Pick your class of travel:", style: AppStyles.textStyle_14_600),
        const SizedBox(height: 13),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ToggleBtn(buttonText: "Business", height: 40),
            ToggleBtn(buttonText: "Premium Economy", height: 40),
            ToggleBtn(buttonText: "Economy", height: 40),
          ],
        ),
      ],
    );
  }

  Widget _buildAdditionalSyncOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Synchronize (Recommended):", style: AppStyles.textStyle_14_600),
        const SizedBox(height: 13),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ToggleBtn(buttonText: "Boarding Passes", height: 40),
            ToggleBtn(buttonText: "Geolocation", height: 40),
            ToggleBtn(buttonText: "E-Tickets", height: 40),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(context) {
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
              Navigator.pushNamed(context, AppRoutes.questionfirstscreen);
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
  final String labelText;
  final String hintText;

  const CustomDropdownButton(
      {super.key, required this.labelText, required this.hintText});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText,
            style: AppStyles.textStyle_14_600), // Use label from constructor
        const SizedBox(height: 8),
        _buildDropdown(),
      ],
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 48,
      decoration: AppStyles.cardDecoration,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text('Select ${widget.hintText}',
              style: AppStyles.textStyle_15_400.copyWith(
                  color:
                      Color(0xff38433E))), // Dynamic hint text based on label
          value: selectedItem,
          onChanged: (String? newValue) {
            setState(() {
              selectedItem = newValue;
            });
          },
          items: ['Option A', 'Option B', 'Option C']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(value),
              ),
            );
          }).toList(),
          isExpanded: true,
          iconSize: 24,
          icon: Icon(Icons.expand_more), // Change icon color if needed
        ),
      ),
    );
  }
}
