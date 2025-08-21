import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/data_table/table_header.dart';
import 'package:dashboard/features/stream/controllers/category/category_controller.dart';
import 'package:dashboard/features/stream/screens/category/all_category/table/data_table.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // for Obx

class CategoriesDesktopScreen extends StatelessWidget {
  CategoriesDesktopScreen({Key? key}) : super(key: key);

  final CategoryController categoryController = Get.put(CategoryController());

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
                heading: 'Categories',
                breadcrumbItems: ['Categories'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              TRoundedContainer(
                child: Column(
                  children: [
                    TTableHeader(
                      buttonText: 'Create New Category',
                      onPressed: () => Get.toNamed(TRoutes.createCategory),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const CategoryTable(),
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
