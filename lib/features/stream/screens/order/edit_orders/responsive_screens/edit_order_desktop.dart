// ignore_for_file: unused_local_variable

import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class EditOrderDesktopScreen extends StatelessWidget {
  const EditOrderDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const OrderBottomNavigationButtons(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Edit Order',
                breadcrumbItems: [TRoutes.products, 'Edit Order'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Edit Order
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: TDeviceUtils.isTabletScreen(context) ? 2 : 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Basic Information
                        OrderTitleAndDescription(),
                        const SizedBox(height: TSizes.spaceBtwSections),
                      ],
                    ),
                  ),
                  const SizedBox(width: TSizes.defaultSpace),

                  // Sidebar
                  Expanded(
                    child: Column(
                      children: [
                        // Order Thumbnail
                        const OrderThumbnailImage(),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // Order Brand
                        const OrderBrand(),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // Order Categories
                        const OrderCategory(),
                        const SizedBox(height: TSizes.spaceBtwSections),
                      ],
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

class OrderBottomNavigationButtons extends StatelessWidget {
  const OrderBottomNavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("All changes were discarded.")),
              );
            },
            child: const Text('Discard'),
          ),
          const SizedBox(width: TSizes.spaceBtwItems / 2),
          SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () async {},
              child: const Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderTitleAndDescription extends StatefulWidget {
  const OrderTitleAndDescription({super.key});

  @override
  State<OrderTitleAndDescription> createState() =>
      _OrderTitleAndDescriptionState();
}

class _OrderTitleAndDescriptionState extends State<OrderTitleAndDescription> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            Text(
              'Basic Information',
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

            // Order Title Input Field
            TextFormField(
              controller: _titleController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Order Title cannot be empty';
                }
                return null;
              },
              decoration: const InputDecoration(labelText: 'Title'),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Order Description Input Field
            SizedBox(
              height: 388,
              child: TextFormField(
                controller: _descriptionController,
                expands: true,
                maxLines: null,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Order Description cannot be empty';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Order Description',
                  hintText: 'Add your Order Description here...',
                  alignLabelWithHint: true,
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Order Title Input Field
            TextFormField(
              controller: _titleController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Order Title cannot be empty';
                }
                return null;
              },
              decoration: const InputDecoration(labelText: 'Video ID'),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderThumbnailImage extends StatefulWidget {
  const OrderThumbnailImage({super.key});

  @override
  State<OrderThumbnailImage> createState() => _OrderThumbnailImageState();
}

class _OrderThumbnailImageState extends State<OrderThumbnailImage> {
  final TextEditingController _thumbnailController = TextEditingController();
  String _previewUrl = '';

  @override
  void dispose() {
    _thumbnailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text('Thumbnail', style: Theme.of(context).textTheme.headlineSmall),
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
                    child:
                        _previewUrl.isNotEmpty
                            ? TRoundedImage(
                              width: 220,
                              height: 220,
                              image: _previewUrl,
                              imageType: ImageType.network,
                            )
                            : const TRoundedImage(
                              width: 220,
                              height: 220,
                              image: TImages.defaultSingleImageIcon,
                              imageType: ImageType.asset,
                            ),
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),

                  // 🔹 Image URL Input Field
                  TextFormField(
                    controller: _thumbnailController,
                    onChanged: (value) {
                      setState(() {
                        _previewUrl = value.trim();
                      });
                    },
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

/// Example category model
class CategoryModel {
  final String id;
  final String name;
  final String image;

  CategoryModel({required this.id, required this.name, required this.image});

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class OrderCategory extends StatefulWidget {
  const OrderCategory({super.key});

  @override
  State<OrderCategory> createState() => _OrderCategoryState();
}

class _OrderCategoryState extends State<OrderCategory> {
  final List<CategoryModel> _allCategories = [
    CategoryModel(id: '1', name: 'Shoes', image: 'image'),
    CategoryModel(id: '2', name: 'Shirts', image: 'image'),
  ];

  final List<CategoryModel> _selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Text(
            'Parent Series',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // Multi-select field
          MultiSelectDialogField<CategoryModel>(
            buttonText: const Text("Select Series"),
            title: const Text("Series"),
            items:
                _allCategories
                    .map((cat) => MultiSelectItem<CategoryModel>(cat, cat.name))
                    .toList(),
            listType: MultiSelectListType.CHIP,
            initialValue: _selectedCategories,
            onConfirm: (values) {
              setState(() {
                _selectedCategories.clear();
                _selectedCategories.addAll(values);
              });

              // Optional: print selected
              debugPrint(
                "Selected Series: ${_selectedCategories.map((e) => e.name).join(', ')}",
              );
            },
          ),

          const SizedBox(height: TSizes.spaceBtwItems),

          // Optional: Show selected chips
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children:
                _selectedCategories
                    .map((cat) => Chip(label: Text(cat.name)))
                    .toList(),
          ),
        ],
      ),
    );
  }
}

class OrderBrand extends StatefulWidget {
  const OrderBrand({super.key});

  @override
  State<OrderBrand> createState() => _OrderBrandState();
}

class _OrderBrandState extends State<OrderBrand> {
  final TextEditingController _brandController = TextEditingController();

  @override
  void dispose() {
    _brandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: TextFormField(
        controller: _brandController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Series Number',
          hintText: 'Enter series number',
          suffixIcon: Icon(Iconsax.box),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a Series';
          }
          return null;
        },
      ),
    );
  }
}
