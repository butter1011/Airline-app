import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ManualInputScreen extends StatelessWidget {
  const ManualInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Navigator.pop(context), // Navigate back when pressed
        ),
        centerTitle: true,
        title: Text(
          'Input Manually',
          style: AppStyles.textStyle_16_600,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(color: Colors.black, height: 4.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            _InputCard(
              imagePath: 'assets/icons/input_airport.png',
              title: 'Airport Input',
              onClick: () =>
                  Navigator.pushNamed(context, AppRoutes.airportinput),
            ),
            const SizedBox(height: 23),
            _buildOrDivider(),
            _InputCard(
              imagePath: 'assets/icons/input_flight.png',
              title: 'Flight Input',
              onClick: () => Navigator.pushNamed(
                  context,
                  AppRoutes
                      .flightinput), // Add an empty function as onClick is required
            ),
          ],
        ),
      ),
    );
  }
}

class _InputCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final VoidCallback onClick;

  const _InputCard(
      {required this.imagePath, required this.title, required this.onClick});

  @override
  __InputCardState createState() => __InputCardState();
}

class __InputCardState extends State<_InputCard> {
  bool _isClicked = false;

  void _onTap() {
    setState(() {
      _isClicked = true;
    });

    // Reset the state after the animation duration
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _isClicked = false;
      });
      widget.onClick();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(top: 24),
        height: MediaQuery.of(context).size.height * 0.34,
        decoration: BoxDecoration(
          border: AppStyles.cardDecoration.border,
          color: _isClicked
              ? AppStyles.mainColor
              : Colors.white, // Change color on click
          borderRadius: BorderRadius.circular(24), // Match your card decoration
// Keep the original shadow if needed
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(widget.imagePath),
              const SizedBox(height: 8),
              Text(
                widget.title,
                style: AppStyles.textStyle_24_600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildOrDivider() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(child: Divider(color: Colors.black, thickness: 3)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          "Or",
          style:
              AppStyles.textStyle_13_600.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      Expanded(child: Divider(color: Colors.black, thickness: 3)),
    ],
  );
}
