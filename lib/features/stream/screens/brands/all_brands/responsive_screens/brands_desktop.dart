import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/data_table/table_header.dart';
import 'package:dashboard/features/stream/controllers/brand/brand_controller.dart';
import 'package:dashboard/features/stream/screens/brands/all_brands/table/data_table.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandsDesktopScreen extends StatelessWidget {
  BrandsDesktopScreen({Key? key}) : super(key: key);

  final BrandController brandController = Get.put(BrandController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (brandController.brands.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TBreadcrumbsWithHeading(
                  heading: 'Brands',
                  breadcrumbItems: ['Brands'],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                TRoundedContainer(
                  child: Column(
                    children: [
                      TTableHeader(
                        buttonText: 'Create New Brand',
                        onPressed: () => Get.toNamed(TRoutes.createBrand),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      BrandTable(), // This should use the reactive list internally
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
