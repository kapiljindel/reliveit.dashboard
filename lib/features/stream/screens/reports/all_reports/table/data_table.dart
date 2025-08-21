import 'package:dashboard/common/widgets/data_table/paginated_data_table.dart';
import 'package:dashboard/features/stream/screens/reports/all_reports/table/table_source.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class ReportTable extends StatelessWidget {
  const ReportTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 600,
      columns: const [
        DataColumn2(label: Text('Report Title')),
        DataColumn2(label: Text('Report ID')),
        DataColumn2(label: Text('User ID')),
        DataColumn2(label: Text('Series ID')),
        DataColumn2(label: Text('Status')),
        DataColumn2(label: Text('Registered')),
        DataColumn2(label: Text('Action'), fixedWidth: 140),
      ],
      source: ReportRows(),
    ); // TPaginatedDataTable
  }
}
