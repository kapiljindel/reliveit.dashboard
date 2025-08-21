import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

/// Example category model
class CategoryModel {
  final String id;
  final String name;
  final String image;

  CategoryModel({required this.id, required this.name, required this.image});

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class OrderCategory extends StatefulWidget {
  const OrderCategory({super.key});

  @override
  State<OrderCategory> createState() => _OrderCategoryState();
}

class _OrderCategoryState extends State<OrderCategory> {
  final List<CategoryModel> _allCategories = [
    CategoryModel(id: '1', name: 'Shoes', image: 'image'),
    CategoryModel(id: '2', name: 'Shirts', image: 'image'),
  ];

  final List<CategoryModel> _selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Text(
            'Parent Series',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // Multi-select field
          MultiSelectDialogField<CategoryModel>(
            buttonText: const Text("Select Series"),
            title: const Text("Categories"),
            items:
                _allCategories
                    .map((cat) => MultiSelectItem<CategoryModel>(cat, cat.name))
                    .toList(),
            listType: MultiSelectListType.CHIP,
            initialValue: _selectedCategories,
            onConfirm: (values) {
              setState(() {
                _selectedCategories.clear();
                _selectedCategories.addAll(values);
              });

              // Optional: print selected
              debugPrint(
                "Selected categories: ${_selectedCategories.map((e) => e.name).join(', ')}",
              );
            },
          ),

          const SizedBox(height: TSizes.spaceBtwItems),

          // Optional: Show selected chips
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children:
                _selectedCategories
                    .map((cat) => Chip(label: Text(cat.name)))
                    .toList(),
          ),
        ],
      ),
    );
  }
}
