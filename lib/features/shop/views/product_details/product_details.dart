import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/icons/t_circular_icon.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_price_text.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/section_heading.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/features/authentication/views/login/login.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/product_details.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_details/widgets/bottom_add_to_cart.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_details/widgets/product_attributes.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_details/widgets/product_detail_image_slider.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_details/widgets/product_meta_data.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_details/widgets/rating_share_widget.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_reviews/product_reviews.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();

  @override
  void initState() {
    super.initState();
  }

  void addToCart() {
    productDetailsServices.addToCart(
      context: context,
      product: widget.product,
    );
  }

  void GotoLogin() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.routeName,
      (route) => true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userchecked =
        Provider.of<UserProvider>(context).user.token.isNotEmpty;

    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      bottomNavigationBar: userchecked
          ? Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.defaultSpace,
                  vertical: TSizes.defaultSpace / 2),
              decoration: BoxDecoration(
                color: darkMode ? TColors.darkGrey : TColors.light,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(TSizes.cardRadiusLg),
                  topRight: Radius.circular(TSizes.cardRadiusLg),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TProductPriceText(
                        price: widget.product.sellPrice.toString(),
                        isLarge: false,
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: addToCart,
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(TSizes.md),
                        backgroundColor: const Color.fromARGB(255, 250, 31, 31),
                        side: const BorderSide(color: TColors.black)),
                    child: const Text('Đặt hàng'),
                  ),
                  ElevatedButton(
                    onPressed: addToCart,
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(TSizes.md),
                        backgroundColor: TColors.black,
                        side: const BorderSide(color: TColors.black)),
                    child: const Text('Thêm vào giỏ '),
                  ),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.defaultSpace,
                  vertical: TSizes.defaultSpace / 2),
              decoration: BoxDecoration(
                color: darkMode ? TColors.darkGrey : TColors.light,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(TSizes.cardRadiusLg),
                  topRight: Radius.circular(TSizes.cardRadiusLg),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'vui lòng đăng nhập để tiếp tục',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  TextButton(
                    onPressed: GotoLogin,
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(TSizes.md),
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        side: const BorderSide(
                            color: Color.fromARGB(255, 255, 15, 15))),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///products image slider
            TProductImageSlider(
              product: widget.product,
            ),

            ///////product detailer
            Padding(
              padding: EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  //ratting and shearing

                  //price title stock brand
                  TProductMetaData(
                    product: widget.product,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  //Attribute
                  // ProductAttributes(),
                  // SizedBox(
                  //   height: TSizes.spaceBtwSections,
                  // ),
                  TRatingAndShare(),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  //checkout

                  TSetionHeading(
                    title: 'Desription',
                    showActionButton: false,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  ReadMoreText(
                    widget.product.description.toString(),
                    trimMode: TrimMode.Line,
                    trimLines: 2,
                    colorClickableText: Colors.pink,
                    trimCollapsedText: '...Show more',
                    trimExpandedText: ' show less',
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  Divider(),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TSetionHeading(
                        title:
                            'Reviews (${widget.product.reviews!.length})', // Cập nhật số lượ
                        showActionButton: false,
                      ),
                      IconButton(
                          onPressed: () => Get.to(() => ProductReviewsScreen()),
                          icon: Icon(
                            Iconsax.arrow_right_3,
                            size: 18,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
