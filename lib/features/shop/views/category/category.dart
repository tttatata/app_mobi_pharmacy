import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/appbar/tabbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/brands/brand_card.dart';
import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:app_mobi_pharmacy/common/widgets/layouts/grid_layout.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/productrow/t_row_product_category.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/section_heading.dart';
import 'package:app_mobi_pharmacy/features/shop/views/brand/all_brands.dart';
import 'package:app_mobi_pharmacy/features/shop/views/category/widgets/category_tab.dart';
import 'package:app_mobi_pharmacy/util/constans/category.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            'Danh mục',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TCartCounterIcon(
              onPressed: () {},
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ///seach bar
              const SizedBox(height: TSizes.spaceBtwItems),
              TSearchContainer(
                // text: 'Search in store',
                showBorder: true,
                showBackground: false,
                padding: EdgeInsets.zero,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 650,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (_, index) {
                      return TRowProductCategory(
                          category: Categories.categoryImages[index]['title']!);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
