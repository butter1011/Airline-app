import 'package:flutter/material.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_page_button.dart';

class BuildNavigationButtonsWidget extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onNextPressed;
  final String backButtonText;
  final String nextButtonText;

  const BuildNavigationButtonsWidget({
    super.key,
    required this.onBackPressed,
    required this.onNextPressed,
    this.backButtonText = 'Go back',
    this.nextButtonText = 'Next',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(75),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: NavPageButton(
                  text: backButtonText,
                  onPressed: onBackPressed,
                  icon: Icons.arrow_back,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: NavPageButton(
                  text: nextButtonText,
                  onPressed: onNextPressed,
                  icon: Icons.arrow_forward,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
