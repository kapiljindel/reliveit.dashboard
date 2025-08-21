import 'package:dashboard/common/widgets/data_table/paginated_data_table.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'data_table.dart';

class DashboardOrderTable extends StatelessWidget {
  const DashboardOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 700,
      tableHeight: 500,
      dataRowHeight: TSizes.xl * 1.2,
      columns: const [
        DataColumn2(label: Text('Report ID')),
        DataColumn2(label: Text('Date')),
        DataColumn2(label: Text('Times')),
        DataColumn2(label: Text('Status')),
        DataColumn2(label: Text('Action')),
      ],
      source: OrderRows(),
    );
  }
}
