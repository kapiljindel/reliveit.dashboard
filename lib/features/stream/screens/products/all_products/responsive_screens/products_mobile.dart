import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/data_table/table_header.dart';
import 'package:dashboard/features/stream/screens/products/all_products/table/products_table.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsMobileScreen extends StatelessWidget {
  const ProductsMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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

              // Table Body
              TRoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    TTableHeader(
                      buttonText: 'Add Product',
                      onPressed: () => Get.toNamed(TRoutes.createProduct),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    // Table
                    ProductsTable(),
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
