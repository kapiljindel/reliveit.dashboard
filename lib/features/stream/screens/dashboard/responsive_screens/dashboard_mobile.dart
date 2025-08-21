import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/features/stream/controllers/dashboard/dashboard_controller.dart';
import 'package:dashboard/features/stream/screens/dashboard/table/table_source.dart';
import 'package:dashboard/features/stream/screens/dashboard/widgets/dashboard_card.dart'
    show TDashboardCard;
import 'package:dashboard/features/stream/screens/dashboard/widgets/order_status.dart';
import 'package:dashboard/features/stream/screens/dashboard/widgets/weekly_sales.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardMobileScreen extends StatelessWidget {
  const DashboardMobileScreen({super.key});

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

              // Cards Row 1
              TDashboardCard(
                stats: 59,
                title: 'Total Ads Revenenue',
                subTitle: '\$365.6',
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TDashboardCard(
                stats: 15,
                title: 'Average Revenue',
                subTitle: '\$25',
              ),

              const SizedBox(height: TSizes.spaceBtwItems),

              // Cards Row 2
              TDashboardCard(stats: 44, title: 'Total Series', subTitle: '36'),
              const SizedBox(height: TSizes.spaceBtwItems),
              TDashboardCard(stats: 2, title: 'Visitors', subTitle: '25,035'),

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
