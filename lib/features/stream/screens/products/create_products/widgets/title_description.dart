import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/features/stream/controllers/product/create_product_controller.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductTitleAndDescription extends StatelessWidget {
  ProductTitleAndDescription({super.key});

  final controller = Get.find<CreateProductController>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Information',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            Obx(
              () => TextFormField(
                initialValue: controller.title.value,
                decoration: const InputDecoration(labelText: 'Product Title'),
                validator:
                    (value) =>
                        TValidator.validateEmptyText('Product Title', value),
                onChanged: (val) => controller.title.value = val,
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            Obx(
              () => SizedBox(
                height: 388,
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.top,
                  initialValue: controller.description.value,
                  validator:
                      (value) => TValidator.validateEmptyText(
                        'Product Description',
                        value,
                      ),
                  decoration: const InputDecoration(
                    labelText: 'Product Description',
                    hintText: 'Add your Product Description here...',
                    alignLabelWithHint: true,
                  ),
                  onChanged: (val) => controller.description.value = val,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
