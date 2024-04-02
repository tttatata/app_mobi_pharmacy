import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/appbar/tabbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/brands/brand_card.dart';
import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/layouts/grid_layout.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/section_heading.dart';
import 'package:app_mobi_pharmacy/features/shop/views/brand/all_brands.dart';
import 'package:app_mobi_pharmacy/features/shop/views/store/widgets/category_tab.dart';
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
            'store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TCartCounterIcon(
              onPressed: () {},
            )
          ],
        ),
        body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    backgroundColor: THelperFunctions.isDarkMode(context)
                        ? TColors.black
                        : TColors.white,
                    expandedHeight: 440,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ///seach bar
                          const SizedBox(height: TSizes.spaceBtwItems),
                          const TSearchContainer(
                            text: 'Search in store',
                            showBorder: true,
                            showBackground: false,
                            padding: EdgeInsets.zero,
                          ),
                          const SizedBox(height: TSizes.spaceBtwSections),

                          ///feattured brand
                          TSetionHeading(
                            title: 'Featured Brands',
                            onPressed: () =>
                                Get.to(() => const AllBrandsScreen()),
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems / 1.5),
                          TGidLayout(
                              itemCount: 4,
                              mainAxisExtent: 80,
                              itemBuilder: (_, index) {
                                return const TBrandCard(
                                  showBorder: true,
                                );
                              })
                        ],
                      ),
                    ),
                    bottom: const TTabBar(tabs: [
                      Tab(child: Text('sporst')),
                      Tab(child: Text('Furniture')),
                      Tab(child: Text('Electronics')),
                      Tab(child: Text('sporst')),
                    ]))
              ];
            },
            body: const TabBarView(
              children: [
                TCategoryTabs(),
                TCategoryTabs(),
                TCategoryTabs(),
                TCategoryTabs(),
              ],
            )),
      ),
    );
  }
}
