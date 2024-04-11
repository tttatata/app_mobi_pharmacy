import 'package:app_mobi_pharmacy/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:app_mobi_pharmacy/features/shop/views/sub_category/sub_category.dart';
import 'package:app_mobi_pharmacy/util/constans/category.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });
  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, SubCategoriesScreen.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      
      
      
      
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: Categories.categoryImages.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return TVerticalImageText(
            image: Categories.categoryImages[index]['image']!,
            title: Categories.categoryImages[index]['title']!,
            onTap: () => navigateToCategoryPage(
              context,
              Categories.categoryImages[index]['title']!,
            ),
          );
        },
      ),
    );
  }
}
