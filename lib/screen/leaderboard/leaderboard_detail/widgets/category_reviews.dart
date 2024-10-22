import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CategoryReviews extends StatelessWidget {
  const CategoryReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Seat Confort Reviews',
                style: AppStyles.subtitleTextStyle,
              ),
              IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/icons/switch.png'))
            ],
          ),
        ],
      ),
    );
  }
}
