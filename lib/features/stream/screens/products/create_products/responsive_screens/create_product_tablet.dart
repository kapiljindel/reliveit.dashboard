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

class CreateProductTabletScreen extends StatelessWidget {
  const CreateProductTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateProductController controller = Get.put(
      CreateProductController(),
    );

    return Scaffold(
      bottomNavigationBar: const ProductBottomNavigationButtons(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0), // medium padding for tablet
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TBreadcrumbsWithHeading(
              returnToPreviousScreen: true,
              heading: 'Create Product',
              breadcrumbItems: [TRoutes.products, 'Create Product'],
            ),
            const SizedBox(height: 16),

            // Main Fields
            ProductTitleAndDescription(),
            const SizedBox(height: 16),

            TRoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Video & Details',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  ProductStockAndPricing(),
                ],
              ),
            ),
            const SizedBox(height: 16),

            ProductVariations(),
            const SizedBox(height: 16),

            const ProductThumbnailImage(),
            const SizedBox(height: 16),

            TRoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'All Product Images',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  ProductAdditionalImages(
                    additionalProductImagesURLs: RxList<String>.empty(),
                    onTapToAddImages: () {},
                    onTapToRemoveImage: (index) {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            const ProductBrand(),
            const SizedBox(height: 16),
            const ProductCategories(),
            const SizedBox(height: 16),
            const ProductVisibilityWidget(),
            const SizedBox(height: 100), // bottom space for nav buttons
          ],
        ),
      ),
    );
  }
}



/*import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/common/widgets/images/image_uploader.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CreateProductTabletScreen extends StatelessWidget {
  const CreateProductTabletScreen({super.key});

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
                returnToPreviousScreen: true,
                heading: 'Create Product',
                breadcrumbs: [TRoutes.products, 'Create Product'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Thumbnail
              const TImageUploader(
                title: 'Add Thumbnail',
                imageUrl: TImages.productImage,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Additional Images
              const AdditionalImagesWidget(),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Brand
              const TBrandDropdown(),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Category
              const TCategoryDropdown(),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Visibility
              const TVisibilityToggle(),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Title
              const TFormHeader(title: 'Basic Information'),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TAttributeTextField(title: 'Product Title'),
              const TAttributeTextField(title: 'Product Description'),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Stock & Pricing
              const TFormHeader(title: 'Stock & Pricing'),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TStockPricingWidget(),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Product Attributes
              const TFormHeader(title: 'Add Product Attributes'),
              const AttributeTextFieldWidget(),
              const ProductAttributesWidget(),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Save Button
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    // Save logic
                  },
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/