import 'package:dashboard/common/widgets/data_table/paginated_data_table.dart';
import 'package:dashboard/features/stream/screens/servers/all_server/table/table_source.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class ServersTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 700,
      tableHeight: 900,
      dataRowHeight: 110,
      columns: const [
        DataColumn2(label: Text('Server')),
        DataColumn2(label: Text('Sever ID')),
        DataColumn2(label: Text('Buckets')),
        DataColumn2(label: Text('Storage Used')),
        DataColumn2(label: Text('Active')),
        DataColumn2(label: Text('Action'), fixedWidth: 100),
      ],
      source: ServersRows(),
    );
  }
}
