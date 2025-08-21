// ignore_for_file: unused_element

import 'package:dashboard/features/stream/models/dashboard_order_model.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  // Example: weekly sales data (observable list of doubles)
  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;

  // --- orders
  static final List<OrderModel> orders = [
    OrderModel(
      id: "MTD025",
      status: OrderStatus.active,
      totalAmount: 205,
      orderDate: DateTime(2026, 3, 1),
      deliveryDate: DateTime(2026, 5, 20),
    ),
    OrderModel(
      id: "CWT152",
      status: OrderStatus.cancelled,
      totalAmount: 580,
      orderDate: DateTime(2026, 5, 21),
      deliveryDate: DateTime(2026, 5, 23),
    ),
    OrderModel(
      id: "CT026",
      status: OrderStatus.completed,
      totalAmount: 154,
      orderDate: DateTime(2026, 5, 22),
      deliveryDate: DateTime(2026, 5, 25),
    ),
    OrderModel(
      id: "CWT1536",
      status: OrderStatus.active,
      totalAmount: 138,
      orderDate: DateTime(2026, 3, 24),
      deliveryDate: DateTime(2026, 5, 26),
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    //_calculateWeeklySales();
    _calculateOrderStatusData();

    // Example: populate weekly sales data
    weeklySales.assignAll([320, 230, 550, 200, 175, 280, 490]);
  }

  void _calculateWeeklySales() {
    // Reset weeklySales to zeros for 7 days
    weeklySales.value = List<double>.filled(7, 0.0);

    for (var order in orders) {
      final DateTime orderWeekStart = THelperFunctions.getStartOfWeek(
        order.orderDate,
      );

      // Check if order belongs to the current week
      if (orderWeekStart.isBefore(DateTime.now()) &&
          orderWeekStart.add(const Duration(days: 7)).isAfter(DateTime.now())) {
        // Get weekday index (0 = Monday, ..., 6 = Sunday)
        int index = (order.orderDate.weekday - 1) % 7;

        // Ensure index is non-negative
        if (index < 0) index += 7;

        // Add order amount to corresponding day
        weeklySales[index] += order.totalAmount;

        print(
          'OrderDate: ${order.orderDate}, '
          'WeekStart: $orderWeekStart, '
          'Index: $index, ',
          //          'Amount Added: ${order.totalAmount}',
        );
      }
    }

    print('Weekly Sales: $weeklySales');
  }

  void _calculateOrderStatusData() {
    // Step 1: Clear old data
    orderStatusData.clear();

    // Step 2: Initialize totalAmounts with 0.0 for each status
    totalAmounts.value = {for (var status in OrderStatus.values) status: 0.0};

    // Step 3: Loop through orders
    for (var order in orders) {
      final status = order.status;

      // Increment order count
      orderStatusData[status] = (orderStatusData[status] ?? 0) + 1;

      // Add to total amount
      totalAmounts[status] = (totalAmounts[status] ?? 0) + order.totalAmount;
    }
  }

  String getDisplayStatusName(OrderStatus status) {
    switch (status) {
      case OrderStatus.active:
        return 'Active';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
      // ignore: unreachable_switch_default
      default:
        return 'Unknown';
    }
  }
}
