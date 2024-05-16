import 'package:app_mobi_pharmacy/features/authentication/models/Product_Reviews.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_reviews/widgets/progress_indicator_and_rating.dart';
import 'package:flutter/material.dart';

class ToverallProductRating extends StatelessWidget {
  final List<Reviews_Product>? reviews;

  const ToverallProductRating({
    super.key,
    this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    double sumRatings = 0;
    int totalReviews = 0;
    Map<int, int> ratingsCount = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};

    // Tính toán đánh giá trung bình
    double averageRating = 0; // Khai báo biến ở đây để có thể sử dụng sau này

    if (reviews != null && reviews!.isNotEmpty) {
      reviews!.forEach((review) {
        sumRatings += review.rating ?? 0;
        totalReviews++;
        if (review.rating != null) {
          ratingsCount[review.rating!] =
              (ratingsCount[review.rating!] ?? 0) + 1;
        }
      });

      if (totalReviews > 0) {
        averageRating = sumRatings / totalReviews;
      }
    } // Tính toán tỷ lệ phần trăm cho mỗi điểm đánh giá
    Map<int, double> ratingsPercentage = {};
    ratingsCount.forEach((key, value) {
      ratingsPercentage[key] = (value / totalReviews) * 100;
    });
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            averageRating.toStringAsFixed(1),
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Expanded(
          flex: 7,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              // Sử dụng constraints.maxWidth để tính toán chiều rộng
              double barWidth = reviews!.length.toDouble();

              return Column(
                children: [
                  TRatingProgressIndicator(
                    text: '5',
                    value: ratingsPercentage[5] ?? 0,
                    width: barWidth,
                  ),
                  TRatingProgressIndicator(
                    text: '4',
                    value: ratingsPercentage[4] ?? 0,
                    width: barWidth,
                  ),
                  TRatingProgressIndicator(
                    text: '3',
                    value: ratingsPercentage[3] ?? 0,
                    width: barWidth,
                  ),
                  TRatingProgressIndicator(
                    text: '2',
                    value: ratingsPercentage[2] ?? 0,
                    width: barWidth,
                  ),
                  TRatingProgressIndicator(
                    text: '1',
                    value: ratingsPercentage[1] ?? 0,
                    width: barWidth,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
