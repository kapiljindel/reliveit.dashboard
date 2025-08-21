import 'package:dashboard/common/widgets/data_table/paginated_data_table.dart';
import 'package:dashboard/features/stream/controllers/product/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dashboard/features/stream/screens/products/all_products/table/table_source.dart';

class ProductsTable extends StatelessWidget {
  const ProductsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SeriesController>();

    return Obx(() {
      if (controller.seriesList.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return TPaginatedDataTable(
        minWidth: 800,
        columns: const [
          DataColumn2(label: Text('Title')),
          DataColumn2(label: Text('Year')),
          DataColumn2(label: Text('Studio')),
          DataColumn2(label: Text('Featured')),
          DataColumn2(label: Text('Date')),
          DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: SeriesRow(controller.seriesList),
      );
    });
  }
}
