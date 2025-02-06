import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class NavPageButton extends StatefulWidget {
  const NavPageButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
  });

  final String text;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  State<NavPageButton> createState() => _NavPageButtonState();
}

class _NavPageButtonState extends State<NavPageButton>
    with SingleTickerProviderStateMixin {
  bool _isSelected = false;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );
  late final Animation<double> _scaleAnimation =
      Tween<double>(begin: 1.0, end: 0.95).animate(
    CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
      if (_isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: ElevatedButton(
            onPressed: _toggleSelection,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
                side: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.text == "Go back") ...[
                  Icon(
                    widget.icon,
                    size: 20,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    widget.text,
                    style: AppStyles.textStyle_15_600.copyWith(
                      letterSpacing: 0.5,
                    ),
                  ),
                ] else ...[
                  Text(
                    widget.text,
                    style: AppStyles.textStyle_15_600.copyWith(
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    widget.icon,
                    size: 20,
                    color: Colors.black,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}