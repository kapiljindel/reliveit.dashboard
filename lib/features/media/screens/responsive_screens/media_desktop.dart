import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/features/media/controllers/media_controller.dart';
import 'package:dashboard/features/media/screens/widgets/media_content.dart';
import 'package:dashboard/features/media/screens/widgets/media_uploader.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MediaDesktopScreen extends StatelessWidget {
  const MediaDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Breadcrumbs
                  const TBreadcrumbsWithHeading(
                    heading: 'Media',
                    breadcrumbItems: ['Media Screen'],
                  ),
                  // Toggle Images Section Button
                  SizedBox(
                    width: TSizes.buttonWidth * 1.5,
                    child: ElevatedButton.icon(
                      onPressed:
                          () =>
                              controller.showImagesUploaderSection.value =
                                  !controller.showImagesUploaderSection.value,
                      icon: const Icon(Iconsax.cloud_add, color: Colors.white),
                      label: const Text('Upload Images'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Upload Area
              const MediaUploader(),

              // Media
              MediaContent(
                allowMultipleSelection: false,
                allowSelection: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
