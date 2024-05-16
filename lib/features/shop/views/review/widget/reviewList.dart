import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/images/t_rounded_image.dart';
import 'package:app_mobi_pharmacy/common/widgets/loaders/loader_page.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_price_text.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_title_text.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Order.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/order_controller.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/review_controller.dart';
import 'package:app_mobi_pharmacy/features/shop/views/order/widgets/orders_detail.dart';
import 'package:app_mobi_pharmacy/features/shop/views/review/addreview.dart';
import 'package:app_mobi_pharmacy/features/shop/views/review/widget/reviewdetail.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/formatters/formatter.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class TReviewListItems extends StatefulWidget {
  final String reviewStatus; // Trạng thái đánh giá, ví dụ: 'Chưa đánh giá'

  const TReviewListItems({super.key, required this.reviewStatus});

  @override
  State<TReviewListItems> createState() => _TReviewListItemsState();
}

class _TReviewListItemsState extends State<TReviewListItems> {
  List<Product>? productList;
  bool isLoading = true;
  final ReviewController reviewController = ReviewController();

  @override
  void initState() {
    super.initState();
    if (widget.reviewStatus == "Sản phẩm chưa đánh giá") {
      fetchUnreviewedProducts();
    } else if (widget.reviewStatus == "Sản phẩm đã dánh giá") {
      fetchReviewedProducts();
    }
  }

  fetchUnreviewedProducts() async {
    setState(() {
      isLoading = true;
    });
    // Sử dụng reviewStatus từ widget để lọc sản phẩm
    productList = await reviewController.fetchUnReviewedProducts(
      context: context,
      // Thêm tham số này
    );
    setState(() {
      isLoading = false;
    });
  }

  fetchReviewedProducts() async {
    setState(() {
      isLoading = true;
    });
    productList = await reviewController.fetchReviewedProducts(
      context: context,
      // Thêm tham số này
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    if (isLoading) {
      return Center(
        child: Loader(),
      );
    }
    // Kiểm tra nếu productList rỗng hoặc null
    if (productList == null || productList!.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Center(
            child: Text(
              'Không có sản phẩm nào.', // Thông báo hiển thị khi không có đơn hàng
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }
    // Nếu productList có dữ liệu, hiển thị ListView như bình thường
    return ListView.separated(
        shrinkWrap: true,
        itemCount: productList!.length,
        separatorBuilder: (_, __) => const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
        itemBuilder: (_, index) {
          // Tính toán đánh giá trung bình cho sản phẩm hiện tại
          double sumRatings = 0;
          productList![index].reviews?.forEach((review) {
            sumRatings += review.rating ?? 0;
          });
          double averageRating = productList![index].reviews != null &&
                  productList![index].reviews!.isNotEmpty
              ? sumRatings / productList![index].reviews!.length
              : 0;
          return TRoundedContainer(
            showBorder: true,
            padding: const EdgeInsets.all(TSizes.md),
            backgroundColor: dark ? TColors.dark : TColors.light,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    TRoundedImage(
                      isNetworkImage: true,
                      imageUrl: productList![index].images[0].url.toString(),
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
                              title: productList![index].name.toString(),
                              maxLines: 5,
                              smallSize: true,
                            ),
                          ),
                          TBrandTitleWithVerifiedIcon(
                              title: productList![index].category.toString()),
                          TProductPriceText(
                            price: productList![index].sellPrice!.toString(),
                            isLarge: false,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Căn chỉnh các con sát hai bên
                  children: [
                    Row(
                      children: [
                        Icon(
                          Iconsax.star5,
                          color: Colors.amber,
                          size: 24,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: averageRating.toStringAsFixed(1),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 16)),
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text:
                                          '( ${productList![index].reviews!.length.toString()} )',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(fontSize: 12)),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            widget.reviewStatus == "Sản phẩm chưa đánh giá"
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AddProductReviewsScreen(
                                        productInfo: productList![index],
                                      ),
                                    ),
                                  )
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReviewsDetailScreen(
                                        productInfo: productList![index],
                                      ),
                                    ),
                                  );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15), // Chỉnh padding ngang
                            child:
                                widget.reviewStatus == "Sản phẩm chưa đánh giá"
                                    ? Text('Đánh giá')
                                    : Text('Xem đánh giá của bạn'),
                          ), // Customize button text
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
