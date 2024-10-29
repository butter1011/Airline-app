import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({super.key, required this.singleFeedback});

  final Map<String, dynamic> singleFeedback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: SizedBox(
        width: 299,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      style: AppStyles.textStyle_14_400,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Text(
                  'Flex with',
                  style: AppStyles.textStyle_14_400,
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
                  style: AppStyles.textStyle_14_400,
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
                height: 189,
                width: 299,
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
              style: AppStyles.textStyle_14_400,
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
          ],
        ),
      ),
    );
  }
}
