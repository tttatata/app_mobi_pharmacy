import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/layouts/grid_layout.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/ratings/rating_indicator.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product_Reviews.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_reviews/widgets/user_review_cart.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';

class ProductReviewsScreen extends StatelessWidget {
  final List<Reviews_Product>? reviews;

  const ProductReviewsScreen({super.key, required this.reviews});
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
    ;
// Kiểm tra xem có đánh giá nào không
    if (reviews == null || reviews!.isEmpty) {
      // Không có đánh giá, hiển thị thông báo
      return Scaffold(
        appBar: const TAppBar(
          title: Text('Reviews & Ratings'),
          showBackArrow: true,
        ),
        body: Center(
          child: Text(
            'Chưa có đánh giá nào.',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      );
    }

    // Có đánh giá, hiển thị danh sách đánh giá
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: TSizes.spaceBtwItems),
              ToverallProductRating(
                reviews: reviews,
              ),
              TRatingBarIndicator(
                rating: averageRating,
              ),
              Text(
                totalReviews.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              // Tạo danh sách đánh giá
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 650,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: reviews!.length,
                    itemBuilder: (_, index) {
                      return UserReviewCard(review: reviews![index]);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
