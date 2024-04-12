import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/layouts/grid_layout.dart';
import 'package:app_mobi_pharmacy/common/widgets/loaders/loader_page.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/productrow/t_row_product_category.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/search_controller.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_details/product_details.dart';
import 'package:app_mobi_pharmacy/util/constans/category.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
  }

  fetchSearchedProduct() async {
    products = await searchServices.fetchSearchedProduct(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
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
              SizedBox(
                height: 800,
                child: products == null
                    ? const Loader()
                    : Column(
                        children: [
                          const SizedBox(height: 10),
                          Expanded(
                            child: TGidLayout(
                                itemCount: products!.length,
                                itemBuilder: (context, index) {
                                  final product = products![index];
                                  return TProductCardVertical(product: product);
                                }),
                          ),
                        ],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//     Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: AppBar(
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(),
//           ),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 42,
//                   margin: const EdgeInsets.only(left: 15),
//                   child: Material(
//                     borderRadius: BorderRadius.circular(7),
//                     elevation: 1,
//                     child: TextFormField(
//                       onFieldSubmitted: navigateToSearchScreen,
//                       decoration: InputDecoration(
//                         prefixIcon: InkWell(
//                           onTap: () {},
//                           child: const Padding(
//                             padding: EdgeInsets.only(
//                               left: 6,
//                             ),
//                             child: Icon(
//                               Icons.search,
//                               color: Colors.black,
//                               size: 23,
//                             ),
//                           ),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                         contentPadding: const EdgeInsets.only(top: 10),
//                         border: const OutlineInputBorder(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(7),
//                           ),
//                           borderSide: BorderSide.none,
//                         ),
//                         enabledBorder: const OutlineInputBorder(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(7),
//                           ),
//                           borderSide: BorderSide(
//                             color: Colors.black38,
//                             width: 1,
//                           ),
//                         ),
//                         hintText: 'Search Amazon.in',
//                         hintStyle: const TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 17,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 color: Colors.transparent,
//                 height: 42,
//                 margin: const EdgeInsets.symmetric(horizontal: 10),
//                 child: const Icon(Icons.mic, color: Colors.black, size: 25),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: products == null
//           ? const Loader()
//           : Column(
//               children: [
//                 const SizedBox(height: 10),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: products!.length,
//                     itemBuilder: (context, index) {
//                       final product = products![index];
//                       return TProductCardVertical(product: product);
//                       ;
//                     },
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
  