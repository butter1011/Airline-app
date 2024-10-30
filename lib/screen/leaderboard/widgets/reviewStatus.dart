import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ReviewStatus extends StatefulWidget {
  const ReviewStatus({super.key, required this.reviewStatus});
  final bool reviewStatus;

  @override
  State<ReviewStatus> createState() => _ReviewStatusState();
}

class _ReviewStatusState extends State<ReviewStatus> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        // Diameter of the circular avatar
        height: 24, // Diameter of the circular avatar
        decoration: BoxDecoration(
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(30),
          color: Colors.white, // Background color
          border: Border.all(width: 2, color: Colors.black), // Border color
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Text('9/10 from 382 reviews', style: AppStyles.textStyle_14_600),
              const SizedBox(
                width: 3,
              ),
              widget.reviewStatus
                  ? Image.asset('assets/icons/success.png')
                  : Image.asset('assets/icons/danger.png')
            ],
          ),
        ),
      ),
    );
  }
}
