/// Header
// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/common/widgets/layouts/headers/notification_screen.dart';
import 'package:dashboard/common/widgets/layouts/searchbar/universal_search.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dashboard/features/authentication/screens/login/form/firebase_auth_service.dart';

/// Static Header widget for the application
class THeader extends StatelessWidget implements PreferredSizeWidget {
  const THeader({super.key, this.scaffoldkey});

  final GlobalKey<ScaffoldState>? scaffoldkey;

  // Fetch user details from Firestore based on UID and role
  Future<Map<String, dynamic>?> fetchUserDetails() async {
    final stored = await FirebaseAuthService.getStoredUser();
    final uid = stored['uid'];
    final role = stored['role'];

    if (uid == null || role == null) return null;

    final doc =
        await FirebaseFirestore.instance.collection('users').doc(role).get();
    final data = doc.data();

    if (data == null || !data.containsKey(uid)) return null;

    return Map<String, dynamic>.from(data[uid]);
  }

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.transparent,
        elevation: 0,

        // Mobile Menu (only on Desktop)
        leading:
            !TDeviceUtils.isDesktopScreen(context)
                ? IconButton(
                  onPressed: () => scaffoldkey?.currentState?.openDrawer(),
                  icon: const Icon(Iconsax.menu),
                )
                : null,
        /*     // Orignal Code

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
                : null,*/

        //   AI Code
        // Search Field (only on Desktop)
        title:
            TDeviceUtils.isDesktopScreen(context)
                ? const SearchWithDropdown()
                : null,

        // Actions
        actions: [
          // Search Icon (only on Mobile)
          if (!TDeviceUtils.isDesktopScreen(context))
            IconButton(
              icon: const Icon(Iconsax.search_normal),
              onPressed: () {},
            ),

          // Gift Icon
          IconButton(
            icon: const Icon(Iconsax.gift),
            onPressed: () {
              showDialog(
                context: context,
                barrierColor: Colors.transparent,
                barrierDismissible: true,
                builder: (context) => ReportDropdown(),
              );
            },
          ),
          const SizedBox(width: TSizes.spaceBtwItems / 2),

          // Dark Icon
          IconButton(icon: const Icon(Iconsax.sun_1), onPressed: () {}),
          const SizedBox(width: TSizes.spaceBtwItems / 2),

          // Notification Icon
          IconButton(
            icon: const Icon(Iconsax.notification),
            onPressed: () {
              showDialog(
                context: context,
                barrierColor: Colors.transparent,
                barrierDismissible: true,
                builder: (context) => ReportDropdown(),
              );
            },
          ),
          const SizedBox(width: TSizes.spaceBtwItems / 2),

          // Dynamic User Info
          FutureBuilder<Map<String, dynamic>?>(
            future: fetchUserDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              }

              if (!snapshot.hasData) {
                return const Text('User not found');
              }

              final user = snapshot.data!;
              final displayName = user['displayName'] ?? 'No Name';
              final email = user['email'] ?? 'No Email';
              final image = user['imageUrl'] ?? TImages.user;

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: SizedBox(
                      width: 38,
                      height: 35,
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.error, size: 40),
                      ),
                    ),
                  ),

                  /*
 Original image Container
                  TRoundedImage(
                    width: 40,
                    height: 40,
                    padding: 2,
                    imageType: ImageType.network,
                    isCircular: true, // <-- this is key!
                    image: image,
                  ),
*/
                  const SizedBox(width: TSizes.sm),
                  if (!TDeviceUtils.isMobileScreen(context))
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          email,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(TDeviceUtils.getAppBarHeight() + 15);
}
