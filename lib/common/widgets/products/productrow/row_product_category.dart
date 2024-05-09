import 'package:app_mobi_pharmacy/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/product_cards/product_event_card_horizontal.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/store_controller.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';

class RowProductCateggory extends StatefulWidget {
  final String? category;
  const RowProductCateggory({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<RowProductCateggory> createState() => _RowProductCateggoryscreenState();
}

class _RowProductCateggoryscreenState extends State<RowProductCateggory> {
  List<Product>? productList;
  final StoreController storeController = StoreController();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await storeController.fetchCategoryProducts(
      context: context,
      category: widget.category!,
    );
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (productList == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
          height: 360,
          child: productList!.length != 0
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: productList!.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: TSizes.spaceBtwItems),
                  itemBuilder: (context, index) {
                    final product = productList?[index];
                    return TProductCardHorizontal(product: product);
                  })
              : Center(child: Text('Không có sản phẩm nào thuộc loại này'))),
    );
  }
}
