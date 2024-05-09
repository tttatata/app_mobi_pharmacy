import 'package:app_mobi_pharmacy/common/widgets/appbar/appbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/appbar/tabbar.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/ratings/rating_indicator.dart';
import 'package:app_mobi_pharmacy/features/shop/views/category/widgets/category_tab.dart';
import 'package:app_mobi_pharmacy/features/shop/views/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:app_mobi_pharmacy/features/shop/views/review/widget/reviewTab.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});
  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  void initState() {
    super.initState();
  }

  List items = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            'Đánh giá sản phẩm',
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
                        : Color.fromARGB(255, 255, 255, 255),
                    expandedHeight: 0,
                    bottom: TTabBar(tabs: [
                      Tab(child: Text('Sản phẩm chưa đánh giá')),
                      Tab(child: Text('Sản phẩm đã dánh giá')),
                    ]))
              ];
            },
            body: TabBarView(
              children: [
                TReviewTabs(reviewStatus: 'Sản phẩm chưa đánh giá'),
                TReviewTabs(reviewStatus: 'Sản phẩm đã dánh giá'),
              ],
            )),
      ),
    );
  }
}
