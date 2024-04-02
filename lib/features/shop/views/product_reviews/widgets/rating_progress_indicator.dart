import 'package:app_mobi_pharmacy/features/shop/views/product_reviews/widgets/progress_indicator_and_rating.dart';
import 'package:flutter/material.dart';

class ToverallProductRating extends StatelessWidget {
  const ToverallProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '4.0 ',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        const Expanded(
          flex: 7,
          child: Column(
            children: [
              TRatingProgressIndicator(
                text: '5',
                value: 1,
              ),
              TRatingProgressIndicator(
                text: '4',
                value: 1,
              ),
              TRatingProgressIndicator(
                text: '3',
                value: 1,
              ),
              TRatingProgressIndicator(
                text: '2',
                value: 1,
              ),
              TRatingProgressIndicator(
                text: '1',
                value: 1,
              ),
            ],
          ),
        )
      ],
    );
  }
}
