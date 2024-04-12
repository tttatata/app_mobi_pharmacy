import 'package:app_mobi_pharmacy/features/shop/views/search/search_product.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/device/device_utility.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TSearchContainer extends StatefulWidget {
  const TSearchContainer({
    super.key,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onSearch,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
  });

  final IconData? icon;
  final bool showBackground, showBorder;
  final Function(String)? onSearch;
  final EdgeInsetsGeometry padding;

  @override
  _TSearchContainerState createState() => _TSearchContainerState();
}

class _TSearchContainerState extends State<TSearchContainer> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String lastSearch = '';
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void navigateToSearchScreen(String query) {
    setState(() {
      lastSearch = query; // Cập nhật giá trị tìm kiếm cuối cùng
    });
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () {
        if (widget.onSearch != null) {
          widget.onSearch!(_searchController.text);
        }
      },
      child: Padding(
        padding: widget.padding,
        child: Container(
          width: TDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
            color: widget.showBackground
                ? dark
                    ? TColors.dark
                    : TColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            border: widget.showBorder ? Border.all(color: TColors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: TColors.darkGrey),
              const SizedBox(width: TSizes.spaceBtwItems),
              // Thêm TextField vào đây
              Expanded(
                child: TextField(
                  focusNode: _focusNode,
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: lastSearch.isEmpty
                        ? 'Tìm kiếm...'
                        : lastSearch, // Sử dụng giá trị tìm kiếm cuối cùng làm hintText
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                  onSubmitted: navigateToSearchScreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
