import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
//import 'package:dashboard/common/widgets/layouts/headers/notification_screen.dart';
import 'package:dashboard/common/widgets/shimmers/shimmer.dart';
import 'package:dashboard/common/widgets/layouts/headers/user_controller.dart'
    as header_user;
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';

/// Header widget for the application
class THeader extends StatelessWidget implements PreferredSizeWidget {
  const THeader({super.key, this.scaffoldkey});

  final GlobalKey<ScaffoldState>? scaffoldkey;

  @override
  Widget build(BuildContext context) {
    final controller = header_user.HeaderUserController.instance;

    return Container(
      decoration: const BoxDecoration(
        color: TColors.white,
        border: Border(bottom: BorderSide(color: TColors.grey, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.md,
        vertical: TSizes.sm,
      ),
      child: AppBar(
        // Mobile Menu  (only on Desktop)
        leading:
            !TDeviceUtils.isDesktopScreen(context)
                ? IconButton(
                  onPressed: () => scaffoldkey?.currentState?.openDrawer(),
                  icon: const Icon(Iconsax.menu),
                )
                : null,

        // Search Field (only on Desktop)
        title:
            TDeviceUtils.isDesktopScreen(context)
                ? SizedBox(
                  width: 480,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.search_normal),
                      hintText: 'Search anything...',
                    ),
                  ),
                )
                : null,

        // Actions
        actions: [
          // Search Icon (only on Mobile)
          if (!TDeviceUtils.isDesktopScreen(context))
            IconButton(
              icon: const Icon(Iconsax.search_normal),
              onPressed: () {},
            ),

          // Notification Icon
          IconButton(
            icon: const Icon(Iconsax.notification),
            onPressed: () {
              //   showDialog(
              //   context: context,
              //     barrierColor: Colors.transparent,
              //   barrierDismissible: true,
              //     builder: (context) => const NotificationDropdown(),
              //   );
            },
          ),
          const SizedBox(width: TSizes.spaceBtwItems / 2),

          // User Info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar Image
              Obx(
                () => TRoundedImage(
                  width: 40,
                  height: 40,
                  padding: 2,
                  imageType:
                      controller.user.value.imageUrl.isNotEmpty
                          ? ImageType.network
                          : ImageType.asset,
                  image:
                      controller.user.value.imageUrl.isNotEmpty
                          ? controller.user.value.imageUrl
                          : TImages.user,
                ),
              ),
              const SizedBox(width: TSizes.sm),

              // Name + Email (only on non-mobile)
              if (!TDeviceUtils.isMobileScreen(context))
                Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.loading.value
                          ? const TShimmerEffect(width: 50, height: 13)
                          : Text(
                            controller.user.value.displayName,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                      controller.loading.value
                          ? const TShimmerEffect(width: 50, height: 13)
                          : Text(
                            controller.user.value.email,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(TDeviceUtils.getAppBarHeight() + 15);
}
