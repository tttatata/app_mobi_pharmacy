import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/sortable/sortable_products.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/home_contronller.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/store_controller.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';

class AllProductsByCategory extends StatefulWidget {
  final String category;
  const AllProductsByCategory({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<AllProductsByCategory> createState() => _AllProductsByCategoryState();
}

class _AllProductsByCategoryState extends State<AllProductsByCategory> {
  List<Product>? productList;
  final CategoryController cateroryController = CategoryController();
  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await cateroryController.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('${widget.category}'),
        showBackArrow: true,
      ),
      body: productList == null
          ? Center(
              child:
                  CircularProgressIndicator()) // Hiển thị loader khi productList đang null
          : productList!.isEmpty
              ? Center(
                  child: Text(
                      'Không có sản phẩm loại này')) // Hiển thị thông báo khi không có sản phẩm
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      children: [
                        TSortableProducts(
                          productList: productList,
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
