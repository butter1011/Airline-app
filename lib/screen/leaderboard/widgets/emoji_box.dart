import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmojiBox {
  static Future<void> showCustomDialog(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset position = button.localToGlobal(Offset.zero);

    // Position the box below the thumb up button
    double left = position.dx;
    double top =
        position.dy + button.size.height - 85; // Add offset below button

    // Ensure the box stays within screen bounds
    final Size screenSize = MediaQuery.of(context).size;
    if (left < 0) left = 10;
    if (left + 280 > screenSize.width) left = screenSize.width - 290;

    await showDialog(
      context: context,
      barrierColor: Colors.transparent,
      useSafeArea: false,
      builder: (BuildContext context) {
        return Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                color: Colors.transparent,
              ),
            ),
            Positioned(
              left: left,
              top: top,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  height: 40,
                  width: 280,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Color(0xff8B8B8B)),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SvgPicture.asset(
                            'assets/icons/emoji_${index + 1}.svg',
                            width: 30,
                            height: 30,
                            placeholderBuilder: (context) {
                              return Icon(Icons.sentiment_satisfied_alt,
                                  size: 30);
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        );
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
