import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/common/widgets/loaders/animation_loader.dart';
import 'package:dashboard/common/widgets/loaders/loader_animation.dart';
import 'package:dashboard/features/media/controllers/media_controller.dart';
import 'package:dashboard/features/media/models/image_model.dart';
import 'package:dashboard/features/media/screens/widgets/folder_dropdown.dart';
import 'package:dashboard/features/media/screens/widgets/view_image_details.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MediaContent extends StatelessWidget {
  const MediaContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Media Images Header
          SizedBox(height: TSizes.spaceBtwSections),

          // Folders Dropdown
          Row(
            children: [
              Text(
                'Select Folder',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              MediaFolderDropdown(
                onChanged: (MediaCategory? newValue) {
                  if (newValue != null) {
                    controller.selectedPath.value = newValue;
                    controller.getMediaImages();
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          /// Show Media
          Obx(() {
            List<ImageModel> images = _getSelectedFolderImages(controller);

            /// Loader
            if (controller.loading.value && images.isEmpty)
              return const TLoaderAnimation();

            // Empty Widget
            if (images.isEmpty) return _buildEmptyAnimationWidget(context);

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: TSizes.spaceBtwItems / 2,
                  runSpacing: TSizes.spaceBtwItems / 2,
                  children:
                      images
                          .map(
                            (image) => GestureDetector(
                              onTap:
                                  () => Get.dialog(
                                    ImagePopup(image: image),
                                  ), // Handle tap
                              child: SizedBox(
                                width: 140,
                                height: 180,
                                child: Column(
                                  children: [
                                    _buildSimpleList(
                                      image,
                                    ), // Likely the image preview widget
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: TSizes.sm,
                                        ),
                                        child: Text(
                                          image.filename,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),

                /// Load More Media Button
                if (!controller.loading.value)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: TSizes.spaceBtwSections,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: TSizes.buttonWidth,
                          child: ElevatedButton.icon(
                            onPressed: () => controller.loadMoreMediaImages(),
                            label: const Text('Load More'),
                            icon: const Icon(
                              Iconsax.arrow_down,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  List<ImageModel> _getSelectedFolderImages(MediaController controller) {
    List<ImageModel> images = [];
    if (controller.selectedPath.value == MediaCategory.banners) {
      images =
          controller.allBannerImages
              .where((image) => image.url.isNotEmpty)
              .toList();
    } else if (controller.selectedPath.value == MediaCategory.brands) {
      images =
          controller.allBrandImages
              .where((image) => image.url.isNotEmpty)
              .toList();
    } else if (controller.selectedPath.value == MediaCategory.categories) {
      images =
          controller.allCategoryImages
              .where((image) => image.url.isNotEmpty)
              .toList();
    } else if (controller.selectedPath.value == MediaCategory.products) {
      images =
          controller.allProductImages
              .where((image) => image.url.isNotEmpty)
              .toList();
    } else if (controller.selectedPath.value == MediaCategory.users) {
      images =
          controller.allUserImages
              .where((image) => image.url.isNotEmpty)
              .toList();
    }
    return images;
  }

  Widget _buildEmptyAnimationWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.lg * 3),
      child: TAnimationLoaderWidget(
        width: 300,
        height: 300,
        text: 'Select your Desired Folder',
        animation: TImages.packageAnimation,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildSimpleList(ImageModel image) {
    return TRoundedImage(
      width: 140,
      height: 140,
      padding: TSizes.sm,
      image: image.url,
      imageType: ImageType.network,
      margin: TSizes.spaceBtwItems / 2,
      backgroundColor: TColors.primaryBackground,
    );
  }
}
