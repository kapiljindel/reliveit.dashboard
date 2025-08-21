// TODO Implement this library.
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/features/stream/controllers/product/edit_product_controller.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductTitleAndDescription extends StatelessWidget {
  const ProductTitleAndDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditProductController>();

    return TRoundedContainer(
      child: Form(
        //  key: controller.formKey, // Optional, if you want to add validation
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            Text(
              'Basic Information',
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

            // Product Title Input Field
            Obx(
              () => TextFormField(
                initialValue: controller.title.value,
                onChanged: (val) => controller.title.value = val,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Product Title cannot be empty';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Product Title'),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Product Description Input Field
            SizedBox(
              height: 388,
              child: Obx(
                () => TextFormField(
                  initialValue: controller.description.value,
                  onChanged: (val) => controller.description.value = val,
                  expands: true,
                  maxLines: null,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.top,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Product Description cannot be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Product Description',
                    hintText: 'Add your Product Description here...',
                    alignLabelWithHint: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
