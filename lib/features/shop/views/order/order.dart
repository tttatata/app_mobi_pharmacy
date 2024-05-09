import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/appbar/tabbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Order.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/order_controller.dart';
import 'package:app_mobi_pharmacy/features/shop/views/category/widgets/category_tab.dart';
import 'package:app_mobi_pharmacy/features/shop/views/order/widgets/orders_list.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? productList;

  final OrderController homeServices = OrderController();

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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            'Đơn hàng đã đặt',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
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
                        : const Color.fromARGB(255, 230, 0, 0),
                    expandedHeight: 0,
                    bottom: const TTabBar(tabs: [
                      Tab(child: Text('Đơn đã đặt')),
                      Tab(child: Text('Đơn chưa xác nhận')),
                      Tab(child: Text('Dơn đã xác nhận')),
                      Tab(child: Text('Đơn đang vận chuyển')),
                      Tab(child: Text('Đơn đã giao')),
                    ]))
              ];
            },
            body: TabBarView(
              children: [
                TCategoryTabs(orderStatus: 'Đơn đã đặt'),
                TCategoryTabs(orderStatus: 'Đơn chưa xác nhận'),
                TCategoryTabs(orderStatus: 'Dơn đã xác nhận'),
                TCategoryTabs(orderStatus: 'Đơn đang vận chuyển'),
                TCategoryTabs(orderStatus: 'Đơn đã giao'),
              ],
            )),
      ),
    );
  }
}
//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);
//     return Scaffold(
//       appBar: TAppBar(
//         showBackArrow: true,
//         title: Text(
//           'Đơn hàng của tôi',
//           style: Theme.of(context).textTheme.headlineSmall,
//         ),
//       ),
//       body: const Padding(
//         padding: EdgeInsets.all(TSizes.defaultSpace),
//         child: TOrderListItems(),
//       ),
//     );
//   }
// }
