// ignore_for_file: unused_import

import 'package:dashboard/features/stream/controllers/product/create_product_controller.dart';
import 'package:dashboard/features/stream/screens/products/create_products/widgets/stock_pricing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/images/image_uploader.dart';
import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';

class ProductVariations extends StatelessWidget {
  const ProductVariations({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateProductController>();

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Variations',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextButton(
                onPressed: controller.clearSubProducts,
                child: const Text('Remove Variations'),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          /// 🔹 Variation List
          Obx(() {
            if (controller.subProducts.isEmpty) {
              return _buildNoVariationsMessage();
            }

            return ListView.separated(
              itemCount: controller.subProducts.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder:
                  (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
              itemBuilder: (_, index) {
                final item = controller.subProducts[index];

                return ExpansionTile(
                  backgroundColor: TColors.lightGrey,
                  collapsedBackgroundColor: TColors.lightGrey,
                  childrenPadding: const EdgeInsets.all(TSizes.md),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
                  ),
                  title: Text('Series: ${item['series']}'),
                  subtitle: Text('Title: ${item['title']}'),

                  /// 🧾 Form fields when expanded
                  children: [
                    // 🔘 Optionally preload form with this item's data
                    ProductStockAndPricing(),

                    /// 🔘 Remove button
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () => controller.removeSubProduct(index),
                        icon: const Icon(Icons.delete, color: Colors.red),
                        label: const Text(
                          'Remove',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }),
        ],
      ),
    );
  }

  /// Empty message
  Widget _buildNoVariationsMessage() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TRoundedImage(
              width: 200,
              height: 200,
              imageType: ImageType.asset,
              image: TImages.defaultVariationImageIcon,
            ),
          ],
        ),
        SizedBox(height: TSizes.spaceBtwItems),
        Text('There are No Variable Items'),
      ],
    );
  }
}
