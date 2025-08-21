import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

// Example enum for product type
enum ProductType { single, variable }

class ProductTypeWidget extends StatefulWidget {
  const ProductTypeWidget({super.key});

  @override
  State<ProductTypeWidget> createState() => _ProductTypeWidgetState();
}

class _ProductTypeWidgetState extends State<ProductTypeWidget> {
  // Default selected value
  ProductType _selectedType = ProductType.single;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 🔹 Label
        Text('Product Type', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(width: TSizes.spaceBtwItems),

        // 🔹 Single Product Type
        RadioMenuButton<ProductType>(
          value: ProductType.single,
          groupValue: _selectedType,
          onChanged: (value) {
            setState(() {
              _selectedType = value!;
            });
          },
          child: const Text('Single'),
        ),

        // 🔹 Variable Product Type
        RadioMenuButton<ProductType>(
          value: ProductType.variable,
          groupValue: _selectedType,
          onChanged: (value) {
            setState(() {
              _selectedType = value!;
            });
          },
          child: const Text('Variable'),
        ),
      ],
    );
  }
}
