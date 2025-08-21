import 'package:dashboard/features/stream/screens/dashboard/widgets/dashboard_card.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Cards Row 1
              const Row(
                children: [
                  Expanded(
                    child: TDashboardCard(
                      stats: 25,
                      title: 'Sales total',
                      subTitle: '\$365.6',
                    ),
                  ),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: TDashboardCard(
                      stats: 15,
                      title: 'Average Order Value',
                      subTitle: '\$25',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwItems),

              // Cards Row 2
              const Row(
                children: [
                  Expanded(
                    child: TDashboardCard(
                      stats: 44,
                      title: 'Total Orders',
                      subTitle: '36',
                    ),
                  ),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: TDashboardCard(
                      stats: 2,
                      title: 'Visitors',
                      subTitle: '25,035',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
