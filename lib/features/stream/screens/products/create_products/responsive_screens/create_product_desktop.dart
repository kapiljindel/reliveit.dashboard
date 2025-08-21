// ignore_for_file: unused_local_variable, unused_import

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
import 'package:dashboard/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get.dart';

class CreateProductDesktopScreen extends StatelessWidget {
  const CreateProductDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateProductController controller = Get.put(
      CreateProductController(),
    );

    return Scaffold(
      bottomNavigationBar: const ProductBottomNavigationButtons(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Create Product',
                breadcrumbItems: [TRoutes.products, 'Create Product'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Create Product
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: TDeviceUtils.isTabletScreen(context) ? 2 : 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Basic Information
                        ProductTitleAndDescription(),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // Stock & Pricing
                        TRoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Video & Details',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems),
                              //     const ProductTypeWidget(),
                              const SizedBox(
                                height: TSizes.spaceBtwInputFields,
                              ),
                              ProductStockAndPricing(),
                              const SizedBox(height: TSizes.spaceBtwSections),
                              //        const ProductAttributes(),
                            ],
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // Variations
                        ProductVariations(),
                      ],
                    ),
                  ),
                  const SizedBox(width: TSizes.defaultSpace),

                  // Sidebar
                  Expanded(
                    child: Column(
                      children: [
                        // Product Thumbnail
                        const ProductThumbnailImage(),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // Product Images
                        TRoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'All Product Images',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems),
                              ProductAdditionalImages(
                                additionalProductImagesURLs:
                                    RxList<String>.empty(),
                                onTapToAddImages: () {},
                                onTapToRemoveImage: (index) {},
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // Product Brand
                        const ProductBrand(),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // Product Categories
                        const ProductCategories(),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // Product Visibility
                        const ProductVisibilityWidget(),
                        const SizedBox(height: TSizes.spaceBtwSections),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
