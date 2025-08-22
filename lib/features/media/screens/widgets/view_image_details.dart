import 'package:clipboard/clipboard.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/features/media/models/image_model.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/utils/device/device_utility.dart';
import 'package:dashboard/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ImagePopup extends StatelessWidget {
  // The image model to display detailed information about.
  final ImageModel image;

  // Constructor for the ImagePopup class.
  const ImagePopup({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
        ),
        child: TRoundedContainer(
          // Set the width of the rounded container based on the screen size.
          width:
              TDeviceUtils.isDesktopScreen(context)
                  ? MediaQuery.of(context).size.width * 0.4
                  : double.infinity,
          padding: const EdgeInsets.all(TSizes.spaceBtwItems),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Display the image with an option to close the dialog.
              SizedBox(
                child: Stack(
                  children: [
                    // Display the image with rounded container.
                    TRoundedContainer(
                      backgroundColor: TColors.primaryBackground,
                      child: TRoundedImage(
                        image: image.url,
                        applyImageRadius: true,
                        height: MediaQuery.of(context).size.height * 0.4,
                        width:
                            TDeviceUtils.isDesktopScreen(context)
                                ? MediaQuery.of(context).size.width * 0.4
                                : double.infinity,
                        imageType: ImageType.network,
                      ),
                    ),

                    // Close icon button positioned at the top-right corner.
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Iconsax.close_circle),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Display various metadata about the image.
              /// Includes image name, path, type, size, creation and modification dates, and URL.

              // Image Name Row
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Image Name:',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      image.filename,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),

              // Image URL Row
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Image URL:',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      image.url,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        FlutterClipboard.copy(image.url).then(
                          (value) =>
                              TLoaders.customToast(message: 'URL copied!'),
                        );
                      },
                      child: const Text('Copy URL'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// Display a button to delete the image.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextButton(
                      onPressed: () {
                        // TODO: Implement delete logic here.
                      },
                      child: const Text(
                        'Delete Image',
                        style: TextStyle(color: Colors.red),
                      ),
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
