// ignore_for_file: avoid_print, unused_local_variable, deprecated_member_use
import 'dart:typed_data';

import 'package:dashboard/features/media/models/image_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/utils/device/device_utility.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/features/media/controllers/media_controller.dart';
import 'package:dashboard/features/media/screens/widgets/folder_dropdown.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;

    return Obx(
      () =>
          controller.showImagesUploaderSection.value
              ? Column(
                children: [
                  /// Drag and Drop Area
                  TRoundedContainer(
                    height: 250,
                    showBorder: true,
                    borderColor: TColors.borderPrimary,
                    backgroundColor: TColors.primaryBackground,
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              /// Drop Zone
                              DropzoneView(
                                mime: const ['image/jpeg', 'image/png'],
                                cursor: CursorType.Default,
                                operation: DragOperation.copy,
                                onLoaded: () => print('Zone loaded'),
                                onError: (ev) => print('Zone error: $ev'),
                                onHover: () => print('Zone hovered'),
                                onLeave: () => print('Zone left'),
                                onCreated:
                                    (ctrl) =>
                                        controller.dropzoneController = ctrl,
                                onDropInvalid:
                                    (ev) => print('Zone invalid MIME: $ev'),
                                onDropMultiple:
                                    (ev) => print('Zone drop multiple: $ev'),

                                /// ✅ FIXED onDrop handler
                                onDrop: (file) async {
                                  try {
                                    final dropzoneFile =
                                        file as DropzoneFileInterface;

                                    final bytes = await controller
                                        .dropzoneController
                                        .getFileData(dropzoneFile);

                                    final image = ImageModel(
                                      url: '',
                                      file: dropzoneFile,
                                      folder: '',
                                      filename: dropzoneFile.name,
                                      localImageToDisplay: Uint8List.fromList(
                                        bytes,
                                      ),
                                    );

                                    controller.selectedImagesToUpload.add(
                                      image,
                                    );
                                  } catch (e) {
                                    print('Drop failed: $e');
                                  }
                                },
                              ),

                              /// Drop Zone Content UI
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    TImages.defaultMultiImageIcon,
                                    width: 50,
                                    height: 50,
                                  ),
                                  const SizedBox(height: TSizes.spaceBtwItems),
                                  const Text("Drag and Drop Images here"),
                                  const SizedBox(height: TSizes.spaceBtwItems),
                                  OutlinedButton(
                                    onPressed:
                                        () => controller.selectLocalImages(),
                                    child: const Text("Select Images"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Selected Images Display
                  if (controller.selectedImagesToUpload.isNotEmpty)
                    TRoundedContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Folder + Actions Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// Folder Dropdown
                              Row(
                                children: [
                                  Text(
                                    'Select Folder',
                                    style:
                                        Theme.of(
                                          context,
                                        ).textTheme.headlineSmall,
                                  ),
                                  const SizedBox(width: TSizes.spaceBtwItems),
                                  MediaFolderDropdown(
                                    onChanged: (MediaCategory? newValue) {
                                      if (newValue != null) {
                                        controller.selectedPath.value =
                                            newValue;
                                      }
                                    },
                                  ),
                                ],
                              ),

                              /// Remove & Upload Buttons
                              Row(
                                children: [
                                  TextButton(
                                    onPressed:
                                        () =>
                                            controller.selectedImagesToUpload
                                                .clear(),
                                    child: const Text('Remove All'),
                                  ),
                                  const SizedBox(width: TSizes.spaceBtwItems),
                                  TDeviceUtils.isMobileScreen(context)
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                        width: TSizes.buttonWidth,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // TODO: Add upload function
                                          },
                                          child: const Text('Upload'),
                                        ),
                                      ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: TSizes.spaceBtwSections),

                          /// Display Image Thumbnails
                          /// Display Image Thumbnails
                          Wrap(
                            alignment: WrapAlignment.start,
                            spacing: TSizes.spaceBtwItems / 2,
                            runSpacing: TSizes.spaceBtwItems / 2,
                            children:
                                controller.selectedImagesToUpload
                                    .where(
                                      (image) =>
                                          image.localImageToDisplay != null,
                                    )
                                    .map(
                                      (element) => Stack(
                                        children: [
                                          TRoundedImage(
                                            width: 90,
                                            height: 90,
                                            padding: TSizes.sm,
                                            imageType: ImageType.memory,
                                            memoryImage:
                                                element.localImageToDisplay,
                                            backgroundColor:
                                                TColors.primaryBackground,
                                          ),

                                          /// ❌ Remove Button
                                          Positioned(
                                            top: 4,
                                            right: 4,
                                            child: GestureDetector(
                                              onTap: () {
                                                controller
                                                    .selectedImagesToUpload
                                                    .remove(element);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.black54,
                                                  shape: BoxShape.circle,
                                                ),
                                                padding: const EdgeInsets.all(
                                                  4,
                                                ),
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                          ),

                          const SizedBox(height: TSizes.spaceBtwSections),

                          /// Mobile Upload Button
                          TDeviceUtils.isMobileScreen(context)
                              ? SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // TODO: Add upload function
                                  },
                                  child: const Text('Upload'),
                                ),
                              )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),

                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              )
              : const SizedBox.shrink(),
    );
  }
}
