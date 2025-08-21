import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/features/stream/controllers/dashboard/dashboard_controller.dart';
import 'package:dashboard/features/stream/screens/dashboard/table/table_source.dart';
import 'package:dashboard/features/stream/screens/dashboard/widgets/dashboard_card.dart';
import 'package:dashboard/features/stream/screens/dashboard/widgets/order_status.dart';
import 'package:dashboard/features/stream/screens/dashboard/widgets/weekly_sales.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

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

              /// Cards
              const Row(
                children: [
                  Expanded(
                    child: TDashboardCard(
                      stats: 25,
                      title: 'Total Ads Revenenue',
                      subTitle: '\$365.6',
                    ),
                  ),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: TDashboardCard(
                      stats: 15,
                      title: 'Average Revenue',
                      subTitle: '\$25',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Row(
                children: [
                  Expanded(
                    child: TDashboardCard(
                      stats: 44,
                      title: 'Total Series',
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
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Bar Graph
              TWeeklySalesGraph(controller: controller),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Orders
              TRoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent Orders',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    const DashboardOrderTable(),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Pie Chart
              const OrderStatusPieChart(),
            ],
          ),
        ),
      ),
    );
  }
}
