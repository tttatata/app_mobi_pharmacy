import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/images/t_circular_image.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/ratings/rating_indicator.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product_Reviews.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  final Reviews_Product review;

  const UserReviewCard({super.key, required this.review});
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TCircularImage(
                  image: review.user['avatar']?.isEmpty ?? true
                      ? TImages.user
                      : review.user['avatar']['url'].toString(),
                  isNetworkImage:
                      review.user['avatar']?.isEmpty ?? true ? false : true,
                  height: 50,
                  width: 50,
                  padding: 5,
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text(
                  review.user['name'],
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        //review
        Row(
          children: [
            TRatingBarIndicator(rating: review.rating!.toDouble()),
            SizedBox(width: TSizes.spaceBtwItems),
            Text(DateFormat('HH:mm dd/MM/yyyy').format(review.createdAt!),
                style: Theme.of(context).textTheme.bodyMedium)
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Align(
          alignment: Alignment.centerLeft,
          child: ReadMoreText(
            review.comment.toString(),
            trimMode: TrimMode.Line,
            trimLines: 2,
            colorClickableText: Colors.pink,
            trimCollapsedText: '...Xem thêm',
            trimExpandedText: ' show less',
            moreStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: TColors.primary,
            ),
            lessStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: TColors.primary,
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// company review

        const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }
}
