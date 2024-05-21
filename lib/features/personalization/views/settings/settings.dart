import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:app_mobi_pharmacy/common/widgets/list_titles/settings_menu_title.dart';
import 'package:app_mobi_pharmacy/common/widgets/list_titles/user_profile_title.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/common/widgets/texts/section_heading.dart';
import 'package:app_mobi_pharmacy/features/authentication/views/login/login.dart';
import 'package:app_mobi_pharmacy/features/personalization/controllers/settings_controller.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/address/address.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/profile/profile.dart';
import 'package:app_mobi_pharmacy/features/shop/views/cart/cart.dart';
import 'package:app_mobi_pharmacy/features/shop/views/order/order.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_reviews/product_reviews.dart';
import 'package:app_mobi_pharmacy/features/shop/views/review/Reviews.dart';
import 'package:app_mobi_pharmacy/features/shop/views/wishlist/wishlist.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/constans/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  static const String routeName = "/settings";
  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>().user;
    final userchecked =
        Provider.of<UserProvider>(context).user.token.isNotEmpty;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(
                    title: Text(
                      'Tài khoản',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: TColors.white),
                    ),
                  ),
                  TUSerProfileTitle(),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
            //body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: userchecked
                  ? Column(
                      children: [
                        const TSetionHeading(
                          title: 'Thiết lập tài khoản',
                          showActionButton: false,
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        TSettingsMenuTitle(
                          icon: Iconsax.safe_home,
                          title: 'Danh sách địa chỉ của bạn',
                          subTitle: 'Địa chỉ giao hàng để giao hàng',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const UserAddressScreen()),
                            );
                          },
                        ),
                        TSettingsMenuTitle(
                          icon: Iconsax.shopping_cart,
                          title: 'Giỏ hàng',
                          subTitle:
                              'Danh sách sản phẩm bạn đã thêm vào giỏ hàng ',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CartScreen()),
                            );
                          },
                        ),
                        TSettingsMenuTitle(
                          icon: Iconsax.bag_tick,
                          title: 'Đơn mua',
                          subTitle: 'Tất cả đơn hàng đã đặt',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const OrdersScreen()),
                            );
                          },
                        ),
                        TSettingsMenuTitle(
                          icon: Iconsax.star,
                          title: 'Đánh giá sản phẩm',
                          subTitle: 'List of all the discounted coupons',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ReviewsScreen()),
                            );
                          },
                        ),
                        TSettingsMenuTitle(
                          icon: Iconsax.notification,
                          title: 'Thông báo',
                          subTitle: 'Thiết lập thông báo',
                          onTap: () {},
                        ),
                        TSettingsMenuTitle(
                          icon: Iconsax.heart5,
                          title: 'Danh sách yêu thích',
                          subTitle:
                              'Sản phẩm bạn đã thêm vào danh sách yêu thích',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const FavouriteScreen()),
                            );
                          },
                        ),
                        TSettingsMenuTitle(
                          icon: Iconsax.security_card,
                          title: 'Quyền riêng tư tài khoản',
                          subTitle: 'Quản lý sử dụng dữ liệu và kết nối',
                          onTap: () {},
                        ),
                        //app setting
                        const SizedBox(height: TSizes.spaceBtwSections),

                        const SizedBox(height: TSizes.spaceBtwSections),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () => SettingServices().logOut(context),
                            child: const Text('Đăng xuất'),
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections * 2.5),
                      ],
                    )
                  : Center(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(TTexts.signIn),
                          )),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
