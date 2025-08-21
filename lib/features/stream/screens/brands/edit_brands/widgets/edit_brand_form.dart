import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dashboard/common/widgets/chips/rounded_choice_chips.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/features/stream/controllers/brand/edit_brand_controller.dart';
import 'package:dashboard/features/stream/models/brand_model.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';

class EditBrandForm extends StatelessWidget {
  final BrandModel brand;

  const EditBrandForm({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditBrandController());
    controller.loadBrandData(brand);
    controller.loadCategories();

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
                'Edit Brand',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              TextFormField(
                controller: controller.brandName,
                decoration: const InputDecoration(labelText: 'Brand Name'),
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              TRoundedImage(
                width: 400,
                height: 200,
                image:
                    controller.bannerUrl.text.isNotEmpty
                        ? controller.bannerUrl.text
                        : TImages.defaultImage,
                imageType:
                    controller.bannerUrl.text.isNotEmpty
                        ? ImageType.network
                        : ImageType.asset,
                backgroundColor: TColors.primaryBackground,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TextFormField(
                controller: controller.bannerUrl,
                decoration: const InputDecoration(labelText: 'Banner URL'),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              Row(
                children: [
                  TRoundedImage(
                    width: 80,
                    height: 80,
                    image:
                        controller.imageUrl.text.isNotEmpty
                            ? controller.imageUrl.text
                            : TImages.defaultImage,
                    imageType:
                        controller.imageUrl.text.isNotEmpty
                            ? ImageType.network
                            : ImageType.asset,
                    backgroundColor: TColors.primaryBackground,
                  ),
                  const SizedBox(width: TSizes.sm),
                  Expanded(
                    child: TextFormField(
                      controller: controller.imageUrl,
                      decoration: const InputDecoration(labelText: 'Icon URL'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              Text(
                'Select Categories',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
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
              const SizedBox(height: TSizes.spaceBtwInputFields),

              CheckboxListTile(
                value: controller.isFeatured.value,
                onChanged: (val) => controller.isFeatured.value = val ?? false,
                title: const Text('Featured'),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields * 2),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.updateBrand(brand),
                  child: const Text('Update Brand'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
