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
  MediaContent({
    super.key,
    required this.allowSelection,
    required this.allowMultipleSelection,
    this.alreadySelectedUrls,
    this.onImagesSelected,
  });

  final bool allowSelection;
  final bool allowMultipleSelection;
  final List<String>? alreadySelectedUrls;
  final List<ImageModel> selectedImages = [];
  final Function(List<ImageModel> selectedImages)? onImagesSelected;

  @override
  Widget build(BuildContext context) {
    bool loadedPreviousSelection = false;
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

              if (allowSelection) buildAddSelectedImagesButton(),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          /// Show Media
          //  Obx(() {
          //  List<ImageModel> images = _getSelectedFolderImages(controller);
          Obx(() {
            // Get Selected Folder Images
            List<ImageModel> images = _getSelectedFolderImages(controller);

            // Load Selected Images from the Already Selected Images only once otherwise
            // on Obx() rebuild UI first images will be selected then will auto unCheck.
            if (!loadedPreviousSelection) {
              if (alreadySelectedUrls != null &&
                  alreadySelectedUrls!.isNotEmpty) {
                // Convert alreadySelectedUrls to a Set for faster lookup
                final selectedUrlsSet = Set<String>.from(alreadySelectedUrls!);

                for (var image in images) {
                  image.isSelected.value = selectedUrlsSet.contains(image.url);
                  if (image.isSelected.value) {
                    selectedImages.add(image);
                  }
                }
              } else {
                // If alreadySelectedUrls is null or empty, set all images to not selected
                for (var image in images) {
                  image.isSelected.value = false;
                }
              }
              loadedPreviousSelection = true;
            }

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
                                    allowSelection
                                        ? _buildListWithCheckbox(image)
                                        : _buildSimpleList(
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

  Widget _buildListWithCheckbox(ImageModel image) {
    return Stack(
      children: [
        TRoundedImage(
          width: 140,
          height: 140,
          padding: TSizes.sm,
          image: image.url,
          imageType: ImageType.network,
          margin: TSizes.spaceBtwItems / 2,
          backgroundColor: TColors.primaryBackground,
        ),

        Positioned(
          top: TSizes.md,
          right: TSizes.md,
          child: Obx(
            () => Checkbox(
              value: image.isSelected.value,
              onChanged: (selected) {
                if (selected != null) {
                  image.isSelected.value = selected;

                  if (selected) {
                    if (!allowMultipleSelection) {
                      // If multiple selection is not allowed, uncheck other checkboxes
                      for (var otherImage in selectedImages) {
                        if (otherImage != image) {
                          otherImage.isSelected.value = false;
                        }
                      }
                      selectedImages.clear();
                    }
                    selectedImages.add(image);
                  } else {
                    selectedImages.remove(image);
                  }

                  // Optional: Call the callback if provided
                  //     if (onImagesSelected != null) {
                  //     onImagesSelected!(selectedImages);
                  // }
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAddSelectedImagesButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Close Button
        SizedBox(
          width: 120,
          child: OutlinedButton.icon(
            label: const Text('Close'),
            icon: const Icon(Iconsax.close_circle),
            onPressed: () => Get.back(),
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        SizedBox(
          width: 120,
          child: ElevatedButton.icon(
            label: const Text('Add'),
            icon: const Icon(Iconsax.image),
            onPressed: () => Get.back(result: selectedImages),
          ),
        ),
      ],
    );
  }
}
