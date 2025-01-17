import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class SubcategoryButtonWidget extends StatelessWidget {
  final String labelName;
  final VoidCallback onTap;
  final bool isSelected;
  final String imagePath;

  const SubcategoryButtonWidget(
      {super.key,
      required this.labelName,
      required this.onTap,
      required this.isSelected,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 126,
        width: MediaQuery.of(context).size.width * 0.41,
        decoration: AppStyles.cardDecoration.copyWith(
          color: isSelected ? AppStyles.mainColor : Colors.white,
        ),
        padding: EdgeInsets.only(bottom: 10, top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: AppStyles.cardDecoration.copyWith(
                color: isSelected ? Colors.white : AppStyles.mainColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(imagePath, height: 40),
            ),
            SizedBox(height: 6),
            Text(
              labelName,
              textAlign: TextAlign.center,
              style: AppStyles.textStyle_14_600,
            ),
          ],
        ),
      ),
    );
  }
}
