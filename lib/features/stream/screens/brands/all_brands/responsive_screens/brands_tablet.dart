import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/data_table/table_header.dart';
import 'package:dashboard/features/stream/controllers/brand/brand_controller.dart';
import 'package:dashboard/features/stream/screens/brands/all_brands/table/data_table.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandsTabletScreen extends StatelessWidget {
  BrandsTabletScreen({Key? key}) : super(key: key);

  final BrandController brandController = Get.put(BrandController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (brandController.brands.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24), // medium padding on tablet
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBreadcrumbsWithHeading(
                heading: 'Brands',
                breadcrumbItems: ['Brands'],
              ),
              const SizedBox(height: 16), // medium spacing on tablet
              TRoundedContainer(
                child: Column(
                  children: [
                    TTableHeader(
                      buttonText: 'Create New Brand',
                      onPressed: () => Get.toNamed(TRoutes.createBrand),
                    ),
                    const SizedBox(height: 12), // medium spacing
                    BrandTable(),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
