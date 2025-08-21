import 'package:dashboard/features/stream/controllers/product/create_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dashboard/features/stream/models/brand_model.dart';
import 'package:iconsax/iconsax.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateProductController>();

    return Obx(() {
      return Container(
        margin: const EdgeInsets.all(12),
        child: DropdownButtonFormField<BrandModel>(
          value: controller.selectedBrand.value,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Select Brand',
            suffixIcon: const Icon(Iconsax.box),
          ),
          items:
              controller.brands.map((brand) {
                return DropdownMenuItem<BrandModel>(
                  value: brand,
                  child: Text(brand.brand),
                );
              }).toList(),
          onChanged: (BrandModel? brand) {
            controller.selectedBrand.value = brand;
            if (brand != null) {
              controller.brandTextController.text = brand.brand;
            }
          },
          validator: (value) {
            if (value == null) {
              return 'Please select a brand';
            }
            return null;
          },
        ),
      );
    });
  }
}
