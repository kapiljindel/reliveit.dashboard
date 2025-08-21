import 'package:dashboard/common/widgets/images/t_circular_image.dart';
import 'package:dashboard/common/widgets/layouts/sidebars/menu/menu_items.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class TSidebar extends StatelessWidget {
  const TSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: const BoxDecoration(
          color: TColors.white,
          border: Border(right: BorderSide(color: TColors.grey, width: 1)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image
              const TCircularImage(
                width: 100,
                height: 100,
                image: TImages.darkAppLogo,
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Menu Section Title
              Padding(
                padding: const EdgeInsets.all(TSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'MENU',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.apply(letterSpacingDelta: 1.2),
                    ),

                    //Menu  Items
                    const TMenuItem(
                      route: TRoutes.dashboard,
                      icon: Iconsax.status,
                      itemName: 'Dashboard',
                    ),
                    const TMenuItem(
                      route: TRoutes.media,
                      icon: Iconsax.image,
                      itemName: 'Media',
                    ),
                    const TMenuItem(
                      route: TRoutes.banners,
                      icon: Iconsax.picture_frame,
                      itemName: 'Banners',
                    ),
                    const TMenuItem(
                      route: TRoutes.products,
                      icon: Iconsax.box,
                      itemName: 'Series',
                    ),
                    const TMenuItem(
                      route: TRoutes.categories,
                      icon: Iconsax.category,
                      itemName: 'Categories',
                    ),
                    const TMenuItem(
                      route: TRoutes.brands,
                      icon: Iconsax.dcube,
                      itemName: 'Studios',
                    ),
                    const TMenuItem(
                      route: TRoutes.customers,
                      icon: Iconsax.profile_2user,
                      itemName: 'Customers',
                    ),
                    const TMenuItem(
                      route: TRoutes.orders,
                      icon: Iconsax.video_square,
                      itemName: 'Orders',
                    ),
                    const TMenuItem(
                      route: TRoutes.reports,
                      icon: Iconsax.warning_2,
                      itemName: 'Reports',
                    ),
                    Text(
                      'Others',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.apply(letterSpacingDelta: 1.2),
                    ),
                    const TMenuItem(
                      route: TRoutes.servers,
                      icon: Iconsax.layer,
                      itemName: 'Servers',
                    ),

                    TMenuItem(
                      route: TRoutes.profile,
                      icon: Iconsax.profile1,
                      itemName: 'Profile',
                    ),

                    //Others  Items
                    const TMenuItem(
                      route: TRoutes.settings,
                      icon: Iconsax.candle_2,
                      itemName: 'Settings',
                    ),
                    const TMenuItem(
                      route: TRoutes.logout,
                      icon: Iconsax.logout,
                      itemName: 'Logout',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
