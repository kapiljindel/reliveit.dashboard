import 'package:dashboard/common/widgets/data_table/paginated_data_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dashboard/features/stream/controllers/category/category_controller.dart';
import 'package:dashboard/features/stream/screens/category/all_category/table/table_source.dart';

class CategoryTable extends StatelessWidget {
  const CategoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryController>();

    return Obx(() {
      if (controller.categories.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return TPaginatedDataTable(
        minWidth: 700,
        columns: const [
          DataColumn2(label: Text('Category')),
          DataColumn2(label: Text('Parent Category')),
          DataColumn2(label: Text('Featured')),
          DataColumn2(label: Text('Date')),
          DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: CategoryRow(controller.categories),
      );
    });
  }
}
