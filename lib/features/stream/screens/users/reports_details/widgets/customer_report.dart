import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/features/stream/screens/reports/reports_details/table/table_data.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ReportOrders extends StatelessWidget {
  const ReportOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Orders', style: Theme.of(context).textTheme.headlineMedium),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Total Spent: '),
                    TextSpan(
                      text: '\$508.55',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.apply(color: TColors.primary),
                    ),
                    TextSpan(
                      text: ' on 55 orders',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          TextFormField(
            onChanged: (query) {},
            decoration: const InputDecoration(
              hintText: 'Search Orders',
              prefixIcon: Icon(Iconsax.search_normal),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          const ReportOrderTable(),
        ],
      ),
    );
  }
}
