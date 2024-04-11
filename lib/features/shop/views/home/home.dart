import 'dart:convert';

import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/layouts/grid_layout.dart';
import 'package:app_mobi_pharmacy/common/widgets/loaders/loader_page.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/product_cards/product_card_horizontal.dart';
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

  List items = [];
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
                          // SizedBox(
                          //     height: 150,
                          //     child: productList!.length != 0
                          //         ? ListView.separated(
                          //             itemCount: productList!.length,
                          //             scrollDirection: Axis.horizontal,
                          //             separatorBuilder: (context, index) =>
                          //                 SizedBox(width: TSizes.spaceBtwItems),
                          //             itemBuilder: (context, index) {
                          //               final product = productList![index];
                          //               return TProductCardVertical(
                          //                   product: product);
                          //             })
                          //         : Text(
                          //             'Không có sản phẩm nào thuộc loại này !'))
                          TGidLayout(
                              itemCount: productList!.length,
                              itemBuilder: (context, index) {
                                final product = productList![index];
                                return TProductCardVertical(product: product);
                                // child: TProductCardVertical(
                                //     name: productList![index].name)

                                //    onTap: () {
                                //   Navigator.pushNamed(ơ
                                //     context,
                                //     ProductDetailScreen.routeName,
                                //     arguments: product,
                                //   );
                                // },
                              }),
                        ],
                      )),
                ],
              ),
            ),
    );
  }
}
    // body: ListView.builder(
        //     itemCount: productList!.length,
        //     itemBuilder: (context, index) {
        //       final product = productList![index];

        //       // final l = product['images']['url'];
        //       return ListTile(
        //         leading: Text(product.name),
        //       );
        //     }));
    //   body: productList == null
    //       ? const Text('load')
    //       : Column(
    //           children: [
    //             Container(
    //               padding:
    //                   const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    //               alignment: Alignment.topLeft,
    //               child: Text(
    //                 'Keep shopping for ',
    //                 style: const TextStyle(
    //                   fontSize: 20,
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               height: 170,
    //               child: GridView.builder(
    //                 scrollDirection: Axis.horizontal,
    //                 padding: const EdgeInsets.only(left: 15),
    //                 itemCount: productList!.length,
    //                 gridDelegate:
    //                     const SliverGridDelegateWithFixedCrossAxisCount(
    //                   crossAxisCount: 1,
    //                   childAspectRatio: 1.4,
    //                   mainAxisSpacing: 10,
    //                 ),
    //                 itemBuilder: (context, index) {
    //                   final product = productList![index];
    //                   return GestureDetector(
    //                     onTap: () {},
    //                     child: Column(
    //                       children: [
    //                         SizedBox(
    //                           height: 130,
    //                           child: DecoratedBox(
    //                             decoration: BoxDecoration(
    //                               border: Border.all(
    //                                 color: Colors.black12,
    //                                 width: 0.5,
    //                               ),
    //                             ),
    //                             // child: Padding(
    //                             //   padding: const EdgeInsets.all(10),
    //                             //   child: Image.network(
    //                             //     product.images[0].url,
    //                             //   ),
    //                             // ),
    //                           ),
    //                         ),
    //                         Container(
    //                           alignment: Alignment.topLeft,
    //                           padding: const EdgeInsets.only(
    //                             left: 0,
    //                             top: 5,
    //                             right: 15,
    //                           ),
    //                           child: Text(
    //                             product.name,
    //                             maxLines: 1,
    //                             overflow: TextOverflow.ellipsis,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   );
    //                 },
    //               ),
    //             ),
    //           ],
    //         ),
    // );
//   }
// }

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
  // Future<void> fetch() async {
  //   final uri = Uri.parse('$url/api/v2/product/get-all-products');
  //   final res = await http.get(uri);
  //   if (res.statusCode == 200) {
  //     final json = jsonDecode(res.body) as Map;
  //     final result = json['products'] as List;
  //     setState(() {
  //       items = result;
  //     });
  //   }
  // }
// }
