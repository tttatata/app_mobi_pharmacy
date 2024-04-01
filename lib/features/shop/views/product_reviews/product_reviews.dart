import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/ratings/rating_indicator.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_reviews/widgets/progress_indicator_and_rating.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_reviews/widgets/user_review_cart.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/device/device_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("aaaaaaa"),
              const SizedBox(height: TSizes.spaceBtwItems),
              ToverallProductRating(),
              TRatingBarIndicator(
                rating: 3.2,
              ),
              Text(
                '12.622',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),

              /// user reviews list
            ],
          ),
        ),
      ),
    );
  }
}
