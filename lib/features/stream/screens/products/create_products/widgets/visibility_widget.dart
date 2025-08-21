import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/features/stream/controllers/product/create_product_controller.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductVisibilityWidget extends StatelessWidget {
  const ProductVisibilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateProductController>();

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Visibility', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwItems),

          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildVisibilityRadioButton(
                  controller,
                  ProductVisibility.public,
                  'Public',
                ),
                _buildVisibilityRadioButton(
                  controller,
                  ProductVisibility.private,
                  'Private',
                ),
                _buildVisibilityRadioButton(
                  controller,
                  ProductVisibility.unlisted,
                  'Unlisted',
                ),

                // Show password TextField if unlisted is selected
                if (controller.visibility.value == ProductVisibility.unlisted)
                  Padding(
                    padding: const EdgeInsets.only(top: TSizes.spaceBtwItems),
                    child: TextFormField(
                      onChanged: (val) => controller.password.value = val,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter password for unlisted product',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisibilityRadioButton(
    CreateProductController controller,
    ProductVisibility value,
    String label,
  ) {
    return RadioListTile<ProductVisibility>(
      title: Text(label),
      value: value,
      groupValue: controller.visibility.value,
      onChanged: (newValue) {
        if (newValue != null) {
          controller.visibility.value = newValue;
          if (newValue != ProductVisibility.unlisted) {
            controller.password.value = ''; // Clear password if not unlisted
          }
        }
      },
    );
  }
}
