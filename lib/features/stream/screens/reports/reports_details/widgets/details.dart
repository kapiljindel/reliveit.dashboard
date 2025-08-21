import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Technical Details',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Meta Data
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Submitted From')),
              const Text(':'),
              const SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  'Mobile App v1.1.0',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          Row(
            children: [
              const SizedBox(width: 120, child: Text('Report Category')),
              const Text(':'),
              const SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  'Video Issue',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          Row(
            children: [
              const SizedBox(width: 120, child: Text('Flagged By Admin')),
              const Text(':'),
              const SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  'No',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          Row(
            children: [
              const SizedBox(width: 120, child: Text('Severity Level')),
              const Text(':'),
              const SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  'High',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
