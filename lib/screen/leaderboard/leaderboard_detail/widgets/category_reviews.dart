import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryReviews extends StatelessWidget {
  const CategoryReviews({super.key, required this.review});

  final Map review;

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
                  backgroundImage:
                      AssetImage('assets/images/${review['Avatar']}'),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review['Name'],
                    style: AppStyles.itemButtonTextStyle,
                  ),
                  Text(
                    review['Date'],
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
          review['Images'] != null && review['Images'].isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(
                      20.0), // Set your desired border radius
                  child: Container(
                    height: 260.0, // Set the height to 300 pixels
                    child: Image.asset(
                      'assets/images/${review['Images'][0]}',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Text(""),
          SizedBox(
            height: 11,
          ),
          Text(
            review['Content'],
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

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
