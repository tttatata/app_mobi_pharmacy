import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/sortable/sortable_products.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/home_contronller.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({
    Key? key,
  }) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  List<Product>? productList;
  final HomeController homeServices = HomeController();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Sản phẩm phổ biến'),
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
