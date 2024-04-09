import 'dart:convert';

import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/layouts/grid_layout.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/product_cards/product_card_vertical.dart';

import 'package:app_mobi_pharmacy/common/widgets/texts/section_heading.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/home_contronller.dart';
import 'package:app_mobi_pharmacy/features/shop/views/all_products/all_products.dart';
import 'package:app_mobi_pharmacy/features/shop/views/home/widgets/home_appbar.dart';
import 'package:app_mobi_pharmacy/features/shop/views/home/widgets/home_categories.dart';
import 'package:app_mobi_pharmacy/features/shop/views/home/widgets/promo_slider.dart';
import 'package:app_mobi_pharmacy/util/constans/api_constants.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = "/home";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic>? productList;
  final HomeController homeServices = HomeController();
  @override
  void initState() {
    super.initState();
    // fetchCategoryProducts();
  }

  // fetchCategoryProducts() async {
  //   productList = await homeServices.fetchCategoryProducts(context: context);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: fetchUsers,
      // ),
      // body: ListView.builder(
      //     itemCount: products.length,
      //     itemBuilder: (context, index) {
      //       final product = products[index];
      //       final name = product['name'];
      //       final images = product['images']['url'];
      //       // final l = product['images']['url'];
      //       return ListTile(
      //         leading: CircleAvatar(),
      //       );
      //     }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  //appbar
                  THomeAppBar(),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  //searchbar
                  TSearchContainer(
                    text: 'Search in Store',
                  ),
                  //category

                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        TSetionHeading(
                          title: 'Popular Categories',
                          textColor: Colors.white,
                          showActionButton: false,
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        THomeCategories(),
                        //
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
            //body
            Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    const TPromoSlider(
                      banners: [
                        TImages.promoBanner1,
                        TImages.promoBanner2,
                        TImages.promoBanner3
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),

                    ///heading
                    TSetionHeading(
                      title: 'Popular products',
                      onPressed: () => Get.to(() => const AllProducts()),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    TGidLayout(
                      itemCount: 2,
                      itemBuilder: (_, index) => const TProductCardVertical(),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Future<void> fetch() async {
    final uri = Uri.parse('$url/api/v2/product/get-all-products');
    final res = await http.get(uri);
    if (res.statusCode==2) {}
  }
}
