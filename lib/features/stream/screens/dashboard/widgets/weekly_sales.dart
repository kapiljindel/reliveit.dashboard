// ignore_for_file: unused_local_variable

import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/features/stream/controllers/dashboard/dashboard_controller.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/utils/device/device_utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TWeeklySalesGraph extends StatelessWidget {
  const TWeeklySalesGraph({super.key, required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily Views This Week',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          // Add your bar graph or other widget here

          // Graph Section
          SizedBox(
            height: 400,
            child: BarChart(
              BarChartData(
                titlesData: buildFlTitlesData(),
                borderData: FlBorderData(
                  show: true,
                  border: const Border(
                    top: BorderSide.none,
                    right: BorderSide.none,
                  ),
                ),
                gridData: const FlGridData(show: true, drawVerticalLine: false),
                barGroups:
                    controller.weeklySales
                        .asMap()
                        .entries
                        .map(
                          (entry) => BarChartGroupData(
                            x: entry.key, // weekday index
                            barRods: [
                              BarChartRodData(
                                toY: entry.value, // sales value for that day
                                color: TColors.primary,
                                width: 18,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                groupsSpace: TSizes.spaceBtwItems,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => TColors.secondary,
                    tooltipPadding: const EdgeInsets.all(8),
                    tooltipMargin: 6,
                  ),
                  touchCallback:
                      TDeviceUtils.isDesktopScreen(context)
                          ? (barTouchEvent, barTouchResponse) {
                            // Optional: handle click/hover events
                          }
                          : null,
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
        ],
      ),
    );
  }
}

FlTitlesData buildFlTitlesData() {
  return FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          // Map index to days of the week
          final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

          // Wrap around the index to stay within [0..6]
          final index = value.toInt() % days.length;
          final day = days[index];

          return SideTitleWidget(
            axisSide: meta.axisSide,
            space: 0,
            child: Text(day, style: const TextStyle(fontSize: 12)),
          );
        },
      ),
    ),
    leftTitles: const AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: 200, // spacing for Y-axis labels
        reservedSize: 50, // padding space
      ),
    ),
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  );
}
