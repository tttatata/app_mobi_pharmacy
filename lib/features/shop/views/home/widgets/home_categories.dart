import 'package:app_mobi_pharmacy/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:app_mobi_pharmacy/features/authentication/models/Categories.dart';
import 'package:app_mobi_pharmacy/features/shop/views/sub_category/sub_category.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: category.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final item = category[index];
          return TVerticalImageText(
            image: item.imageUrl,
            title: item.title,
            onTap: () => Get.to(() => const SubCategoriesScreen()),
          );
        },
      ),
    );
  }
}
