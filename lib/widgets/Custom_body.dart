import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:next_academy/widgets/customText.dart';
class CustomBody extends StatelessWidget {
  const CustomBody({Key? key, required this.body}) : super(key: key);
    final String body;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: RatingBar.builder(
              itemSize: 20,
              initialRating: 4,
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 0.0005),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ),
          SizedBox(width: 10,),
          Expanded(flex:2,child: CustomText(text: body)),

        ],
      ),
    );
  }
}
