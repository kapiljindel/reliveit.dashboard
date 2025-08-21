import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/features/stream/controllers/product/create_product_controller.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductThumbnailImage extends StatelessWidget {
  const ProductThumbnailImage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateProductController>();

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            'Product Thumbnail',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // Image preview and URL input
          TRoundedContainer(
            height: 300,
            backgroundColor: TColors.primaryBackground,
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🔹 Live Image Preview
                  Expanded(
                    child: Obx(() {
                      final imageUrl = controller.thumbnailUrl.value;
                      if (imageUrl.isNotEmpty) {
                        return TRoundedImage(
                          width: 220,
                          height: 220,
                          image: imageUrl,
                          imageType: ImageType.network,
                        );
                      } else {
                        return const TRoundedImage(
                          width: 220,
                          height: 220,
                          image: TImages.defaultSingleImageIcon,
                          imageType: ImageType.asset,
                        );
                      }
                    }),
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),

                  // 🔹 Image URL Input Field
                  TextFormField(
                    initialValue: controller.thumbnailUrl.value,
                    onChanged: (value) => controller.thumbnailUrl.value = value,
                    decoration: const InputDecoration(
                      labelText: 'Thumbnail Image URL',
                      hintText: 'Paste image URL here...',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
