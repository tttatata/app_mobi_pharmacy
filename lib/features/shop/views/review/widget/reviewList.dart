import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/loaders/loader_page.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Order.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/order_controller.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/review_controller.dart';
import 'package:app_mobi_pharmacy/features/shop/views/order/widgets/orders_detail.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/formatters/formatter.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class TReviewListItems extends StatefulWidget {
  // final String reviewStatus; // Trạng thái đánh giá, ví dụ: 'Chưa đánh giá'

  const TReviewListItems({super.key});

  @override
  State<TReviewListItems> createState() => _TReviewListItemsState();
}

class _TReviewListItemsState extends State<TReviewListItems> {
  List<Product>? unreviewedProductList;
  bool isLoading = true;
  final ReviewController reviewController = ReviewController.instance;

  @override
  void initState() {
    super.initState();
    fetchUnreviewedProducts();
  }

  fetchUnreviewedProducts() async {
    setState(() {
      isLoading = true;
    });
    // Sử dụng reviewStatus từ widget để lọc sản phẩm
    unreviewedProductList = await reviewController.fetchUnReviewedProducts(
      context: context,
      // Thêm tham số này
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ... mã giống như trước ...

    if (isLoading) {
      return Center(child: Loader());
    }

    // if (unreviewedProductList == null || unreviewedProductList!.isEmpty) {
    //   return Center(
    //     child: Text(
    //       'Không có sản phẩm nào chưa được đánh giá.',
    //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    //     ),
    //   );
    // }

    return ListView.builder(
        itemCount: unreviewedProductList!.length,
        itemBuilder: (context, index) {
          // Sử dụng reviewStatus để kiểm tra nếu sản phẩm chưa được đánh giá

          return ListTile(
            title: Text(unreviewedProductList![index].name),
            subtitle: Text('ID: ${unreviewedProductList![index].id}'),
            // Thêm các thông tin khác của sản phẩm nếu muốn
          );
        });
  }
}
