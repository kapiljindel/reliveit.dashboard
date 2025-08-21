import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:dashboard/common/widgets/chips/rounded_choice_chips.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/features/stream/controllers/brand/create_brand_controller.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';

class CreateBrandForm extends StatelessWidget {
  const CreateBrandForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBrandController());

    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: controller.formKey,
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: TSizes.sm),
              Text(
                'Create New Brand',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              // Brand Name
              TextFormField(
                controller: controller.brandName,
                decoration: const InputDecoration(
                  labelText: 'Brand Name',
                  prefixIcon: Icon(Iconsax.box),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Brand name required'
                            : null,
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              // Banner Preview
              TRoundedImage(
                width: 400,
                height: 200,
                backgroundColor: TColors.primaryBackground,
                image:
                    controller.bannerUrl.text.isNotEmpty
                        ? controller.bannerUrl.text
                        : TImages.defaultImage,
                imageType:
                    controller.bannerUrl.text.isNotEmpty
                        ? ImageType.network
                        : ImageType.asset,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Banner URL
              TextFormField(
                controller: controller.bannerUrl,
                decoration: const InputDecoration(
                  labelText: 'Banner Image URL',
                ),
                validator:
                    (value) =>
                        (value == null || value.isEmpty)
                            ? 'Enter banner image URL'
                            : null,
                onChanged: (_) => controller.bannerUrl,
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              Container(
                padding: const EdgeInsets.symmetric(vertical: TSizes.sm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon Preview
                    TRoundedImage(
                      width: 80,
                      height: 80,
                      backgroundColor: TColors.primaryBackground,
                      image:
                          controller.imageUrl.text.isNotEmpty
                              ? controller.imageUrl.text
                              : TImages.defaultImage,
                      imageType:
                          controller.imageUrl.text.isNotEmpty
                              ? ImageType.network
                              : ImageType.asset,
                    ),

                    const SizedBox(
                      width: TSizes.sm,
                    ), // space between icon and text box
                    // Expanded Text Field for Icon URL
                    Expanded(
                      child: TextFormField(
                        controller: controller.imageUrl,
                        decoration: const InputDecoration(
                          labelText: 'Icon URL',
                        ),
                        validator:
                            (value) =>
                                (value == null || value.isEmpty)
                                    ? 'Enter icon URL'
                                    : null,
                        onChanged: (_) => controller.imageUrl,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              // Categories
              Text(
                'Select Categories',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields / 2),
              Wrap(
                spacing: TSizes.sm,
                children:
                    controller.allCategories.map((cat) {
                      final selected = controller.selectedCategories.contains(
                        cat,
                      );
                      return Padding(
                        padding: const EdgeInsets.only(bottom: TSizes.sm),
                        child: TChoiceChip(
                          text: cat,
                          selected: selected,
                          onSelected: (_) {
                            if (selected) {
                              controller.selectedCategories.remove(cat);
                            } else {
                              controller.selectedCategories.add(cat);
                            }
                          },
                        ),
                      );
                    }).toList(),
              ),
              /* const SizedBox(height: TSizes.spaceBtwInputFields * 2),

              // Optional image uploader (not wired to logic)
                 TImageUploader(
                width: 80,
                height: 80,
                image: TImages.defaultImage,
                imageType: ImageType.asset,
                onIconButtonPressed: () {
                  // Implement file picker logic here if needed
                },
              ),*/
              const SizedBox(height: TSizes.spaceBtwInputFields),

              // Featured checkbox
              CheckboxListTile(
                value: controller.isFeatured.value,
                onChanged: (val) => controller.isFeatured.value = val ?? false,
                title: const Text('Featured'),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields * 2),

              // Create Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.createBrand,
                  child: const Text('Create'),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields * 2),
            ],
          ),
        ),
      ),
    );
  }
}
