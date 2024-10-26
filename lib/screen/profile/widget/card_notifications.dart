import 'package:airline_app/utils/app_routes.dart';
import 'package:flutter/material.dart';

class CardNotifications extends StatelessWidget {
  const CardNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.cardnotificationscreen,
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Notifications (2)',
              style: TextStyle(
                  fontFamily: 'Clash Grotesk',
                  fontSize: 20,
                  color: Color(0xFF181818),
                  fontWeight: FontWeight.w600),
            ),
            Image.asset(
              'assets/icons/rightarrow.png',
              width: 40,
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////
