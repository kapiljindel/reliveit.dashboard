// ignore_for_file: unnecessary_cast

import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

// Example category model
class CategoryModel {
  final String id;
  final String name;
  final String image;

  CategoryModel({required this.id, required this.name, required this.image});
}

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(16.0), // optional
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories label
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwItems),

          // MultiSelectDialogField for selecting categories
          MultiSelectDialogField<CategoryModel>(
            buttonText: const Text("Select Categories"),
            title: const Text("Categories"),
            items: [
              MultiSelectItem(
                CategoryModel(id: '1', name: 'Shoes', image: 'image'),
                'Shoes',
              ),
              MultiSelectItem(
                CategoryModel(id: '2', name: 'Shirts', image: 'image'),
                'Shirts',
              ),
            ],
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {
              // Handle selected categories here
              debugPrint(
                "Selected categories: ${values.map((e) => (e as CategoryModel).name)}",
              );
            },
          ),
        ],
      ),
    );
  }
}
