import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/data_table/table_header.dart';
import 'package:dashboard/features/stream/screens/banner/all_banners/table/data_tables.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannersMobileScreen extends StatelessWidget {
  const BannersMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbsWithHeading(
                heading: 'Banners',
                breadcrumbItems: ['Banners'],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              TRoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    TTableHeader(
                      buttonText: 'Create New Banner',
                      onPressed: () => Get.toNamed(TRoutes.createBanner),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    // Table
                    BannersTable(),
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
