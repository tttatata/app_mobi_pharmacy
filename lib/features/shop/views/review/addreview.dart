import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/images/t_rounded_image.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/ratings/rating_indicator.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_price_text.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_title_text.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/section_heading.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/review_controller.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddProductReviewsScreen extends StatefulWidget {
  final Product productInfo;
  const AddProductReviewsScreen({super.key, required this.productInfo});

  @override
  _AddProductReviewsScreenState createState() =>
      _AddProductReviewsScreenState();
}

class _AddProductReviewsScreenState extends State<AddProductReviewsScreen> {
  double _currentRating = 0;
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  // Hàm để gửi đánh giá
  void _submitReview() {
    if (_formKey.currentState!.validate()) {
      // Gọi hàm để thêm đánh giá
      ReviewController().addProductReview(
        context: context,
        productId: widget.productInfo.id,
        rating: _currentRating,
        comment: _commentController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Thêm đánh giá sản phẩm'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TRoundedContainer(
                padding: const EdgeInsets.all(TSizes.md),
                showBorder: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    Text('Sản phẩm đánh giá'),
                    Divider(),
                    // Thông tin sản phẩm
                    Row(
                      children: [
                        TRoundedImage(
                          isNetworkImage: true,
                          imageUrl:
                              widget.productInfo!.images[0].url.toString(),
                          width: 120,
                          height: 120,
                          padding: const EdgeInsets.all(TSizes.sm),
                          backgroundColor: THelperFunctions.isDarkMode(context)
                              ? TColors.darkerGrey
                              : TColors.light,
                        ),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: ProductTitleText(
                                  title: widget.productInfo.name.toString(),
                                  maxLines: 5,
                                  smallSize: true,
                                ),
                              ),
                              TBrandTitleWithVerifiedIcon(
                                  title:
                                      widget.productInfo.category.toString()),
                              TProductPriceText(
                                price: widget.productInfo.sellPrice!.toString(),
                                isLarge: false,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              // Form nhập đánh giá
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // ... (các widget khác giữ nguyên)
                    RatingBar.builder(
                      initialRating: _currentRating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _currentRating = rating;
                        });
                      },
                    ),
                    TextFormField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        labelText: 'Nội dung đánh giá',
                      ),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập nội dung đánh giá';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    Center(
                      child: ElevatedButton(
                        onPressed:
                            _submitReview, // Sử dụng hàm _submitReview khi nhấn nút,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Text('Gửi đánh giá'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
