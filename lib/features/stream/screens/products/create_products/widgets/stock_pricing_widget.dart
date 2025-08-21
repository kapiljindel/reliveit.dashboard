import 'package:dashboard/features/stream/controllers/product/create_product_controller.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductStockAndPricing extends StatelessWidget {
  const ProductStockAndPricing({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateProductController>();

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Image Field
          FractionallySizedBox(
            widthFactor: 0.45,
            child: TextFormField(
              controller: controller.imageController,
              decoration: const InputDecoration(
                labelText: "Image",
                hintText: "Add Image, only URLs are allowed",
              ),
              validator:
                  (value) => TValidator.validateEmptyText('Image', value),
              keyboardType: TextInputType.url,
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// 🔹 Title Field & Video
          Row(
            children: [
              // Title
              Expanded(
                child: TextFormField(
                  controller: controller.titleController,
                  decoration: const InputDecoration(
                    labelText: "Title",
                    hintText: "Title",
                  ),
                  validator:
                      (value) => TValidator.validateEmptyText('Title', value),
                  keyboardType: TextInputType.text,
                ),
              ),

              const SizedBox(width: TSizes.spaceBtwItems),

              // Video Field
              Expanded(
                child: TextFormField(
                  controller: controller.videoIdController,
                  decoration: const InputDecoration(
                    labelText: "Video URL or ID",
                    hintText: "https://example.com/video.mp4",
                  ),
                  validator:
                      (value) =>
                          TValidator.validateEmptyText('Video URL', value),
                  keyboardType: TextInputType.url,
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// 🔹 Series & Date Row
          Row(
            children: [
              // Series
              Expanded(
                child: TextFormField(
                  controller: controller.seriesController,
                  decoration: const InputDecoration(
                    labelText: "Series",
                    hintText: "e.g. Season 1",
                  ),
                  validator:
                      (value) => TValidator.validateEmptyText('Series', value),
                  keyboardType: TextInputType.text,
                ),
              ),

              const SizedBox(width: TSizes.spaceBtwItems),

              // Date
              Expanded(
                child: TextFormField(
                  controller: controller.releaseDateController,
                  decoration: const InputDecoration(
                    labelText: "Release Date",
                    hintText: "YYYY-MM-DD",
                  ),
                  validator:
                      (value) =>
                          TValidator.validateEmptyText('Release Date', value),
                  keyboardType: TextInputType.datetime,
                ),
              ),
            ],
          ),

          const SizedBox(height: TSizes.spaceBtwSections),

          /// 🔘 Add Button
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: controller.addSubProduct,
              label: const Text('Add'),
            ),
          ),
        ],
      ),
    );
  }
}
