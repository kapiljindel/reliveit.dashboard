// ignore_for_file: unused_import, unused_local_variable

import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/features/stream/controllers/product/create_product_controller.dart';
import 'package:dashboard/features/stream/screens/products/create_products/widgets/additional_images.dart';
import 'package:dashboard/features/stream/screens/products/create_products/widgets/attributes_widget.dart';
import 'package:dashboard/features/stream/screens/products/create_products/widgets/bottom_navigation_widget.dart';
import 'package:dashboard/features/stream/screens/products/create_products/widgets/brand_widget.dart';
import 'package:dashboard/features/stream/screens/products/create_products/widgets/categories_widget.dart';
import 'package:dashboard/features/stream/screens/products/create_products/widgets/product_type_widget.dart';
import 'package:dashboard/features/stream/screens/products/create_products/widgets/stock_pricing_widget.dart';
import 'package:dashboard/features/stream/screens/products/create_products/widgets/thumbnail_widget.dart';
import 'package:dashboard/features/stream/screens/products/create_products/widgets/title_description.dart';
import 'package:dashboard/features/stream/screens/products/create_products/widgets/variations_widget.dart';
import 'package:dashboard/features/stream/screens/products/create_products/widgets/visibility_widget.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProductMobileScreen extends StatelessWidget {
  const CreateProductMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateProductController controller = Get.put(
      CreateProductController(),
    );

    return Scaffold(
      bottomNavigationBar: const ProductBottomNavigationButtons(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0), // smaller padding for mobile
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TBreadcrumbsWithHeading(
              returnToPreviousScreen: true,
              heading: 'Create Product',
              breadcrumbItems: [TRoutes.products, 'Create Product'],
            ),
            const SizedBox(height: 12),

            // Main Fields (Vertical Stack)
            ProductTitleAndDescription(),
            const SizedBox(height: 12),

            TRoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Video & Details',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  ProductStockAndPricing(),
                ],
              ),
            ),
            const SizedBox(height: 12),

            ProductVariations(),
            const SizedBox(height: 12),

            const ProductThumbnailImage(),
            const SizedBox(height: 12),

            TRoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'All Product Images',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  ProductAdditionalImages(
                    additionalProductImagesURLs: RxList<String>.empty(),
                    onTapToAddImages: () {},
                    onTapToRemoveImage: (index) {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            const ProductBrand(),
            const SizedBox(height: 12),
            const ProductCategories(),
            const SizedBox(height: 12),
            const ProductVisibilityWidget(),
            const SizedBox(height: 80), // Spacer for bottom nav
          ],
        ),
      ),
    );
  }
}
