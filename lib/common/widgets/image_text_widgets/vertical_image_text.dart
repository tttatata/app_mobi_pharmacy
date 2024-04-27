import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/sizes.dart';
import 'package:app_mobi_pharmacy/util/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key,
    this.textColor = TColors.white,
    this.backgroundColor,
    required this.title,
    this.onTap,
    required this.image,
  });
  final Color textColor;
  final Color? backgroundColor;
  final String title;
  final String image;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems / 2),
        child: Container(
          // color: Colors.amber,
          width: 120,
          height: 550,
          child: Column(
            children: [
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Container(
                width: 100,
                height: 100,
                padding: const EdgeInsets.all(TSizes.sm),
                decoration: BoxDecoration(
                  color: backgroundColor ??
                      (THelperFunctions.isDarkMode(context)
                          ? TColors.black
                          : Color.fromARGB(255, 102, 133, 236)),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image(
                      image: NetworkImage(image),
                      fit: BoxFit.contain,
                      // color: dark ? TColors.light : TColors.dark,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: Color.fromARGB(255, 2, 13, 158)),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
