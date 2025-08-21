import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/features/stream/models/reports_model.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/utils/helpers/helper_functions.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportRows extends DataTableSource {
  final report = ReportModel(
    id: 'r001',
    fullName: 'John Doe',
    date: DateTime.now(),
    totalOrders: 5,
    email: 'john@example.com',
    totalSpent: 2563.50,
    status: OrderStatus.active,
  );
  @override
  DataRow? getRow(int index) {
    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              const TRoundedImage(
                width: 50,
                height: 50,
                padding: TSizes.sm,
                image: TImages.defaultImage,
                imageType: ImageType.network,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  'Wrong Episode',
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge!.apply(color: TColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const DataCell(Text('HDJTCFxMUmiQdsKnN9Ne')),
        const DataCell(Text('@uid_1')),
        const DataCell(Text('hiii')),
        DataCell(
          TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(
              vertical: TSizes.sm,
              horizontal: TSizes.md,
            ),
            backgroundColor: THelperFunctions.getOrderStatusColor(
              report.status,
            ).withOpacity(0.1),
            child: Text(
              report.status.name.capitalize.toString(),
              style: TextStyle(
                color: THelperFunctions.getOrderStatusColor(report.status),
              ),
            ),
          ),
        ),
        DataCell(Text(DateTime.now().toString())),
        DataCell(
          TTableActionButtons(
            view: true,
            edit: true,
            onViewPressed:
                () => Get.toNamed(
                  TRoutes.reportdetails,
                  arguments: ReportModel(
                    id: 'r001',
                    fullName: 'John Doe',
                    date: DateTime.now(),
                    totalOrders: 5,
                    email: 'john@example.com',
                    totalSpent: 2563.50,
                    status: OrderStatus.active,
                  ),
                ),
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
  int get rowCount => 10;

  @override
  int get selectedRowCount => 0;
}
