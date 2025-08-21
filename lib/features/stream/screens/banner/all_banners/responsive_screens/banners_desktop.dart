import 'package:dashboard/features/stream/controllers/banner/bannercontroller.dart';
import 'package:dashboard/features/stream/screens/banner/all_banners/table/data_tables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/common/widgets/data_table/table_header.dart';
import 'package:dashboard/routes/routes.dart';

class BannersDesktopScreen extends StatelessWidget {
  final BannerController bannerController = Get.put(BannerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (bannerController.banners.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TBreadcrumbsWithHeading(
                  heading: 'Banners',
                  breadcrumbItems: ['Banners'],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                TRoundedContainer(
                  child: Column(
                    children: [
                      TTableHeader(
                        buttonText: 'Create New Banner',
                        onPressed: () => Get.toNamed(TRoutes.createBanner),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      BannersTable(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
