import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/images/t_rounded_image.dart';
import 'package:app_mobi_pharmacy/common/widgets/layouts/grid_layout.dart';
import 'package:app_mobi_pharmacy/common/widgets/loaders/loader_page.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/section_heading.dart';

import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/sub_category.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const SubCategoriesScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  List<Product>? productList;
  final SubCategoryController subCategoryController = SubCategoryController();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await subCategoryController.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          widget.category,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: productList == null
          ? const Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                   
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
                    // Column(
                    //   children: [
                    //     TSetionHeading(
                    //       title: widget.category,
                    //       showActionButton:
                    //           productList!.length != 0 ? true : false,
                    //       onPressed: () {},
                    //     ),
                    //     SizedBox(height: TSizes.spaceBtwItems / 2),
                    //     SizedBox(
                    //         height: 120,
                    //         child: productList!.length != 0
                    //             ? ListView.separated(
                    //                 itemCount: productList!.length,
                    //                 scrollDirection: Axis.horizontal,
                    //                 separatorBuilder: (context, index) =>
                    //                     SizedBox(width: TSizes.spaceBtwItems),
                    //                 itemBuilder: (context, index) {
                    //                   final product = productList![index];
                    //                   return TProductCardHorizontal(
                    //                       product: product);
                    //                 })
                    //             : Text(
                    //                 'Không có sản phẩm nào thuộc loại này !'))
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
    );
  }
}
