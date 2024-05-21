import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/loaders/loader_page.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Order.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/order_controller.dart';
import 'package:app_mobi_pharmacy/features/shop/views/order/widgets/orders_detail.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/formatters/formatter.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class TOrderListItems extends StatefulWidget {
  final String orderStatus;

  const TOrderListItems({super.key, required this.orderStatus});

  @override
  State<TOrderListItems> createState() => _TOrderListItemsState();
}

class _TOrderListItemsState extends State<TOrderListItems> {
  List<Order>? productList;
  bool isLoading = true; // Thêm biến trạng thái isLoading
  final OrderController homeServices = OrderController();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    setState(() {
      isLoading = true; // Bắt đầu tải dữ liệu
    });
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      filterStatus: widget.orderStatus,
    );
    setState(() {
      isLoading = false; // Dữ liệu đã được tải xong
    });
  }

  // ... phần còn lại của mã ...

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    // Nếu đang tải, hiển thị loader
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
      itemBuilder: (_, index) => TRoundedContainer(
        showBorder: true,
        padding: const EdgeInsets.all(TSizes.md),
        backgroundColor: dark ? TColors.dark : TColors.light,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'mã đơn:\t${productList![index].id}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                //status
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Row(
              children: [
                const Icon(Iconsax.timer_14),
                const SizedBox(
                  width: TSizes.spaceBtwItems / 2,
                ),
                //status
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productList![index].status.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: TColors.primary, fontWeightDelta: 1),
                      ),
                      Text(
                        DateFormat('HH:mm dd-MM-yyyy').format(
                            productList![index]
                                .createdAt!
                                .toUtc()
                                .add(Duration(hours: 7))),
                        style: Theme.of(context).textTheme.headlineSmall,
                      )
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        OrderDetailScreen.routeName,
                        arguments: productList![index],
                      );
                    },
                    icon: const Icon(
                      Iconsax.arrow_right_34,
                      size: TSizes.iconSm,
                    ))
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Iconsax.tag),
                      const SizedBox(
                        width: TSizes.spaceBtwItems / 2,
                      ),
                      //status
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Số sản phẩm',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text(
                              '${productList![index].cart!.length}',
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Iconsax.dollar_circle),
                      const SizedBox(
                        width: TSizes.spaceBtwItems / 2,
                      ),
                      //status
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tổng tiền',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text(
                              TFormatter.formatCurrency(
                                  productList![index].totalPrice.toDouble()),
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
