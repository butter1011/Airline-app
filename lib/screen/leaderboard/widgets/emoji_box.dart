import 'package:flutter/material.dart';

class EmojiBox {
  static Future<void> showCustomDialog(BuildContext context) async {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (context, animation1, animation2) {
        return _EmojiPickerDialog();
      },
    );
  }
}

class _EmojiPickerDialog extends StatefulWidget {
  @override
  __EmojiPickerDialogState createState() => __EmojiPickerDialogState();
}

class __EmojiPickerDialogState extends State<_EmojiPickerDialog> {
  List<double> scales = List.generate(7, (_) => 1.0); // Scale for each emoji

  void _onEmojiPressed(int index) {
    setState(() {
      scales[index] = 1.5; // Scale up
    });

    // Reset scale back to normal after a short duration
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        scales[index] = 1.0; // Scale back down
      });

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 70,
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Color(0xff8B8B8B)),
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(6, (index) {
              return GestureDetector(
                onTap: () => _onEmojiPressed(index), // Handle emoji press
                child: AnimatedScale(
                  scale: scales[index], // Get scale for this emoji
                  duration: Duration(milliseconds: 500), // Animation duration
                  child: IconButton(
                    onPressed: () {
                      _onEmojiPressed(index);
                    }, // You can add your logic here
                    icon: Image.asset(
                      'assets/icons/emoji_${index + 1}.png', // Adjust based on your assets
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
