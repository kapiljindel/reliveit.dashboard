import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/images/image_uploader.dart';
import 'package:dashboard/features/stream/controllers/category/edit_category_controller.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditCategoryForm extends StatelessWidget {
  final String categoryId;

  const EditCategoryForm({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditCategoryController()); // Register controller
    controller.loadCategoryData(categoryId); // Fetch category data

    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: TSizes.sm),
            Text(
              'Edit Category',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Name Text Field
            TextFormField(
              controller: controller.nameController,
              validator: (value) => TValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                labelText: 'Category Name',
                prefixIcon: Icon(Iconsax.category),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Parent Category Dropdown
            Obx(() {
              if (controller.category.value.name.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return DropdownButtonFormField<String>(
                value: controller.category.value.parentCategory,
                decoration: const InputDecoration(
                  hintText: 'Parent Category',
                  labelText: 'Parent Category',
                  prefixIcon: Icon(Iconsax.bezier),
                ),
                onChanged: (newValue) {
                  controller.parentCategoryController.text = newValue ?? '';
                },
                items:
                    <String>['Parent 1', 'Parent 2', 'Parent 3'].map((
                      parentCategory,
                    ) {
                      return DropdownMenuItem<String>(
                        value: parentCategory,
                        child: Text(parentCategory),
                      );
                    }).toList(),
              );
            }),
            const SizedBox(height: TSizes.spaceBtwInputFields * 2),

            // Image URL Text Field
            TextFormField(
              controller: controller.imageUrlController,
              validator:
                  (value) => value!.isEmpty ? 'Enter an image URL' : null,
              decoration: const InputDecoration(
                labelText: 'Image URL',
                prefixIcon: Icon(Iconsax.image),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields * 2),

            // Image Uploader (optional, for uploading an image)
            TImageUploader(
              width: 80,
              height: 80,
              image:
                  controller.imageUrlController.text.isNotEmpty
                      ? controller.imageUrlController.text
                      : TImages.defaultImage,
              imageType:
                  controller.imageUrlController.text.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
              onIconButtonPressed: () {
                // Implement image picker logic here
              },
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields * 2),

            // Featured Checkbox
            Obx(
              () => CheckboxListTile(
                value: controller.isFeatured.value,
                onChanged: (value) {
                  controller.isFeatured.value = value ?? false;
                },
                title: const Text('Featured'),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields * 2),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateCategory(),
                child: const Text('Update'),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
