import 'package:dashboard/common/widgets/data_table/paginated_data_table.dart';
import 'package:dashboard/features/stream/controllers/order/order_controller.dart';
import 'package:dashboard/features/stream/models/order_model.dart';
import 'package:dashboard/features/stream/screens/order/all_orders/table/table_source.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class OrderTable extends StatelessWidget {
  final List<VideoItem> videoItems;
  final VideoItemController controller;

  const OrderTable({
    super.key,
    required this.videoItems,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 800,
      columns: const [
        DataColumn2(label: Text('Video ID')),
        DataColumn2(label: Text('Title')),
        DataColumn2(label: Text('Date')),
        DataColumn2(label: Text('Video URL')),
        DataColumn2(label: Text('Series')),
        DataColumn2(label: Text('Parent')),
        DataColumn2(label: Text('Action'), fixedWidth: 100),
      ],
      source: OrderRows(videoItems, controller),
    );
  }
}
