import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/images/image_uploader.dart';
import 'package:dashboard/features/stream/controllers/category/create_category_controller.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      CreateCategoryController(),
    ); // Register controller

    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: TSizes.sm),
            Text(
              'Create New Category',
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
              if (controller.allCategories.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return DropdownButtonFormField<String>(
                value:
                    controller.parentCategoryController.text.isEmpty
                        ? null
                        : controller.parentCategoryController.text,
                decoration: const InputDecoration(
                  hintText: 'Parent Category',
                  labelText: 'Parent Category',
                  prefixIcon: Icon(Iconsax.bezier),
                ),
                onChanged: (newValue) {
                  controller.parentCategoryController.text = newValue ?? '';
                },
                items:
                    controller.allCategories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category.id,
                        child: Text(category.name),
                      );
                    }).toList(),
              );
            }),
            const SizedBox(height: TSizes.spaceBtwInputFields * 2),

            // Image URL Text Field (for manual URL entry)
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
                onPressed: () => controller.createCategory(),
                child: const Text('Create'),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
