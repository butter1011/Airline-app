import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class TypeButton extends StatefulWidget {
  const TypeButton({super.key, required this.text});

  final String text;

  @override
  State<TypeButton> createState() => _TypeButtonButtonState();
}

class _TypeButtonButtonState extends State<TypeButton> {
  late bool _isSelected = false;
  @override
  void initState() {
    super.initState();
    // Initialize _isSelected based on the text
    _isSelected = widget.text == "All"; // Set to true if text is "All"
  }

  // final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
        // Diameter of the circular avatar
        height: 40, // Diameter of the circular avatar
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _isSelected
              ? AppStyles.mainButtonColor
              : AppStyles.whiteColor, // Background color
          border: Border.all(width: 2, color: Colors.black), // Border color
          boxShadow: const [
            BoxShadow(color: Colors.black, offset: Offset(2, 2))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Text(
              widget.text,
              style: AppStyles.cardTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}