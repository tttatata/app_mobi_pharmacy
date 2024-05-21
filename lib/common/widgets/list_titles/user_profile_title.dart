import 'package:app_mobi_pharmacy/common/widgets/images/t_circular_image.dart';
import 'package:app_mobi_pharmacy/common/widgets/provider/user_provider.dart';
import 'package:app_mobi_pharmacy/features/authentication/views/login/login.dart';
import 'package:app_mobi_pharmacy/features/personalization/views/profile/profile.dart';
import 'package:app_mobi_pharmacy/util/constans/colors.dart';
import 'package:app_mobi_pharmacy/util/constans/image_strings.dart';
import 'package:app_mobi_pharmacy/util/constans/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class TUSerProfileTitle extends StatelessWidget {
  const TUSerProfileTitle({
    super.key,
    this.onPressed,
  });
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>().user;
    final userchecked =
        Provider.of<UserProvider>(context).user.token.isNotEmpty;
    return ListTile(
      leading: userchecked
          ? TCircularImage(
              image: user.avatar!.url.isEmpty
                  ? TImages.user
                  : user.avatar!.url.toString(),
              isNetworkImage: user.avatar!.url.isEmpty ? false : true,
              height: 50,
              width: 50,
              padding: 5,
            )
          : Text(
              'Đăng nhập để tiếp tục',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: TColors.white),
            ),
      title: Text(
        user.name,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.white),
      ),
      subtitle: Text(
        user.email,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .apply(color: TColors.white),
      ),
      trailing: userchecked
          ? IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              },
              icon: const Icon(
                Iconsax.edit,
                color: TColors.white,
              ),
            )
          : Text(''),
    );
  }
}
