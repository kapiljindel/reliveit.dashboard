import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/features/stream/controllers/product/create_product_controller.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductBottomNavigationButtons extends StatelessWidget {
  const ProductBottomNavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateProductController>();

    return TRoundedContainer(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () {
              controller.resetForm();
              Get.snackbar("Discarded", "All changes were discarded.");
            },
            child: const Text('Discard'),
          ),
          const SizedBox(width: TSizes.spaceBtwItems / 2),
          SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () async {
                await controller.saveProductWithDetails();
              },
              child: const Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }
}
