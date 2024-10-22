import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: AppStyles.avatarDecoration,
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/avatar1.png'),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Benedict Cumberbatch',
                    style: AppStyles.itemButtonTextStyle,
                  ),
                  Text(
                    'Rated 9/10 on 16.09.24',
                    style: AppStyles.normalTextStyle,
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 18,
          ),
          VerifiedButton(),
          SizedBox(
            height: 16,
          ),
          ClipRRect(
            borderRadius:
                BorderRadius.circular(20.0), // Set your desired border radius
            child: Container(
              height: 260.0, // Set the height to 300 pixels
              child: Image.asset(
                'assets/images/Ethiopian/Ethiopian.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 11,
          ),
          Text(
            "Loved the adjustable headrest and soft cushioning. Made the trip very relaxing",
            style: AppStyles.normalTextStyle,
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/icons/telegram_black.png'),
                  color: Colors.black),
              Row(
                children: [
                  Icon(Icons.thumb_up_outlined),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "9998",
                    style: AppStyles.itemButtonTextStyle,
                  )
                ],
              )
            ],
          ),
          Divider(
            thickness: 2,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}

class VerifiedButton extends StatelessWidget {
  const VerifiedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      height: 24,
      decoration: BoxDecoration(
          color: const Color(0xff181818),
          borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text("Verified",
            style: GoogleFonts.getFont("Schibsted Grotesk",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.5,
                color: Colors.white)),
      ),
    );
  }
}
