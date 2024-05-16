import 'dart:convert';

import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/search_container.dart';

import 'package:app_mobi_pharmacy/common/widgets/layouts/grid_layout.dart';
import 'package:app_mobi_pharmacy/common/widgets/loaders/loader_page.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/product_cards/product_event_card_horizontal.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/product_cards/product_card_vertical.dart';

import 'package:app_mobi_pharmacy/common/widgets/texts/section_heading.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Event.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/home_contronller.dart';
import 'package:app_mobi_pharmacy/features/shop/views/all_products/all_products.dart';
import 'package:app_mobi_pharmacy/features/shop/views/home/widgets/home_appbar.dart';
import 'package:app_mobi_pharmacy/features/shop/views/home/widgets/home_categories.dart';
import 'package:app_mobi_pharmacy/features/shop/views/home/widgets/promo_slider.dart';
import 'package:app_mobi_pharmacy/features/shop/views/search/search_product.dart';
import 'package:app_mobi_pharmacy/util/constans/api_constants.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/constans/text_strings.dart';
import 'package:app_mobi_pharmacy/util/popups/full_screen_loader.dart';
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
  List<Product>? productList;
  List<Event>? productSaleList;
  final HomeController homeServices = HomeController();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
    fetchSaleProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(context: context);
    setState(() {});
  }

  fetchSaleProducts() async {
    productSaleList = await homeServices.fetchSaleProducts(context: context);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  // note
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: productList == null
          ? const Loader()
          : SingleChildScrollView(
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
                        TSearchContainer(),
                        //category
                        SizedBox(
                          height: TSizes.spaceBtwSections / 2,
                        ),
                        Padding(
                          padding: EdgeInsets.all(TSizes.defaultSpace),
                          child: Column(
                            children: [
                              TPromoSlider(
                                banners: [
                                  TImages.promoBanner1,
                                  TImages.promoBanner2,
                                  TImages.promoBanner3
                                ],
                              ),

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
                      padding: const EdgeInsets.only(
                          left: TSizes.defaultSpace,
                          right: TSizes.defaultSpace),
                      child: Column(
                        children: [
                          TSetionHeading(
                            title: TTexts.popularCategoryProducts,
                            textColor: Color.fromARGB(255, 3, 1, 102),
                            showActionButton: false,
                          ),
                          SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          THomeCategories(),
                          SizedBox(
                            height: TSizes.spaceBtwItems * 2,
                          ),

                          ///heading
                          TSetionHeading(
                            title: TTexts.saleoffProducts,
                            onPressed: () => Get.to(() => const AllProducts()),
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: SizedBox(
                                height: 220,
                                child: productSaleList!.length != 0
                                    ? ListView.separated(
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: productSaleList!.length,
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                                width: TSizes.spaceBtwItems),
                                        itemBuilder: (context, index) {
                                          final product =
                                              productSaleList?[index];
                                          return TProductEventCardHorizontal(
                                            productEvent: product,
                                            isIconSale: true,
                                          );
                                        })
                                    : Text(
                                        'Không có sản phẩm nào thuộc loại này')),
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),

                          ///heading
                          TSetionHeading(
                            title: TTexts.popularProducts,
                            onPressed: () => Get.to(() => const AllProducts()),
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),

                          TGidLayout(
                              itemCount: productList!.length,
                              itemBuilder: (context, index) {
                                final product = productList![index];
                                return TProductCardVertical(product: product);
                              }),
                        ],
                      )),
                ],
              ),
            ),
    );
  }
}
