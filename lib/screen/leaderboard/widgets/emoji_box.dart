import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmojiBox {
  // Update EmojiBox.showCustomDialog to return the selected index
  static Future<int?> showCustomDialog(
      BuildContext context, RenderBox buttonRenderBox) async {
    int? selectedIndex;

    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset position =
        buttonRenderBox.localToGlobal(Offset.zero, ancestor: overlay);
    final Size screenSize = MediaQuery.of(context).size;

    // Calculate initial position
    double left = position.dx -
        (280 - buttonRenderBox.size.width) / 2; // Center align with button
    double top = position.dy + buttonRenderBox.size.height; // Add small gap

    // Adjust horizontal position if box goes outside screen
    if (left + 280 > screenSize.width) {
      left = screenSize.width - 280; // Add padding from right edge
    }
    if (left < 16) {
      left = 16; // Add padding from left edge
    }

    // Adjust vertical position if box goes below screen
    if (top < screenSize.height) {
      top = top - 100; // Show above the button
      if (top < 0) top = top + 80;
    }

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
              behavior: HitTestBehavior.translucent,
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
                          selectedIndex = index;
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/emoji_${index + 1}.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text('You reacted to this post'),
                                ],
                              ),
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
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

    return selectedIndex;
  }
}

class _EmojiPickerDialog extends StatefulWidget {
  @override
  __EmojiPickerDialogState createState() => __EmojiPickerDialogState();
}

class __EmojiPickerDialogState extends State<_EmojiPickerDialog> {
  List<double> scales = List.generate(7, (_) => 1.0);

  void _onEmojiPressed(int index) {
    setState(() {
      scales[index] = 1.5;
    });

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        scales[index] = 1.0;
      });
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
                onTap: () => _onEmojiPressed(index),
                child: AnimatedScale(
                  scale: scales[index],
                  duration: Duration(milliseconds: 500),
                  child: IconButton(
                    onPressed: () {
                      _onEmojiPressed(index);
                    },
                    icon: Image.asset(
                      'assets/icons/emoji_${index + 1}.png',
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
