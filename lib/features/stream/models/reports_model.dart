import 'package:dashboard/utils/constants/enums.dart';

class ReportModel {
  final String id;
  final String fullName;
  final String email;
  final DateTime date;
  final OrderStatus status;
  final double totalSpent;
  final int totalOrders;
  //final String status;

  ReportModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.date,
    required this.totalSpent,
    required this.totalOrders,
    required this.status,
  });

  // Optional: formatted date string getter
  String get formattedDate {
    return '${date.day}/${date.month}/${date.year}';
  }

  // Optional: JSON serialization (if needed for APIs or storage)
  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      date: DateTime.parse(json['date']),
      totalSpent: json['totalSpent'].toDouble(),
      totalOrders: json['totalOrders'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'date': date.toIso8601String(),
      'totalSpent': totalSpent,
      'totalOrders': totalOrders,
      'status': status,
    };
  }

  String get orderStatusText =>
      status == OrderStatus.active
          ? 'Delivered'
          : status == OrderStatus.completed
          ? 'Shipment on the way'
          : 'Processing';
}
