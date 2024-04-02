import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/ratings/rating_indicator.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_reviews/widgets/user_review_cart.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              const Text("aaaaaaa"),
              const SizedBox(height: TSizes.spaceBtwItems),
              const ToverallProductRating(),
              const TRatingBarIndicator(
                rating: 3.2,
              ),
              Text(
                '12.622',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),

              /// user reviews list
            ],
          ),
        ),
      ),
    );
  }
}
