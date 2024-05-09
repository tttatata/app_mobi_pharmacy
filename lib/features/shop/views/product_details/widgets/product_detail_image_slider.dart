// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/product_details.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/curved_edges/curved_edgges_widget.dart';
import 'package:app_mobi_pharmacy/common/widgets/icons/t_circular_icon.dart';
import 'package:app_mobi_pharmacy/common/widgets/images/t_rounded_image.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Image.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:provider/provider.dart';

class TProductImageSlider extends StatefulWidget {
  const TProductImageSlider({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;
  @override
  State<TProductImageSlider> createState() => _TProductImageSliderState();
}

class _TProductImageSliderState extends State<TProductImageSlider> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  @override
  void initState() {
    super.initState();
  }

  void addToWishlist() {
    productDetailsServices.addToWishList(
      context: context,
      product: widget.product,
    );
  }

  void removeToWishList() {
    productDetailsServices.removeFromWishList(
      context: context,
      product: widget.product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final user = context.watch<UserProvider>().user;

    bool isFavorite = user.wishList!.any((item) =>
        item['product']['_id'].toString() == widget.product.id.toString());

    final ValueNotifier<String> _currentImageUrl =
        ValueNotifier(widget.product.images[0].url.toString());
    return TCurvedEdgetWidget(
      child: Container(
        color: darkMode ? TColors.darkGrey : TColors.light,
        child: Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: _currentImageUrl,
              builder: (context, String imageUrl, child) {
                return SizedBox(
                  height: 400,
                  child: Padding(
                    padding: EdgeInsets.all(TSizes.productImageRadius * 2),
                    child: Center(
                      child: Image(image: NetworkImage(imageUrl)),
                    ),
                  ),
                );
              },
            ),
            //image slideer

            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: TSizes.spaceBtwItems),
                  itemCount: widget.product.images.length,
                  itemBuilder: (_, index) {
                    // Bọc TRoundedImage trong GestureDetector để xử lý sự kiện nhấn
                    return GestureDetector(
                      onTap: () {
                        // Cập nhật _currentImageUrl khi một hình ảnh nhỏ được nhấn
                        _currentImageUrl.value =
                            widget.product.images[index].url.toString();
                      },
                      child: TRoundedImage(
                        width: 80,
                        backgroundColor:
                            darkMode ? TColors.dark : TColors.white,
                        border: Border.all(color: TColors.primary),
                        padding: const EdgeInsets.all(TSizes.sm),
                        isNetworkImage: true,
                        imageUrl: widget.product.images[index].url.toString(),
                      ),
                    );
                  },
                ),
              ),
            ),

            TAppBar(
              actions: [
                Builder(
                  builder: (BuildContext context) {
                    return TCircularIcon(
                      onPressed: isFavorite
                          ? () => removeToWishList()
                          : () => addToWishlist(),
                      icon: Iconsax.heart5,
                      color: isFavorite ? Colors.pink : Colors.grey,
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
