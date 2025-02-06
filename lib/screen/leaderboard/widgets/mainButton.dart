import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:airline_app/utils/app_localizations.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: isSelected ? const Color.fromARGB(255, 179, 255, 181) : Colors.grey.shade200,
      
          // boxShadow: const [
          //   BoxShadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 2)
          // ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Center(
            child: Text(
              AppLocalizations.of(context).translate('${text}'),
              style: AppStyles.textStyle_14_600.copyWith(
                color: isSelected ? Colors.grey.shade900:Colors.grey.shade500  ,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
