import 'package:dashboard/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/features/stream/controllers/server/server_controller.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ServersRows extends DataTableSource {
  final ServerController controller = Get.find();

  @override
  DataRow? getRow(int index) {
    if (index >= controller.servers.length) return null;
    final server = controller.servers[index];

    return DataRow2(
      cells: [
        DataCell(
          TRoundedImage(
            width: 180,
            height: 100,
            padding: TSizes.sm,
            image: server.imageUrl,
            imageType: ImageType.network,
            borderRadius: TSizes.borderRadiusMd,
            backgroundColor: TColors.primaryBackground,
          ),
        ),
        DataCell(Text(server.server_id)),
        DataCell(Text(server.target)),
        DataCell(Text(server.storageUsedBytes)),

        DataCell(
          IconButton(
            icon: Icon(
              server.active ? Iconsax.eye : Iconsax.eye_slash,
              color: TColors.primary,
            ),
            onPressed: () async {
              await controller.toggleServerActiveStatus(
                server.id,
                !server.active,
              );
            },
          ),
        ),

        DataCell(
          TTableActionButtons(
            onEditPressed:
                () => Get.toNamed(TRoutes.editServer, arguments: server),
            onDeletePressed: () async {
              await controller.deleteServerById(server.id);
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.servers.length;

  @override
  int get selectedRowCount => 0;
}
