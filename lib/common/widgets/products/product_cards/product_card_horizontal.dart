import 'dart:async';

import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/icons/t_circular_icon.dart';
import 'package:app_mobi_pharmacy/common/widgets/images/t_rounded_image.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_price_text.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_title_text.dart';
import 'package:app_mobi_pharmacy/common/styles/shadows.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Event.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_details/product_details.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:jiffy/jiffy.dart'; // Đả

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal(
      {super.key, this.product, this.isIconSale = false, this.productEvent});
  final Product? product;
  final Event? productEvent;
  final bool isIconSale;
  @override
  Widget build(BuildContext context) {
// Tạo biến để lưu giữ giá trị dựa vào isIconSale
    dynamic selectedProduct;

    if (isIconSale) {
      selectedProduct = productEvent;
    } else {
      selectedProduct = product;
    }

// Sử dụng selectedProduct theo nhu cầu
// Ví dụ:
    if (selectedProduct is Product) {
      // Xử lý khi selectedProduct là sản phẩm chính
      print('Đây là sản phẩm chính: ${selectedProduct.name}');
    } else if (selectedProduct is Event) {
      // Xử lý khi selectedProduct là sản phẩm khuyến mãi
      print('Đây là sản phẩm khuyến mãi: ${selectedProduct.name}');
    }
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailScreen.routeName,
          arguments: product,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            color: dark ? TColors.darkGrey : TColors.softGrey,
            boxShadow: [TShadowStyle.horizontalProductShadow()],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  TRoundedContainer(
                    height: 150,
                    padding: const EdgeInsets.all(TSizes.sm),
                    backgroundColor: dark ? TColors.dark : TColors.light,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: TRoundedImage(
                            fit: BoxFit.contain,
                            imageUrl: selectedProduct is Product
                                ? selectedProduct!.images[0].url.toString()
                                : selectedProduct!.images[0].url.toString(),
                            isNetworkImage: true,
                            applyImageRadius: true,
                          ),
                        ),
                        Positioned(
                          child: selectedProduct is Event
                              ? TRoundedContainer(
                                  radius: TSizes.sm,
                                  backgroundColor:
                                      TColors.secondary.withOpacity(0.8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: TSizes.sm,
                                      vertical: TSizes.xs),
                                  child: Text(
                                      ' ${selectedProduct.percentDiscount.toString()}%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .apply(color: TColors.black)),
                                )
                              : Text(''),
                        ),
                        // const Positioned(
                        //   top: -10,
                        //   right: 0,
                        //   child: TCircularIcon(
                        //     icon: Iconsax.heart5,
                        //     color: Colors.red,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 172,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: TSizes.sm, left: TSizes.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              ProductTitleText(
                                title: selectedProduct is Product
                                    ? selectedProduct!.name
                                    : selectedProduct!.name,
                                smallSize: true,
                              ),
                              SizedBox(
                                height: TSizes.spaceBtwItems / 2,
                              ),
                            ],
                          ),
                          TBrandTitleWithVerifiedIcon(
                              title: selectedProduct is Product
                                  ? selectedProduct!.category.toString()
                                  : selectedProduct!.category.toString()),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //price
                                Flexible(
                                  child: TProductPriceText(
                                      price: selectedProduct is Product
                                          ? selectedProduct!.sellPrice
                                              .toString()
                                          : selectedProduct!.discountPrice
                                              .toString()),
                                ),
                                SizedBox(
                                  height: TSizes.spaceBtwItems / 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: TSizes.sm,
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                          10.0), // Đặt bán kính góc dưới bên trái
                      bottomRight: Radius.circular(
                          10.0), // Đặt bán kính góc dưới bên phải
                    ),
                    color: dark
                        ? TColors.darkGrey
                        : Color.fromARGB(255, 49, 134, 245),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedProduct is Event
                            ? CountdownTimer(
                                endTime: selectedProduct.finishDate
                                    .add(Duration(hours: -7)))
                            : Text((''))
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class CountdownTimer extends StatefulWidget {
  final DateTime endTime;

  CountdownTimer({required this.endTime});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Duration _remainingDuration;

  @override
  void initState() {
    super.initState();
    _remainingDuration = widget.endTime.difference(DateTime.now());
    _startTimer();
  }

  void _startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingDuration = widget.endTime.difference(DateTime.now());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final remainingDays = _remainingDuration.inDays;
    final remainingHours = (_remainingDuration.inHours % 24);
    final remainingMinutes = (_remainingDuration.inMinutes % 60);
    final remainingSeconds = (_remainingDuration.inSeconds % 60);
    return Text(
      'Kết thúc sau: $remainingDays ngày, $remainingHours : $remainingMinutes : $remainingSeconds ',
      style: TextStyle(fontSize: 14),
    );
  }
}
