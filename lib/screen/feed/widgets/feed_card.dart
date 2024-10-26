import 'package:airline_app/screen/leaderboard/leaderboard_detail/widgets/category_reviews.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class FeedCard extends StatelessWidget {
  const FeedCard({super.key, required this.singleFeedback});

  final Map<String, dynamic> singleFeedback;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: AppStyles.avatarDecoration,
              child: CircleAvatar(
                radius: 20,
                backgroundImage:
                    AssetImage('assets/images/${singleFeedback['Avatar']}'),
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
                  style: AppStyles.cardTextStyle,
                ),
                Text(
                  'Rated 9/10 on ${singleFeedback['Date']}',
                  style: AppStyles.normalTextStyle,
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        VerifiedButton(),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Text(
              'Flex with',
              style: AppStyles.normalTextStyle,
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              singleFeedback['Used Airport'],
              style: AppStyles.cardTextStyle,
            )
          ],
        ),
        SizedBox(
          height: 7,
        ),
        Row(
          children: [
            Text(
              'Flex with',
              style: AppStyles.normalTextStyle,
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              singleFeedback['Path'],
              style: AppStyles.cardTextStyle,
            )
          ],
        ),
        SizedBox(
          height: 11,
        ),
        ClipRRect(
          borderRadius:
              BorderRadius.circular(20.0), // Set your desired border radius
          child: Container(
            height: 260,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                'assets/images/${singleFeedback['Image']}',
              ),
              fit: BoxFit.cover,
            )),
          ),
        ),
        SizedBox(
          height: 11,
        ),
        Text(
          singleFeedback['Content'],
          style: AppStyles.normalTextStyle,
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {},
              child: Image.asset('assets/icons/telegram_black.png'),
            ),
            Row(
              children: [
                Icon(Icons.thumb_up_outlined),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "9998",
                  style: AppStyles.cardTextStyle,
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          height: 2,
          color: AppStyles.littleBlackColor,
        )
      ],
    );
  }
}
