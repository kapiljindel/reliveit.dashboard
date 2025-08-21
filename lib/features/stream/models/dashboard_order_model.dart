//enum OrderStatus { processing, shipped, delivered, pending, cancelled }

// ignore_for_file: unnecessary_null_comparison

import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/helpers/helper_functions.dart';

class OrderModel {
  final String id;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final DateTime deliveryDate;

  OrderModel({
    required this.id,
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    required this.deliveryDate,
  });

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate =>
      deliveryDate != null
          ? THelperFunctions.getFormattedDate(deliveryDate)
          : '';

  String get orderStatusText =>
      status == OrderStatus.delivered
          ? 'Delivered'
          : status == OrderStatus.shipped
          ? 'Shipment on the way'
          : 'Processing';
}
