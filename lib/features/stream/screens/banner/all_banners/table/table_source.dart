import 'package:dashboard/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/features/stream/controllers/banner/bannercontroller.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BannersRows extends DataTableSource {
  final BannerController controller = Get.find();

  @override
  DataRow? getRow(int index) {
    if (index >= controller.banners.length) return null;
    final banner = controller.banners[index];

    return DataRow2(
      cells: [
        DataCell(
          TRoundedImage(
            width: 180,
            height: 100,
            padding: TSizes.sm,
            image: banner.imageUrl,
            imageType: ImageType.network,
            borderRadius: TSizes.borderRadiusMd,
            backgroundColor: TColors.primaryBackground,
          ),
        ),
        DataCell(Text(banner.target)),
        DataCell(
          IconButton(
            icon: Icon(
              banner.active ? Iconsax.eye : Iconsax.eye_slash,
              color: TColors.primary,
            ),
            onPressed: () async {
              await controller.toggleBannerActiveStatus(
                banner.id,
                !banner.active,
              );
            },
          ),
        ),

        DataCell(
          TTableActionButtons(
            onEditPressed:
                () => Get.toNamed(TRoutes.editBanner, arguments: banner),
            onDeletePressed: () async {
              await controller.deleteBannerById(banner.id);
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.banners.length;

  @override
  int get selectedRowCount => 0;
}
