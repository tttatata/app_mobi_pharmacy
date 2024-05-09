import 'package:app_mobi_pharmacy/common/widgets/layouts/grid_layout.dart';
import 'package:app_mobi_pharmacy/common/widgets/loaders/loader_page.dart';
import 'package:app_mobi_pharmacy/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Product.dart';
import 'package:app_mobi_pharmacy/features/shop/controllers/sub_category.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dvhcvn/dvhcvn.dart';

class TSortableProducts extends StatefulWidget {
  final List<Product>? productList;
  // final SubCategoryController subCategoryController;

  TSortableProducts({
    Key? key,
    required this.productList,
    // required this.subCategoryController,
  }) : super(key: key);

  @override
  _TSortableProductsState createState() => _TSortableProductsState();
}

class _TSortableProductsState extends State<TSortableProducts> {
  String? selectedSortOption;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final locale = 'vi_VN'; // Xác định locale cho tiếng Việt ở Việt Nam
    return Column(
      children: [
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: selectedSortOption,
          onChanged: (value) {
            setState(() {
              selectedSortOption = value;
              _sortProducts();
            });
          },
          items: [
            'Tên: a-Z',
            'Tên: z-a',
            'Tiền tăng',
            'Tiền giảm',
            'Bán chạy',
          ].map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        // Hiển thị danh sách sản phẩm
        if (widget.productList == null)
          Center(child: Loader())
        else if (widget.productList!.isEmpty)
          Center(child: Text('Không có sản phẩm loại này'))
        else if (isLoading)
          Center(child: Loader()) // Hiển thị loading
        else
          SingleChildScrollView(
            child: Column(
              children: [
                TGidLayout(
                    itemCount: widget.productList!.length,
                    itemBuilder: (context, index) {
                      final product = widget.productList![index];
                      return TProductCardVertical(product: product);
                    }),
              ],
            ),
          ),
      ],
    );
  }

  void _sortProducts() async {
    setState(() {
      isLoading = true;
    });
    // Thực hiện sắp xếp (ví dụ: sử dụng Future.delayed để giả lập việc sắp xếp)
    await Future.delayed(Duration(seconds: 1));
    // Thực hiện sắp xếp
    if (selectedSortOption == 'Tên: a-z') {
      widget.productList!.sort((a, b) => a.name.compareTo(
            b.name,
          ));
    } else if (selectedSortOption == 'Tên: z-a') {
      widget.productList!.sort((a, b) => b.name.compareTo(a.name));
    } else if (selectedSortOption == 'Tiền tăng') {
      widget.productList!
          .sort((a, b) => (a.sellPrice ?? 0).compareTo(b.sellPrice ?? 0));
      // Sắp xếp theo giá thấp hơn
    } else if (selectedSortOption == 'Tiền giảm') {
      widget.productList!
          .sort((a, b) => (b.sellPrice ?? 0).compareTo(a.sellPrice ?? 0));
      // Sắp xếp theo giá thấp hơn
    } else if (selectedSortOption == 'Bán chạy') {
      widget.productList!
          .sort((a, b) => (b.sold_out ?? 0).compareTo(a.sold_out ?? 0));
      // Sắp xếp theo giá thấp hơn
    }

    /// Thêm các trường hợp sắp xếp khác tùy theo yêu cầu

    setState(() {
      isLoading = false;
    });
  }
}
