import 'dart:convert';

import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/images/t_rounded_image.dart';
import 'package:app_mobi_pharmacy/common/widgets/loaders/loader.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/cart/cart_item.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/cart/coupon_widgets.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/common/widgets/success_screen/success_screen.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_price_text.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/product_title_text.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Order.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/checkout_controller.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/order_controller.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/paymentcontroller.dart';
import 'package:app_mobi_pharmacy/features/shop/views/cart/widgents/cart_items.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/billing_address_section.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/billing_amount_section.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/billing_paymentmethod.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/billing_user.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/card.dart';
import 'package:app_mobi_pharmacy/features/shop/views/checkout/widgets/paymentmethod.dart';
import 'package:app_mobi_pharmacy/navigation_menu.dart';
import 'package:app_mobi_pharmacy/util/constans/api_constants.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/formatters/formatter.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// main.dart
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  const OrderDetailScreen({super.key, this.order});
  final Order? order;
  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final OrderController productDetailsServices = OrderController();
  @override
  void initState() {
    super.initState();
  }

  void addToWishlist() {
    productDetailsServices.updateOrder(
        context: context,
        orderId: widget.order!.id,
        updateData: 'Hủy đơn hàng');
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final user = context.watch<UserProvider>().user;
    double sum = 0;
    widget.order!.cart?.forEach((e) {
      final price = e['sellPrice'];
      final qty = e['qty'];
      if (price != null && qty != null) {
        sum += double.parse(price.toString()) * double.parse(qty.toString());
      }
    });
    Color _getStatusColor(String status) {
      switch (status) {
        case 'Đang chờ xác nhận':
          return Color.fromARGB(255, 255, 2, 2);
        case 'Đã bàn giao đơn vị vận chuyển':
          return Color.fromARGB(255, 255, 1, 1);
        case 'Đang giao hàng':
          return Color.fromARGB(255, 240, 9, 1);
        case 'Đang giao đến bạn':
          return Color.fromARGB(255, 240, 9, 1);
        case 'Đã giao hàng':
          return Colors.green;
        case 'Đã nhận tại cửa hàng':
          return Colors.green;
        case 'Hủy đơn hàng':
          return Color.fromARGB(255, 252, 0, 0);
        default:
          return Colors.grey; // Màu mặc định cho các trạng thái khác
      }
    }

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Thông tin đơn mua',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TRoundedContainer(
                padding: const EdgeInsets.all(TSizes.md),
                showBorder: false,
                backgroundColor: Colors.white,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Trạng thái: ${widget.order!.status}',
                        style: TextStyle(
                          color: _getStatusColor(
                              widget.order!.status), // Màu chữ trắng
                          fontSize: 16, // Kích thước chữ
                          // Thêm các thuộc tính khác cho TextStyle nếu cần
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections / 2),
              TRoundedContainer(
                padding: const EdgeInsets.all(TSizes.md),
                showBorder: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.person_2,
                                      color: Colors.grey,
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      width: TSizes.spaceBtwItems / 2,
                                    ),
                                    Text('Thông tin người nhận',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    const SizedBox(
                                      width: TSizes.spaceBtwItems,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwItems / 2,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Text(
                                          'Tên người nhận: ${widget.order!.user!.name.toString()}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwItems / 6,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Text(
                                          'Điện thoại: ${widget.order!.user!.phoneNumber.toString()}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwItems / 6,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Text(
                                          'Email: ${widget.order!.user!.email.toString()}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwItems / 2,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_city,
                                      color: Colors.grey,
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      width: TSizes.spaceBtwItems / 2,
                                    ),
                                    Text('Địa chỉ giao hàng',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    const SizedBox(
                                      width: TSizes.spaceBtwItems,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwItems / 2,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Text(
                                          '${widget.order!.shippingAddress!.address1.toString()},${widget.order!.shippingAddress!.city.toString()}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections / 2),
              TRoundedContainer(
                padding: const EdgeInsets.all(TSizes.md),
                showBorder: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Mã đơn hàng',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    const SizedBox(
                                      width: TSizes.spaceBtwItems,
                                    ),
                                    Text('${widget.order!.id.toString()}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                  ],
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwItems / 2,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Text(
                                          'Thời gian đặt: ${DateFormat('HH:mm dd/MM/yyyy').format(widget.order!.createdAt!)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwItems / 6,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Text(
                                          'Thời gian giao: ${widget.order != null && widget.order!.paidAt != null ? DateFormat('HH:mm dd/MM/yyyy').format(widget.order!.paidAt!) : 'Đang xử lý'}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwItems / 6,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Text(
                                          'Thời gian giao: ${widget.order != null && widget.order!.deliveredAt != null ? DateFormat('HH:mm dd/MM/yyyy').format(widget.order!.deliveredAt!) : 'Đang xử lý'}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwItems / 2,
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections / 2),
              TRoundedContainer(
                padding: const EdgeInsets.all(TSizes.md),
                showBorder: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Phương thức thanh toán',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                  ],
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwItems / 2,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Text(
                                          ' ${widget.order!.paymentInfo['type']}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwItems / 6,
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections / 2),
              TRoundedContainer(
                padding: const EdgeInsets.all(TSizes.md),
                showBorder: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Danh sách sản phẩm',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                  ],
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwItems / 2,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ListView.separated(
                                          shrinkWrap: true,
                                          itemCount: widget.order!.cart!.length,
                                          separatorBuilder: (_, __) =>
                                              const SizedBox(
                                                  height:
                                                      TSizes.spaceBtwSections /
                                                          2),
                                          itemBuilder: (_, index) => Container(

                                              // Điều chỉnh chiều cao của cột
                                              decoration: BoxDecoration(
                                                color: Colors
                                                    .white, // Màu nền của cột
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(
                                                        0.5), // Màu của đổ bóng
                                                    spreadRadius:
                                                        0, // Bán kính đổ bóng
                                                    blurRadius:
                                                        10, // Độ mờ của đổ bóng
                                                    offset: Offset(0,
                                                        3), // Vị trí đổ bóng (x, y)
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      TRoundedImage(
                                                        isNetworkImage: true,
                                                        imageUrl: widget
                                                            .order!
                                                            .cart![index]
                                                                ['images'][0]
                                                                ['url']
                                                            .toString(),
                                                        width: 120,
                                                        height: 120,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(TSizes.sm),
                                                        backgroundColor:
                                                            THelperFunctions
                                                                    .isDarkMode(
                                                                        context)
                                                                ? TColors
                                                                    .darkerGrey
                                                                : TColors.light,
                                                      ),
                                                      const SizedBox(
                                                          width: TSizes
                                                              .spaceBtwItems),
                                                      //title price Size
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Flexible(
                                                              child:
                                                                  ProductTitleText(
                                                                title: widget
                                                                    .order!
                                                                    .cart![
                                                                        index]
                                                                        ['name']
                                                                    .toString(),
                                                                maxLines: 5,
                                                                smallSize: true,
                                                              ),
                                                            ),
                                                            TBrandTitleWithVerifiedIcon(
                                                              title: widget
                                                                  .order!
                                                                  .cart![index][
                                                                      'category']
                                                                  .toString(),
                                                            ),
                                                            const SizedBox(
                                                                height: TSizes
                                                                        .spaceBtwInputFields /
                                                                    4),
                                                            Text(
                                                              '${TFormatter.formatCurrency(double.parse(
                                                                widget
                                                                    .order!
                                                                    .cart![
                                                                        index][
                                                                        'sellPrice']
                                                                    .toString(),
                                                              ))} x ${int.parse(
                                                                widget
                                                                    .order!
                                                                    .cart![
                                                                        index]
                                                                        ['qty']
                                                                    .toString(),
                                                              )}',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelLarge,
                                                            ),
                                                            const SizedBox(
                                                                height: TSizes
                                                                        .spaceBtwInputFields /
                                                                    2),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ))),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwItems / 6,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Tổng tiền: ${TFormatter.formatCurrency(double.parse(sum.toString()))}',
                                      style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                color: Colors.red,
                                                fontSize:
                                                    17, // Điều chỉnh kích thước chữ tại đây
                                              ) ??
                                          TextStyle(
                                              color: Colors.red, fontSize: 18),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwItems,
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: widget.order!.status == 'Đang giao hàng' ||
                  widget.order!.status == 'Đã xác nhận'
              ? null // Không cho phép nhấn nút nếu trạng thái là 'Đang chờ xác nhận' hoặc 'Đã xác nhận'
              : () {
                  // Hành động cho các trạng thái khác
                  if (widget.order!.status == 'Đã giao hàng' ||
                      widget.order!.status == 'Hoàn trả đơn hàng') {
                    // Hành động mua lại
                  } else {
                    addToWishlist();
                  }
                },
          child: Text(
            widget.order!.status == 'Đang chờ xác nhận' ||
                    widget.order!.status == 'Đã xác nhận' ||
                    widget.order!.status == 'Đang giao hàng'
                ? 'Bạn không thể hoàn trả đơn hàng'
                : widget.order!.status == 'Đã giao hàng' ||
                        widget.order!.status == 'Hủy đơn hàng'
                    ? 'Mua lại đơn hàng'
                    : '', // Thêm văn bản mặc định hoặc xử lý cho trạng thái không xác định
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.order!.status == 'Đã giao hàng'
                ? Colors
                    .red // Màu đỏ cho trạng thái 'Đang chờ xác nhận', 'Hủy đơn hàng', và 'Đã giao hàng'
                : const Color.fromARGB(255, 141, 141,
                    141), // Màu vàng cho trạng thái 'Đã xác nhận' và 'Đang giao hàng'
          ),
        ),
      ),
    );
  }
}
