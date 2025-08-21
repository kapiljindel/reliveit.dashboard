// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/features/stream/screens/order/edit_orders/widgets/thumbnail_widget.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

// Your VideoItem model (reuse from your code)
class VideoItem {
  final String videoId;
  final String title;
  final String releaseDate;
  final String videoUrl;
  final String series;
  final String parent;
  final String thumbnail;

  VideoItem({
    required this.videoId,
    required this.title,
    required this.releaseDate,
    required this.videoUrl,
    required this.series,
    required this.parent,
    required this.thumbnail,
  });
}

// CreateVideoItemController with Rx fields
class CreateVideoItemController extends GetxController {
  var videoId = ''.obs;
  var title = ''.obs;
  var releaseDate = ''.obs;
  var series = ''.obs;
  var videoUrl = ''.obs;
  var parent = ''.obs;
  var thumbnail = ''.obs;

  var isLoading = false.obs;

  bool validate() {
    return videoId.value.isNotEmpty &&
        title.value.isNotEmpty &&
        releaseDate.value.isNotEmpty &&
        series.value.isNotEmpty &&
        videoUrl.value.isNotEmpty &&
        parent.value.isNotEmpty;
  }

  Future<void> createVideoItem() async {
    if (!validate()) {
      throw Exception('Please fill all required fields');
    }

    isLoading.value = true;

    final newItem = VideoItem(
      videoId: videoId.value,
      title: title.value,
      releaseDate: releaseDate.value,
      series: series.value,
      videoUrl: videoUrl.value,
      parent: parent.value,
      thumbnail: thumbnail.value,
    );

    try {
      final detailsRef = FirebaseFirestore.instance
          .collection('Posts')
          .doc(newItem.parent)
          .collection('details');

      await Future.wait([
        detailsRef.doc('titles').set({
          newItem.videoId: newItem.title,
        }, SetOptions(merge: true)),
        detailsRef.doc('releaseDate').set({
          newItem.videoId: newItem.releaseDate,
        }, SetOptions(merge: true)),
        detailsRef.doc('series').set({
          newItem.videoId: newItem.series,
        }, SetOptions(merge: true)),
        detailsRef.doc('videoUrl').set({
          newItem.videoId: newItem.videoUrl,
        }, SetOptions(merge: true)),
      ]);

      // Optionally update banner in parent document
      await FirebaseFirestore.instance
          .collection('Posts')
          .doc(newItem.parent)
          .set({'Banner': newItem.thumbnail}, SetOptions(merge: true));

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }
}

class CreateVideoItemPage extends StatelessWidget {
  CreateVideoItemPage({Key? key}) : super(key: key);

  final CreateVideoItemController controller = Get.put(
    CreateVideoItemController(),
  );

  final _formKey = GlobalKey<FormState>();

  // For category selection (series)
  final List<CategoryModel> _allCategories = [
    CategoryModel(id: '1', name: 'Shoes', image: 'image'),
    CategoryModel(id: '2', name: 'Shirts', image: 'image'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: OrderBottomNavigationButtons(
        formKey: _formKey,
        controller: controller,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Breadcrumbs
                const TBreadcrumbsWithHeading(
                  returnToPreviousScreen: true,
                  heading: 'Create Video Item',
                  breadcrumbItems: [TRoutes.products, 'Create Video Item'],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: TDeviceUtils.isTabletScreen(context) ? 2 : 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OrderTitleAndDescription(controller: controller),
                          const SizedBox(height: TSizes.spaceBtwSections),
                          OrderVideoIdField(controller: controller),
                          const SizedBox(height: TSizes.spaceBtwSections),
                          OrderReleaseDateField(controller: controller),
                          const SizedBox(height: TSizes.spaceBtwSections),
                          OrderVideoUrlField(controller: controller),
                        ],
                      ),
                    ),
                    const SizedBox(width: TSizes.defaultSpace),

                    // Sidebar
                    Expanded(
                      child: Column(
                        children: [
                          OrderThumbnailImage(controller: controller),
                          const SizedBox(height: TSizes.spaceBtwSections),
                          OrderBrand(controller: controller),
                          const SizedBox(height: TSizes.spaceBtwSections),
                          OrderCategory(
                            controller: controller,
                            allCategories: _allCategories,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Buttons at bottom for Save and Discard
class OrderBottomNavigationButtons extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final CreateVideoItemController controller;

  const OrderBottomNavigationButtons({
    Key? key,
    required this.formKey,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () {
              // Reset all fields or just discard and pop
              Get.back();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("All changes were discarded.")),
              );
            },
            child: const Text('Discard'),
          ),
          const SizedBox(width: TSizes.spaceBtwItems / 2),
          Obx(() {
            if (controller.isLoading.value) {
              return const CircularProgressIndicator();
            }
            return SizedBox(
              width: 160,
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    try {
                      await controller.createVideoItem();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Video item created successfully!'),
                        ),
                      );
                      Get.back();
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Error: $e')));
                    }
                  }
                },
                child: const Text('Save Changes'),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class OrderTitleAndDescription extends StatelessWidget {
  final CreateVideoItemController controller;

  const OrderTitleAndDescription({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic Information',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // Title input
          TextFormField(
            decoration: const InputDecoration(labelText: 'Title'),
            onChanged: (val) => controller.title.value = val.trim(),
            validator:
                (val) =>
                    val == null || val.trim().isEmpty
                        ? 'Title cannot be empty'
                        : null,
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Description input (using releaseDate here for example, you can rename)
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Release Date',
              hintText: 'YYYY-MM-DD',
            ),
            onChanged: (val) => controller.releaseDate.value = val.trim(),
            validator:
                (val) =>
                    val == null || val.trim().isEmpty
                        ? 'Release Date cannot be empty'
                        : null,
          ),
        ],
      ),
    );
  }
}

// Separate fields for videoId, videoUrl for clarity
class OrderVideoIdField extends StatelessWidget {
  final CreateVideoItemController controller;
  const OrderVideoIdField({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: TextFormField(
        decoration: const InputDecoration(labelText: 'Video ID'),
        onChanged: (val) => controller.videoId.value = val.trim(),
        validator:
            (val) =>
                val == null || val.trim().isEmpty
                    ? 'Video ID cannot be empty'
                    : null,
      ),
    );
  }
}

class OrderVideoUrlField extends StatelessWidget {
  final CreateVideoItemController controller;
  const OrderVideoUrlField({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: TextFormField(
        decoration: const InputDecoration(labelText: 'Video URL'),
        onChanged: (val) => controller.videoUrl.value = val.trim(),
        validator:
            (val) =>
                val == null || val.trim().isEmpty
                    ? 'Video URL cannot be empty'
                    : null,
      ),
    );
  }
}

class OrderReleaseDateField extends StatelessWidget {
  final CreateVideoItemController controller;
  const OrderReleaseDateField({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Release Date',
          hintText: 'YYYY-MM-DD',
        ),
        onChanged: (val) => controller.releaseDate.value = val.trim(),
        validator:
            (val) =>
                val == null || val.trim().isEmpty
                    ? 'Release Date cannot be empty'
                    : null,
      ),
    );
  }
}
/*
class OrderThumbnailImage extends StatelessWidget {
  final CreateVideoItemController controller;
  const OrderThumbnailImage({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Thumbnail Image'),
          const SizedBox(height: 8),
          Obx(() {
            if (controller.thumbnail.value.isEmpty) {
              return const Text('No thumbnail selected');
            }
            return const Text('No thumbnail selected');
          }),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              // Your image picker code here. For demo, set a dummy image url:
              controller.thumbnail.value = 'https://via.placeholder.com/150';
            },
            icon: const Icon(Iconsax.image),
            label: const Text('Upload Thumbnail'),
          ),
        ],
      ),
    );
  }
}
*/
/*
class OrderThumbnailImage extends StatelessWidget {
  final CreateVideoItemController controller;
  const OrderThumbnailImage({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text('Thumbnail', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwItems),

          // Thumbnail Preview + Input
          TRoundedContainer(
            height: 300,
            backgroundColor: TColors.primaryBackground,
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Thumbnail Preview
                  Expanded(
                    child: Obx(() {
                      final imageUrl = controller.thumbnail.value.trim();
                      return imageUrl.isNotEmpty
                          ? TRoundedImage(
                            width: 220,
                            height: 220,
                            image: imageUrl,
                            imageType: ImageType.network,
                          )
                          : const TRoundedImage(
                            width: 220,
                            height: 220,
                            image: TImages.defaultSingleImageIcon,
                            imageType: ImageType.asset,
                          );
                    }),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  // Upload Button (simulated picker)
                  ElevatedButton.icon(
                    onPressed: () {
                      // Simulate image picking
                      controller.thumbnail.value =
                          'https://via.placeholder.com/150';
                    },
                    icon: const Icon(Iconsax.image),
                    label: const Text('Upload Thumbnail'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/

class OrderThumbnailImage extends StatelessWidget {
  final CreateVideoItemController controller;
  const OrderThumbnailImage({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Text('Thumbnail', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwItems),

          // Thumbnail card (Image + Button + TextField)
          Container(
            height: 300,
            width: double.infinity,
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            decoration: BoxDecoration(
              color: TColors.primaryBackground,
              borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
            ),
            child: Obx(() {
              final thumbnailUrl = controller.thumbnail.value.trim();
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image Preview
                  Expanded(
                    child: Center(
                      child: TRoundedImage(
                        width: 120,
                        height: 120,
                        image:
                            thumbnailUrl.isNotEmpty
                                ? thumbnailUrl
                                : TImages.defaultSingleImageIcon,
                        imageType:
                            thumbnailUrl.isNotEmpty
                                ? ImageType.network
                                : ImageType.asset,
                      ),
                    ),
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  /*   // Upload Button (simulated picker)
                  ElevatedButton.icon(
                    onPressed: () {
                      // Simulate image pick
                      controller.thumbnail.value =
                          'https://via.placeholder.com/300x300';
                    },
                    icon: const Icon(Iconsax.gallery),
                    label: const Text('Upload Thumbnail'),
                  ),*/
                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  // URL Input Field
                  TextFormField(
                    initialValue: thumbnailUrl,
                    onChanged: (value) {
                      controller.thumbnail.value = value.trim();
                    },
                    decoration: const InputDecoration(
                      labelText: 'Thumbnail Image URL',
                      hintText: 'Paste image URL here...',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class OrderBrand extends StatelessWidget {
  final CreateVideoItemController controller;
  const OrderBrand({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: TextFormField(
        decoration: const InputDecoration(labelText: 'Parent ID'),
        onChanged: (val) => controller.parent.value = val.trim(),
        validator:
            (val) =>
                val == null || val.trim().isEmpty
                    ? 'Parent ID cannot be empty'
                    : null,
      ),
    );
  }
}

// Category model, you can replace with your actual category model
class CategoryModel {
  final String id;
  final String name;
  final String image;

  CategoryModel({required this.id, required this.name, required this.image});
}

class OrderCategory extends StatefulWidget {
  final CreateVideoItemController controller;
  final List<CategoryModel> allCategories;

  const OrderCategory({
    Key? key,
    required this.controller,
    required this.allCategories,
  }) : super(key: key);

  @override
  State<OrderCategory> createState() => _OrderCategoryState();
}

class _OrderCategoryState extends State<OrderCategory> {
  List<CategoryModel> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Category'),
          const SizedBox(height: 8),
          MultiSelectDialogField<CategoryModel>(
            items:
                widget.allCategories
                    .map((cat) => MultiSelectItem<CategoryModel>(cat, cat.name))
                    .toList(),
            title: const Text('Select Categories'),
            selectedColor: Colors.blue,
            buttonIcon: const Icon(Icons.category),
            buttonText: const Text('Select Categories'),
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {
              setState(() {
                selectedCategories = values;
                // For demo, setting series to comma separated categories' names
                widget.controller.series.value = values
                    .map((e) => e.name)
                    .join(', ');
              });
            },
            chipDisplay: MultiSelectChipDisplay(
              onTap: (item) {
                setState(() {
                  selectedCategories.remove(item);
                  widget.controller.series.value = selectedCategories
                      .map((e) => e.name)
                      .join(', ');
                });
              },
            ),
          ),
          const SizedBox(height: 8),
          Text('Selected: ${widget.controller.series.value}'),
        ],
      ),
    );
  }
}
