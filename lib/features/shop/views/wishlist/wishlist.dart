import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/layouts/grid_layout.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/store_controller.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<Product>? productList;
  final CategoryController homeServices = CategoryController();

  @override
  void initState() {
    super.initState();
    // Khởi tạo productList ở đây để tránh tạo lại nó mỗi lần build
    final user = context.read<UserProvider>().user;
    if (user.wishList != null && user.wishList!.isNotEmpty) {
      productList = user.wishList!
          .map((productMap) => Product.fromMap(productMap['product']))
          .toList();
    } else {
      productList = []; // Đảm bảo productList không null và không rỗng
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final productList = user.wishList!
        .map((productMap) => Product.fromMap(productMap['product']))
        .toList();
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Danh sách yêu thích',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              if (productList != null && productList!.isNotEmpty)
                TGidLayout(
                  itemCount: productList!.length,
                  itemBuilder: (context, index) {
                    final product = productList![index];
                    return TProductCardVertical(product: product);
                  },
                )
              else
                Text('Không có sản phẩm nào trong danh sách yêu thích.'),
            ],
          ),
        ),
      ),
    );
  }
}
