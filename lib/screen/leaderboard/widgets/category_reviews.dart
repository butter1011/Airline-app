import 'package:airline_app/screen/leaderboard/widgets/emoji_box.dart';
import 'package:airline_app/screen/leaderboard/widgets/share_to_social.dart';
import 'package:airline_app/utils/app_routes.dart';
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
                style: AppStyles.textStyle_18_600,
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
                decoration: AppStyles.circleDecoration,
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
                    style: AppStyles.textStyle_14_600,
                  ),
                  Text(
                    review['Date'],
                    style: AppStyles.textStyle_14_400,
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
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.mediafullscreen,
                          arguments: review);
                    },
                    child: Container(
                      height: 260.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image:
                            AssetImage('assets/images/${review['Images'][0]}'),
                        fit: BoxFit.cover,
                      )), // Set the height to 300 pixels
                    ),
                  ),
                )
              : Text(""),
          SizedBox(
            height: 11,
          ),
          Text(
            review['Content'],
            style: AppStyles.textStyle_14_400,
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () async {
                    await BottomSheetHelper.showScoreBottomSheet(
                      context,
                    );
                  },
                  icon: Image.asset('assets/icons/share.png'),
                  color: Colors.black),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      await EmojiBox.showCustomDialog(
                          context); // Pass context here
                    },
                    icon: Icon(Icons.thumb_up_outlined),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "9998",
                    style: AppStyles.textStyle_14_600,
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
