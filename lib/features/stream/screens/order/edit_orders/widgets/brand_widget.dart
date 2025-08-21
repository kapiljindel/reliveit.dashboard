// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class OrderBrand extends StatefulWidget {
  const OrderBrand({super.key});

  @override
  State<OrderBrand> createState() => _OrderBrandState();
}

class _OrderBrandState extends State<OrderBrand> {
  final TextEditingController _brandController = TextEditingController();

  @override
  void dispose() {
    _brandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: TextFormField(
        controller: _brandController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Series Number',
          hintText: 'Enter series number',
          suffixIcon: Icon(Iconsax.box),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a Series';
          }
          return null;
        },
      ),
    );
  }
}
