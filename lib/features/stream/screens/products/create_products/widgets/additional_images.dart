import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/images/image_uploader.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages({
    super.key,
    required this.additionalProductImagesURLs,
    required this.onTapToAddImages,
    required this.onTapToRemoveImage,
  });

  final RxList<String> additionalProductImagesURLs;
  final void Function()? onTapToAddImages;
  final void Function(int index) onTapToRemoveImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          // Section to Add Additional Product Images
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: onTapToAddImages,
              child: TRoundedContainer(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        TImages.defaultMultiImageIcon,
                        width: 50,
                        height: 50,
                      ),
                      const Text('Add Additional Product Images'),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Section to Display Uploaded Images
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 80,
                    child: _uploadedImagesOrEmptyList(),
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwItems / 2),

                // Add More Images Button
                TRoundedContainer(
                  width: 80,
                  height: 80,
                  showBorder: true,
                  borderColor: TColors.grey,
                  backgroundColor: TColors.white,
                  onTap: onTapToAddImages,
                  child: const Center(child: Icon(Iconsax.add)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget to Display Either Uploaded Images or Empty List
  Widget _uploadedImagesOrEmptyList() {
    return additionalProductImagesURLs.isEmpty
        ? emptyList()
        : _uploadedImages();
  }

  // Widget to Display Empty List Placeholder
  Widget emptyList() {
    return ListView.separated(
      itemCount: 6,
      scrollDirection: Axis.horizontal,
      separatorBuilder:
          (context, index) => const SizedBox(width: TSizes.spaceBtwItems / 2),
      itemBuilder:
          (context, index) => const TRoundedContainer(
            backgroundColor: TColors.primaryBackground,
            width: 80,
            height: 80,
          ),
    );
  }

  // Widget to Display Uploaded Images
  ListView _uploadedImages() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: additionalProductImagesURLs.length,
      separatorBuilder:
          (context, index) => const SizedBox(width: TSizes.spaceBtwItems / 2),
      itemBuilder: (context, index) {
        final image = additionalProductImagesURLs[index];
        return TImageUploader(
          top: 0,
          right: 0,
          width: 80,
          height: 80,
          left: null,
          bottom: null,
          image: image,
          icon: Iconsax.trash,
          imageType: ImageType.network,
          onIconButtonPressed: () => onTapToRemoveImage(index),
        );
      },
    );
  }
}
