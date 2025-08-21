// ignore_for_file: unused_import

import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/features/stream/controllers/dashboard/dashboard_controller.dart';
import 'package:dashboard/features/stream/screens/dashboard/table/table_source.dart';
import 'package:dashboard/features/stream/screens/dashboard/widgets/dashboard_card.dart';
import 'package:dashboard/features/stream/screens/dashboard/widgets/order_status.dart';
import 'package:dashboard/features/stream/screens/dashboard/widgets/weekly_sales.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/utils/device/device_utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

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

              // Cards
              const Row(
                children: [
                  Expanded(
                    child: TDashboardCard(
                      stats: 25,
                      title: 'Total Ads Revenenue',
                      subTitle: '\$185.6',
                    ),
                  ),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: TDashboardCard(
                      stats: 25,
                      title: 'Average Revenue ',
                      subTitle: '\$185.6',
                    ),
                  ),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: TDashboardCard(
                      stats: 25,
                      title: 'Total Series',
                      subTitle: '\192',
                    ),
                  ),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: TDashboardCard(
                      stats: 25,
                      title: 'Visitors',
                      subTitle: '\185.6',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              //  GRAPHs
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        /// Bar Graph
                        TWeeklySalesGraph(controller: controller),

                        const SizedBox(height: TSizes.spaceBtwSections),

                        TRoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recent Reports',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: TSizes.spaceBtwSections),
                              const DashboardOrderTable(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: TSizes.spaceBtwSections),

                  /// Pie Chart
                  Expanded(child: const OrderStatusPieChart()),

                  // You can continue with the second Expanded or any other widget
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
