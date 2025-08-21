import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:dashboard/features/stream/models/dashboard_order_model.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/utils/helpers/helper_functions.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportOrdersRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    final order = OrderModel(
      id: 'HDJTCFxMUmiQdsKnN9Ne',
      status: OrderStatus.active,
      totalAmount: 235.5,
      orderDate: DateTime.now(),
      deliveryDate: DateTime.now(),
    );
    //  const totalAmount = '2563.5';
    return DataRow2(
      selected: false,
      onTap: () => Get.toNamed(TRoutes.orderDetails, arguments: order),
      cells: [
        DataCell(
          Text(
            order.id,
            style: Theme.of(
              Get.context!,
            ).textTheme.bodyLarge!.apply(color: TColors.primary),
          ),
        ),
        DataCell(Text(order.formattedOrderDate)),
        const DataCell(Text('Gaming Time')),
        DataCell(
          TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(
              vertical: TSizes.sm,
              horizontal: TSizes.md,
            ),
            backgroundColor: THelperFunctions.getOrderStatusColor(
              order.status,
            ).withOpacity(0.1),
            child: Text(
              order.status.name.capitalize.toString(),
              style: TextStyle(
                color: THelperFunctions.getOrderStatusColor(order.status),
              ),
            ),
          ),
        ),
        DataCell(
          TTableActionButtons(
            edit: true,
            onEditPressed: () {},
            onDeletePressed: () {},
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 5;

  @override
  int get selectedRowCount => 0;
}
