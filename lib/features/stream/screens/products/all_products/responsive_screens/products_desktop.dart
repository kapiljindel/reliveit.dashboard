import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/data_table/table_header.dart';
import 'package:dashboard/features/stream/controllers/product/product_controller.dart';
import 'package:dashboard/features/stream/screens/products/all_products/table/products_table.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsDesktopScreen extends StatelessWidget {
  ProductsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      SeriesController(),
    ); // <--- this line is required!

    return Scaffold(
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TBreadcrumbsWithHeading(
                  heading: 'Products',
                  breadcrumbItems: ['Products'],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                TRoundedContainer(
                  child: Column(
                    children: [
                      TTableHeader(
                        buttonText: 'Add Product',
                        onPressed: () => Get.toNamed(TRoutes.createProduct),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      controller.seriesList.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : ProductsTable(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
