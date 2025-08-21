// ignore_for_file: unused_local_variable

import 'package:dashboard/common/widgets/containers/circular_container.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/features/stream/controllers/dashboard/dashboard_controller.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/utils/helpers/helper_functions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OrderStatusPieChart extends StatelessWidget {
  const OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reports Status',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Graph
          SizedBox(
            height: 400,
            child: PieChart(
              PieChartData(
                sections:
                    controller.orderStatusData.entries.map((entry) {
                      final status = entry.key;
                      final count = entry.value;

                      return PieChartSectionData(
                        radius: 100,
                        title: count.toString(),
                        value: count.toDouble(),
                        color: THelperFunctions.getOrderStatusColor(status),
                        titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    }).toList(),
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    // Handle touch events here if needed
                  },
                  enabled: true,
                ),
              ),
            ),
          ),
          // Show Status and Color Meta (add this later as needed)
          // Show Status and Color Meta
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Orders')),
                DataColumn(label: Text('Total')),
              ],
              rows:
                  controller.orderStatusData.entries.map((entry) {
                    final OrderStatus status = entry.key;
                    final int count = entry.value;
                    final totalAmount = controller.totalAmounts[status] ?? 0;

                    return DataRow(
                      cells: [
                        DataCell(
                          Row(
                            children: [
                              TCircularContainer(
                                width: 20,
                                height: 20,
                                backgroundColor:
                                    THelperFunctions.getOrderStatusColor(
                                      status,
                                    ),
                              ),
                              Expanded(
                                child: Text(
                                  ' ${controller.getDisplayStatusName(status)}',
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(Text(count.toString())),
                        DataCell(
                          Text('\$${totalAmount.toStringAsFixed(2)}'),
                        ), // Format as needed
                      ],
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
